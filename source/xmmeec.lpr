{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | xmmeec.lpr                                                               | }
{ | Project file                                                             | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

program xmmeec;
{$MODE OBJFPC}{$H+}
uses
  Interfaces, Forms, {$IFDEF UseFHS} unttranslator, {$ELSE}
  DefaultTranslator,{$ENDIF} Dialogs, SysUtils, frmmain, crt;
var
  b: byte;
  fn: string;
  opmode: byte;
const
  params: array[1..2,1..3] of string=
  (
    ('-h','--help','show help'),
    ('-v','--version','show version and build information')
  );

{$I config.pas}
{$R *.res}

procedure help(mode: boolean);
var
  b: byte;
begin
  if mode then
    showmessage('There are one or more bad parameters in command line.') else
    begin
     {$IFDEF UNIX}
      writeln('Usage:');
      writeln(' ',fn,{$IFDEF WIN32}'.',fe,{$ENDIF}' [parameter]');
      writeln;
      writeln('parameters:');
      for b:=1 to 3 do
      begin
        write('  ',params[b,1]);
        gotoxy(8,wherey); write(params[b,2]);
        gotoxy(30,wherey); writeln(params[b,3]);
      end;
      writeln;
     {$ENDIF}
     {$IFDEF WIN32}
      s:='Usage:'+#13+#10;
      s:=s+' '+fn+' [parameter]'+#13+#10+#13+#10;
      s:=s+'parameters:';
      for b:=1 to 3 do
        s:=s+#13+#10+'  '+params[b,1]+', '+params[b,2]+': '+params[b,3];
      showmessage(s);
     {$ENDIF}
    end;
  halt(0);
end;

procedure verinfo;
begin
 {$IFDEF UNIX}
  writeln(APPNAME+' v'+VERSION);
  writeln;
  writeln('This application was compiled at ',{$I %TIME%},' on ',{$I %DATE%},' by ',{$I %USER%});
  writeln('FPC version: ',{$I %FPCVERSION%});
  writeln('Target OS:   ',{$I %FPCTARGETOS%});
  writeln('Target CPU:  ',{$I %FPCTARGETCPU%});
 {$ENDIF}
 {$IFDEF WIN32}
  s:=untcommonproc.APPNAME+' v'+untcommonproc.VERSION+#13+#10+#13+#10;
  s:=s+'This was compiled at '+{$I %TIME%}+' on '+{$I %DATE%}+' by '+{$I %USERNAME%}+'.'+#13+#10+#13+#10;
  s:=s+'FPC version: '+{$I %FPCVERSION%}+#13+#10;
  s:=s+'Target OS:   '+{$I %FPCTARGETOS%}+#13+#10;
  s:=s+'Target CPU:  '+{$I %FPCTARGETCPU%};
  showmessage(s);
 {$ENDIF}
  halt(0);
end;

begin
  fn:=extractfilename(paramstr(0));
  opmode:=0;
  if length(paramstr(1))=0 then opmode:=1 else
  begin
    for b:=1 to 2 do
      if paramstr(1)=params[b,1] then opmode:=10*b;
    for b:=1 to 2 do
      if paramstr(1)=params[b,2] then opmode:=10*b;
  end;
  case opmode of
     0: help(true);
    10: help(false);
    20: verinfo;
  end;
  Application.Title:='XMMEEC';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
