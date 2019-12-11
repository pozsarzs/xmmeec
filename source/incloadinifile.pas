{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | incloadinifile.pas                                                       | }
{ | Load ini file                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// load values from ini file
function loadinifile(filename: string): boolean;
var
  b: byte;
  ini: TINIFile;
const
  SECTION1: string='hyphae';
  SECTION2: string='mushroom';

  function c2b(c: string): boolean;
  begin
    if c='0' then c2b:=false else c2b:=true
  end;

begin
  loadinifile:=true;
  ini:=TIniFile.Create(filename);
  try
    spineditvalues[1,1]:=strtoint(ini.ReadString(SECTION1,'humidity_min','0'));
    spineditvalues[1,2]:=strtoint(ini.ReadString(SECTION1,'humidifier_on','0'));
    spineditvalues[1,3]:=strtoint(ini.ReadString(SECTION1,'humidifier_off','0'));
    spineditvalues[1,4]:=strtoint(ini.ReadString(SECTION1,'humidity_max','0'));
    for b:=0 to 23 do
    begin
      s:='humidifier_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[1,b]:=c2b(ini.ReadString(SECTION1,s,'0'));
    end;
    spineditvalues[2,1]:=strtoint(ini.ReadString(SECTION1,'temperature_min','0'));
    spineditvalues[2,2]:=strtoint(ini.ReadString(SECTION1,'heater_on','0'));
    spineditvalues[2,3]:=strtoint(ini.ReadString(SECTION1,'heater_off','0'));
    spineditvalues[2,4]:=strtoint(ini.ReadString(SECTION1,'temperature_max','0'));
    for b:=0 to 23 do
    begin
      s:='heater_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[2,b]:=c2b(ini.ReadString(SECTION1,s,'0'));
    end;
    spineditvalues[3,1]:=strtoint(ini.ReadString(SECTION1,'light_on1','0'));
    spineditvalues[3,2]:=strtoint(ini.ReadString(SECTION1,'light_off1','0'));
    spineditvalues[3,3]:=strtoint(ini.ReadString(SECTION1,'light_on2','0'));
    spineditvalues[3,4]:=strtoint(ini.ReadString(SECTION1,'light_off2','0'));
    spineditvalues[4,1]:=strtoint(ini.ReadString(SECTION1,'vent_on','0'));
    spineditvalues[4,2]:=strtoint(ini.ReadString(SECTION1,'vent_off','0'));
    for b:=0 to 23 do
    begin
      s:='vent_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[4,b]:=c2b(ini.ReadString(SECTION1,s,'0'));
    end;
    spineditvalues[5,1]:=strtoint(ini.ReadString(SECTION1,'vent_lowtemp','0'));
    for b:=0 to 23 do
    begin
      s:='vent_disablelowtemp_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[5,b]:=c2b(ini.ReadString(SECTION1,s,'0'));
    end;
    spineditvalues[7,1]:=strtoint(ini.ReadString(SECTION2,'humidity_min','0'));
    spineditvalues[7,2]:=strtoint(ini.ReadString(SECTION2,'humidifier_on','0'));
    spineditvalues[7,3]:=strtoint(ini.ReadString(SECTION2,'humidifier_off','0'));
    spineditvalues[7,4]:=strtoint(ini.ReadString(SECTION2,'humidity_max','0'));
    for b:=0 to 23 do
    begin
      s:='humidifier_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[7,b]:=c2b(ini.ReadString(SECTION2,s,'0'));
    end;
    spineditvalues[8,1]:=strtoint(ini.ReadString(SECTION2,'temperature_min','0'));
    spineditvalues[8,2]:=strtoint(ini.ReadString(SECTION2,'heater_on','0'));
    spineditvalues[8,3]:=strtoint(ini.ReadString(SECTION2,'heater_off','0'));
    spineditvalues[8,4]:=strtoint(ini.ReadString(SECTION2,'temperature_max','0'));
    for b:=0 to 23 do
    begin
      s:='heater_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[8,b]:=c2b(ini.ReadString(SECTION2,s,'0'));
    end;
    spineditvalues[9,1]:=strtoint(ini.ReadString(SECTION2,'light_on1','0'));
    spineditvalues[9,2]:=strtoint(ini.ReadString(SECTION2,'light_off1','0'));
    spineditvalues[9,3]:=strtoint(ini.ReadString(SECTION2,'light_on2','0'));
    spineditvalues[9,4]:=strtoint(ini.ReadString(SECTION2,'light_off2','0'));
    spineditvalues[10,1]:=strtoint(ini.ReadString(SECTION2,'vent_on','0'));
    spineditvalues[10,2]:=strtoint(ini.ReadString(SECTION2,'vent_off','0'));
    for b:=0 to 23 do
    begin
      s:='vent_disable_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[10,b]:=c2b(ini.ReadString(SECTION2,s,'0'));
    end;
    spineditvalues[11,1]:=strtoint(ini.ReadString(SECTION2,'vent_lowtemp','0'));
    for b:=0 to 23 do
    begin
      s:='vent_disablelowtemp_';
      if b<10 then s:=s+'0';
      s:=s+inttostr(b);
      checkgroupvalue[11,b]:=c2b(ini.ReadString(SECTION2,s,'0'));
    end;
  except
    loadinifile:=false;
  end;
  ini.Free;
end;
