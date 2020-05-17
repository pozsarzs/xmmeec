{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1.2 * Environment characteristics editor                       | }
{ | Copyright (C) 2019-2020 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>    | }
{ | incsaveinifile.pas                                                       | }
{ | Save ini file                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// save values to ini file
function saveinifile(filename: string): boolean;
var
  b: byte;
  iif: text;
  s: string;
const
  HEADER1='; +----------------------------------------------------------------------------+';
  HEADER2='; | XMMEEC v0.1.2 * Environment characteristics editor                         |';
  HEADER3='; | Copyright (C) 2019-2020 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>      |';
  HEADER4='; | envir.ini                                                                  |';
  HEADER5='; | growing environment characteristics                                        |';

  function b2c(b: boolean): char;
  begin
    if b then b2c:='1' else b2c:='0';
  end;

begin
  saveinifile:=true;
  try
    assign(iif,filename);
    rewrite(iif);
    writeln(iif,HEADER1);
    writeln(iif,HEADER2);
    writeln(iif,HEADER3);
    writeln(iif,HEADER4);
    writeln(iif,HEADER5);
    writeln(iif,HEADER1);
    writeln(iif,'');
    writeln(iif,'[hyphae]');
    writeln(iif,'; humidifier');
    writeln(iif,'humidity_min=',inttostr(spineditvalues[1,1]));
    writeln(iif,'humidifier_on=',inttostr(spineditvalues[1,2]));
    writeln(iif,'humidifier_off=',inttostr(spineditvalues[1,3]));
    writeln(iif,'humidity_max=',inttostr(spineditvalues[1,4]));
    for b:=0 to 23 do
    begin
      s:='humidifier_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[1,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    writeln(iif,'; heaters');
    writeln(iif,'temperature_min=',inttostr(spineditvalues[2,1]));
    writeln(iif,'heater_on=',inttostr(spineditvalues[2,2]));
    writeln(iif,'heater_off=',inttostr(spineditvalues[2,3]));
    writeln(iif,'temperature_max=',inttostr(spineditvalues[2,4]));
    for b:=0 to 23 do
    begin
      s:='heater_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[2,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    writeln(iif,'; lights');
    writeln(iif,'light_on1=',inttostr(spineditvalues[3,1]));
    writeln(iif,'light_off1=',inttostr(spineditvalues[3,2]));
    writeln(iif,'light_on2=',inttostr(spineditvalues[3,3]));
    writeln(iif,'light_off2=',inttostr(spineditvalues[3,4]));
    writeln(iif,'');
    writeln(iif,'; ventillators');
    writeln(iif,'vent_on=',inttostr(spineditvalues[4,1]));
    writeln(iif,'vent_off=',inttostr(spineditvalues[4,2]));
    for b:=0 to 23 do
    begin
      s:='vent_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[4,b]);
      writeln(iif,s);
    end;
    writeln(iif,'vent_lowtemp=',inttostr(spineditvalues[5,1]));
    for b:=0 to 23 do
    begin
      s:='vent_disablelowtemp_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[5,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    writeln(iif,'[mushroom]');
    writeln(iif,'; humidifier');
    writeln(iif,'humidity_min=',inttostr(spineditvalues[7,1]));
    writeln(iif,'humidifier_on=',inttostr(spineditvalues[7,2]));
    writeln(iif,'humidifier_off=',inttostr(spineditvalues[7,3]));
    writeln(iif,'humidity_max=',inttostr(spineditvalues[7,4]));
    for b:=0 to 23 do
    begin
      s:='humidifier_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[7,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    writeln(iif,'; heaters');
    writeln(iif,'temperature_min=',inttostr(spineditvalues[8,1]));
    writeln(iif,'heater_on=',inttostr(spineditvalues[8,2]));
    writeln(iif,'heater_off=',inttostr(spineditvalues[8,3]));
    writeln(iif,'temperature_max=',inttostr(spineditvalues[8,4]));
    for b:=0 to 23 do
    begin
      s:='heater_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[8,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    writeln(iif,'; lights');
    writeln(iif,'light_on1=',inttostr(spineditvalues[9,1]));
    writeln(iif,'light_off1=',inttostr(spineditvalues[9,2]));
    writeln(iif,'light_on2=',inttostr(spineditvalues[9,3]));
    writeln(iif,'light_off2=',inttostr(spineditvalues[9,4]));
    writeln(iif,'');
    writeln(iif,'; ventillators');
    writeln(iif,'vent_on=',inttostr(spineditvalues[10,1]));
    writeln(iif,'vent_off=',inttostr(spineditvalues[10,2]));
    for b:=0 to 23 do
    begin
      s:='vent_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[10,b]);
      writeln(iif,s);
    end;
    writeln(iif,'vent_lowtemp=',inttostr(spineditvalues[11,1]));
    for b:=0 to 23 do
    begin
      s:='vent_disablelowtemp_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b)+'='+b2c(checkgroupvalue[11,b]);
      writeln(iif,s);
    end;
    writeln(iif,'');
    close(iif);
  except
    saveinifile:=false;
  end;
end;
