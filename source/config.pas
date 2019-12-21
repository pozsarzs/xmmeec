{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | config.pas(.in)                                                          | }
{ | Setting for source code                                                  | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

const
  APPNAME='XMMEEC';
  VERSION='0.1.1';
  // install path
  INSTPATH='/usr/';
  {$IFDEF UseFHS}
    MYI18PATH='/usr/share/locale/';
  {$ELSE}
    {$IFDEF UNIX}
      MYI18PATH='/languages/';
    {$ENDIF}
    {$IFDEF WIN32}
      MYI18PATH='\languages\';
    {$ENDIF}
  {$ENDIF}
  // user's folders
  {$IFDEF UNIX}
    DIR_CACHE='/.cache/xmmeec/';
    DIR_CONFIG='/.config/xmmeec/';
  {$ENDIF}
  {$IFDEF WIN32}
    DIR_CACHE='\AppData\Local\xmmeec\cache\';
    DIR_CONFIG='\AppData\Local\xmmeec\config\';
  {$ENDIF}
  TMPFILE=DIR_CACHE+'xmmeec.tmp';
