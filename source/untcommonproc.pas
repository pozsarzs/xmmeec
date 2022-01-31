{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.2 * Environment characteristic editor                          | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | untcommonproc.pas                                                        | }
{ | Common functions and procedures                                          | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit untcommonproc; 
{$MODE OBJFPC}{$H-}
interface
uses
  Classes,
  Dialogs,
  INIFiles,
  LResources,
  SysUtils,
 {$IFDEF WIN32}Windows,{$ENDIF}
  dos;
var
  dev_chan:   array[1..32] of byte;
  dev_name:   array[1..32] of string;
  dev_port:   array[1..32] of integer;
  dev_type:   array[1..32] of string;
  dev_user:   array[1..32] of string;
  exepath, p: shortstring;
  lang:       string[2];
  scp:        string;
  ssh:        string;
  s:          string;
  userdir:    string;
{$IFDEF WIN32}
const
  CSIDL_PROFILE=40;
  SHGFP_TYPE_CURRENT=0;
{$ENDIF}

{$I config.pas}

function getexepath: string;
function getlang: string;
function loadconfig(filename: string): boolean;
procedure makeuserdir;

{$IFDEF WIN32}
function SHGetFolderPath(hwndOwner: HWND; nFolder: Integer; hToken: THandle;
         dwFlags: DWORD; pszPath: LPTSTR): HRESULT; stdcall;
         external 'Shell32.dll' name 'SHGetFolderPathA';
{$ENDIF}

Resourcestring
  MESSAGE01='Cannot read configuration file!';
  MESSAGE02='Cannot write configuration file!';

implementation

// get executable path
function getexepath: string;
begin
  fsplit(paramstr(0),exepath,p,p);
  getexepath:=exepath;
end;

// get language
function getlang: string;
{$IFDEF WIN32}
var
  buffer: pchar;
  size:   integer;
{$ENDIF}
begin
 {$IFDEF UNIX}
  s:=getenv('LANG');
 {$ENDIF}
 {$IFDEF WIN32}
  size:=getlocaleinfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
  getmem(buffer, size);
  try
    getlocaleinfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, buffer, size);
    s:=string(buffer);
  finally
    freemem(buffer);
  end;
 {$ENDIF}
  if length(s)=0 then s:='en';
  lang:=lowercase(s[1..2]);
  getlang:=lang;
end;

// load condfiguration file
function loadconfig(filename: string): boolean;
var
  b:   byte;
  iif: TINIFile;
begin
  iif:=TIniFile.Create(filename);
  loadconfig:=true;
  try
    scp:=iif.ReadString('programs','scp','/usr/bin/scp');
    ssh:=iif.ReadString('programs','ssh','/usr/bin/ssh');
    for b:=1 to 32 do
    begin
      dev_chan[b]:=iif.ReadInteger('device-'+inttostr(b),'chan',0);
      dev_name[b]:=iif.ReadString('device-'+inttostr(b),'name','');
      dev_port[b]:=iif.ReadInteger('device-'+inttostr(b),'port',22);
      dev_type[b]:=iif.ReadString('device-'+inttostr(b),'type','');
      dev_user[b]:=iif.ReadString('device-'+inttostr(b),'user','');
    end;
  except
    loadconfig:=false;
  end;
  iif.Free;
end;

// make users directory
procedure makeuserdir;
{$IFDEF WIN32}
var
  buffer: array[0..MAX_PATH] of char;

  function getuserprofile: string;
  begin
    fillchar(buffer, sizeof(buffer), 0);
    ShGetFolderPath(0, CSIDL_PROFILE, 0, SHGFP_TYPE_CURRENT, buffer);
    result:=string(pchar(@buffer));
  end;

  function GetWindowsTemp: string;
  begin  
    fillchar(buffer,MAX_PATH+1, 0);
    GetTempPath(MAX_PATH, buffer);
    result:=string(pchar(@buffer));
    if result[length(result)]<>'\' then result:=result+'\';
  end;
{$ENDIF}

begin
 {$IFDEF UNIX}
  userdir:=getenvironmentvariable('HOME');
 {$ENDIF}
 {$IFDEF WIN32}
  userdir:=getuserprofile;
 {$ENDIF}
  forcedirectories(userdir+DIR_CACHE);
  forcedirectories(userdir+DIR_CONFIG);
end;

end.

