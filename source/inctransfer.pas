{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.3 * Environment characteristic editor for MMxD devices         | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | inctransfer.pas                                                          | }
{ | File transfer                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// get override status
function getoverride(num: integer): string;
var
  Process4: TProcess;
  stdout: TStringList;
  b: byte;
begin
  stdout := Tstringlist.Create;
  Process4 := TProcess.Create(nil);
  Process4.Executable := ssh;
  Process4.Parameters.Clear;
  Process4.Parameters.Add('-q');
  Process4.Parameters.Add('-p ' + IntToStr(dev_port[num + 1]));
  Process4.Parameters.Add(dev_user[num + 1]);
  Process4.Parameters.Add('xmmeec-getoverride ' + dev_type[num + 1] + ' ' +
    IntToStr(dev_chan[num + 1]));
  Process4.Options := [poWaitOnExit, poUsePipes];
  try
    Process4.Execute;
    stdout.LoadFromStream(Process4.Output);
  except
    Result := '';
  end;
  if Process4.ExitStatus <> 0 then
    Result := '';
  Process4.Free;
  for b := 0 to stdout.Count-1 do
  begin
    case stdout[b] of
    'off': result := result+'0';
    'neutral': result := result+'1';
    'on': result := result+'2';
    end;
  end;
  stdout.Free;
end;

// set output override
function setoverride(num: integer; status1, status2, status3, status4: integer): boolean;
var
  Process3: TProcess;
  status: string;
begin
  setoverride := True;
  status := IntToStr(status1) + ' ' + IntToStr(status2) + ' ' + IntToStr(status3) +
    ' ' + IntToStr(status4) + ' ';
  Process3 := TProcess.Create(nil);
  Process3.Executable := ssh;
  Process3.Parameters.Clear;
  Process3.Parameters.Add('-q');
  Process3.Parameters.Add('-p ' + IntToStr(dev_port[num + 1]));
  Process3.Parameters.Add(dev_user[num + 1]);
  Process3.Parameters.Add('xmmeec-setoverride ' + dev_type[num + 1] + ' ' +
   IntToStr(dev_chan[num + 1]) + ' ' + status);
  Process3.Options := [poWaitOnExit];
  try
    Process3.Execute;
  except
    setoverride := False;
  end;
  if Process3.ExitStatus <> 0 then
    setoverride := False;
  Process3.Free;
end;

// download a file from remote unit
function download(num: integer; localfile: string): boolean;
var
  Process1: TProcess;
begin
  download := True;
  Process1 := TProcess.Create(nil);
  Process1.Executable := ssh;
  Process1.Parameters.Clear;
  Process1.Parameters.Add('-q');
  Process1.Parameters.Add('-p ' + IntToStr(dev_port[num + 1]));
  Process1.Parameters.Add(dev_user[num + 1]);
  Process1.Parameters.Add('xmmeec-download ' + dev_type[num + 1] + ' ' +
    IntToStr(dev_chan[num + 1]));
  Process1.Options := [poWaitOnExit];
  try
    Process1.Execute;
  except
    download := False;
    Process1.Free;
    exit;
  end;
  if Process1.ExitStatus <> 0 then
  begin
    download := False;
    Process1.Free;
    exit;
  end;
  Process1.Free;
  Process1 := TProcess.Create(nil);
  Process1.Executable := scp;
  Process1.Parameters.Add('-B');
  Process1.Parameters.Add('-q');
  Process1.Parameters.Add('-P ' + IntToStr(dev_port[num + 1]));
  if dev_chan[num + 1] = 0 then
    Process1.Parameters.Add(dev_user[num + 1] + ':/tmp/etc/envir.ini')
  else
    Process1.Parameters.Add(dev_user[num + 1] + ':/tmp/etc/envir-ch' +
      IntToStr(dev_chan[num + 1]) + '.ini');
  Process1.Parameters.Add(localfile);
  Process1.Options := [poWaitOnExit];
  try
    Process1.Execute;
  except
    download := False;
    Process1.Free;
    exit;
  end;
  if Process1.ExitStatus <> 0 then
    download := False;
  Process1.Free;
end;

// upload a file to remote unit
function upload(num: integer; localfile: string): boolean;
var
  Process2: TProcess;
begin
  upload := True;
  Process2 := TProcess.Create(nil);
  Process2.Executable := scp;
  Process2.Parameters.Add('-B');
  Process2.Parameters.Add('-q');
  Process2.Parameters.Add('-P ' + IntToStr(dev_port[num + 1]));
  Process2.Parameters.Add(localfile);
  if dev_chan[num + 1] = 0 then
    Process2.Parameters.Add(dev_user[num + 1] + ':/tmp/etc/envir.ini')
  else
    Process2.Parameters.Add(dev_user[num + 1] + ':/tmp/etc/envir-ch' +
      IntToStr(dev_chan[num + 1]) + '.ini');
  Process2.Options := [poWaitOnExit];
  try
    Process2.Execute;
  except
    upload := False;
    Process2.Free;
    exit;
  end;
  if Process2.ExitStatus <> 0 then
  begin
    upload := False;
    Process2.Free;
    exit;
  end;
  Process2.Free;
  Process2 := TProcess.Create(nil);
  Process2.Executable := ssh;
  Process2.Parameters.Clear;
  Process2.Parameters.Add('-q');
  Process2.Parameters.Add('-p ' + IntToStr(dev_port[num + 1]));
  Process2.Parameters.Add(dev_user[num + 1]);
  Process2.Parameters.Add('xmmeec-upload ' + dev_type[num + 1] + ' ' +
    IntToStr(dev_chan[num + 1]));
  Process2.Options := [poWaitOnExit];
  try
    Process2.Execute;
  except
    upload := False;
  end;
  if Process2.ExitStatus <> 0 then
    upload := False;
  Process2.Free;
end;

