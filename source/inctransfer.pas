{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1.1 * Environment characteristics editor                       | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
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
function download(remotefile, localfile: string): boolean;
var
  Process1: TProcess;
begin
  download:=true;
  Process1:=TProcess.Create(nil);
  Process1.Executable:=scp;
  Process1.Parameters.Add('-B');
  Process1.Parameters.Add('-q');
  Process1.Parameters.Add(remotefile);
  Process1.Parameters.Add(localfile);
  Process1.Options:=[poWaitOnExit];
  try
    Process1.Execute;
  except
    download:=false;
  end;
  if Process1.ExitStatus<>0 then download:=false;
  Process1.Free;
end;

// upload a file to remote unit
function upload(localfile, remotefile: string): boolean;
var
  Process2: TProcess;
begin
  upload:=true;
  Process2:=TProcess.Create(nil);
  Process2.Executable:=scp;
  Process2.Parameters.Add('-B');
  Process2.Parameters.Add('-q');
  Process2.Parameters.Add(localfile);
  Process2.Parameters.Add(remotefile);
  Process2.Options:=[poWaitOnExit];
  try
    Process2.Execute;
  except
    upload:=false;
  end;
  if Process2.ExitStatus<>0 then upload:=false;
  Process2.Free;
end;
