{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.2 * Environment characteristic editor                          | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | inctransfer.pas                                                          | }
{ | File transfer                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// download a file from remote unit
function download(num: integer; localfile: string): boolean;
var
  Process1: TProcess;
begin
  download:=true;
  Process1:=TProcess.Create(nil);
  Process1.Executable:=ssh;
  Process1.Parameters.Clear;
  Process1.Parameters.Add('-q');
  Process1.Parameters.Add('-p '+inttostr(dev_port[num+1]));
  Process1.Parameters.Add(dev_user[num+1]);
  if dev_chan[num+1]=0
  then
    Process1.Parameters.Add('xmmeec-download '+dev_type[num+1])
  else
    Process1.Parameters.Add('xmmeec-download '+dev_type[num+1]+' '+inttostr(dev_chan[num+1]));
  Process1.Options:=[poWaitOnExit];
  try
    Process1.Execute;
  except
    download:=false;
    Process1.Free;
    exit;
  end;
  if Process1.ExitStatus<>0 then
  begin
    download:=false;
    Process1.Free;
    exit;
  end;
  Process1.Free;
  Process1:=TProcess.Create(nil);
  Process1.Executable:=scp;
  Process1.Parameters.Add('-B');
  Process1.Parameters.Add('-q');
  Process1.Parameters.Add('-P '+inttostr(dev_port[num+1]));
  if dev_chan[num+1]=0
  then
    Process1.Parameters.Add(dev_user[num+1]+':/tmp/etc/envir.ini')
  else
    Process1.Parameters.Add(dev_user[num+1]+':/tmp/etc/envir-ch'+inttostr(dev_chan[num+1])+'.ini');
  Process1.Parameters.Add(localfile);
  Process1.Options:=[poWaitOnExit];
  try
    Process1.Execute;
  except
    download:=false;
    Process1.Free;
    exit;
  end;
  if Process1.ExitStatus<>0 then download:=false;
  Process1.Free;
end;

// upload a file to remote unit
function upload(num: integer; localfile: string): boolean;
var
  Process2: TProcess;
begin
  upload:=true;
  Process2:=TProcess.Create(nil);
  Process2.Executable:=scp;
  Process2.Parameters.Add('-B');
  Process2.Parameters.Add('-q');
  Process2.Parameters.Add('-P '+inttostr(dev_port[num+1]));
  Process2.Parameters.Add(localfile);
  if dev_chan[num+1]=0
  then
    Process2.Parameters.Add(dev_user[num+1]+':/tmp/etc/envir.ini')
  else
    Process2.Parameters.Add(dev_user[num+1]+':/tmp/etc/envir-ch'+inttostr(dev_chan[num+1])+'.ini');
  Process2.Options:=[poWaitOnExit];
  try
    Process2.Execute;
  except
    upload:=false;
    Process2.Free;
    exit;
  end;
  if Process2.ExitStatus<>0 then
  begin
    upload:=false;
    Process2.Free;
    exit;
  end;
  Process2.Free;
  Process2:=TProcess.Create(nil);
  Process2.Executable:=ssh;
  Process2.Parameters.Clear;
  Process2.Parameters.Add('-q');
  Process2.Parameters.Add('-p '+inttostr(dev_port[num+1]));
  Process2.Parameters.Add(dev_user[num+1]);
  if dev_chan[num+1]=0
  then
    Process2.Parameters.Add('xmmeec-upload '+dev_type[num+1])
  else
    Process2.Parameters.Add('xmmeec-upload '+dev_type[num+1]+' '+inttostr(dev_chan[num+1]));
  Process2.Options:=[poWaitOnExit];
  try
    Process2.Execute;
  except
    upload:=false;
  end;
  if Process2.ExitStatus<>0 then upload:=false;
  Process2.Free;
end;
