{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
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
  {$IFDEF WIN32}Windows,{$ENDIF} Classes, SysUtils, LResources, Dialogs,
  INIFiles, dos;
var
  exepath, p: shortstring;
  lang: string[2];
  s: string;
  tmpdir: string;
  userdir: string;
 {$IFDEF WIN32}
const
  CSIDL_PROFILE=40;
  SHGFP_TYPE_CURRENT=0;
 {$ENDIF}

{$I config.pas}

function getexepath: string;
function getlang: string;
procedure loadcfg(filename: string);
procedure makeuserdir;
procedure savecfg(filename: string);

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
end;

// get language
function getlang: string;
{$IFDEF WIN32}
var
  Buffer : PChar;
  Size : integer;
{$ENDIF}
begin
 {$IFDEF UNIX}
  s:=getenv('LANG');
 {$ENDIF}
 {$IFDEF WIN32}
  Size:=GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, nil, 0);
  GetMem(Buffer, Size);
  try
    GetLocaleInfo (LOCALE_USER_DEFAULT, LOCALE_SABBREVLANGNAME, Buffer, Size);
    s:=string(Buffer);
  finally
    FreeMem(Buffer);
  end;
 {$ENDIF}
  if length(s)=0 then s:='en';
  lang:=LowerCase(s[1..2]);
end;

// load configuration
procedure loadcfg(filename: string);
var
  ini: TINIFile;
begin
  ini:=TIniFile.Create(filename);
  try
    ini.Free;
  except
    ShowMessage(MESSAGE01+' '+filename);
  end;
end;

// make users directory
procedure makeuserdir;
{$IFDEF WIN32}
var
  buffer: array[0..MAX_PATH] of char;

  function GetUserProfile: string;
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
  tmpdir:='/tmp/';
  userdir:=getenvironmentvariable('HOME');
 {$ENDIF}
 {$IFDEF WIN32}
  tmpdir:=getwindowstemp;
  userdir:=getuserprofile;
 {$ENDIF}
 forcedirectories(userdir+DIR_CACHE);
 forcedirectories(userdir+DIR_CONFIG);
end;

// save configuration
procedure savecfg(filename: string);
var
  ini: TINIFile;
begin
  ini:=TIniFile.Create(filename);
  try
    ini.Free;
  except
    ShowMessage(MESSAGE02+' '+filename);
  end;
end;

end.

