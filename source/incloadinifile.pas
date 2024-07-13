{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.3 * Environment characteristic editor for MMxD devices         | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | incloadinifile.pas                                                       | }
{ | Load ini file                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// load values from ini file
function loadinifile(filename: string): boolean;
var
  b: byte;
  ini: TINIFile;
const
  SECTION0: string = 'common';
  SECTION1: string = 'hyphae';
  SECTION2: string = 'mushroom';

  function c2b(c: string): boolean;
  begin
    if c = '0' then
      c2b := False
    else
      c2b := True;
  end;

begin
  loadinifile := True;
  ini := TIniFile.Create(filename);
  try
    // page #2
    spineditvalues[2, 1] := StrToInt(ini.ReadString(SECTION1, 'humidity_min', '0'));
    spineditvalues[2, 2] := StrToInt(ini.ReadString(SECTION1, 'humidifier_on', '0'));
    spineditvalues[2, 3] := StrToInt(ini.ReadString(SECTION1, 'humidifier_off', '0'));
    spineditvalues[2, 4] := StrToInt(ini.ReadString(SECTION1, 'humidity_max', '0'));
    for b := 0 to 23 do
    begin
      s := 'humidifier_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[2, b] := c2b(ini.ReadString(SECTION1, s, '0'));
    end;
    // page #3
    spineditvalues[3, 1] := StrToInt(ini.ReadString(SECTION1, 'temperature_min', '0'));
    spineditvalues[3, 2] := StrToInt(ini.ReadString(SECTION1, 'heater_on', '0'));
    spineditvalues[3, 3] := StrToInt(ini.ReadString(SECTION1, 'heater_off', '0'));
    spineditvalues[3, 4] := StrToInt(ini.ReadString(SECTION1, 'temperature_max', '0'));
    for b := 0 to 23 do
    begin
      s := 'heater_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[3, b] := c2b(ini.ReadString(SECTION1, s, '0'));
    end;
    // page #4
    spineditvalues[4, 1] := StrToInt(ini.ReadString(SECTION1, 'light_on1', '0'));
    spineditvalues[4, 2] := StrToInt(ini.ReadString(SECTION1, 'light_off1', '0'));
    spineditvalues[4, 3] := StrToInt(ini.ReadString(SECTION1, 'light_on2', '0'));
    spineditvalues[4, 4] := StrToInt(ini.ReadString(SECTION1, 'light_off2', '0'));
    // page #5
    spineditvalues[5, 1] := StrToInt(ini.ReadString(SECTION1, 'vent_on', '0'));
    spineditvalues[5, 2] := StrToInt(ini.ReadString(SECTION1, 'vent_off', '0'));
//    spineditvalues[5, 3] := StrToInt(ini.ReadString(SECTION0, 'gasconcentrate_max', '0'));
    for b := 0 to 23 do
    begin
      s := 'vent_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[5, b] := c2b(ini.ReadString(SECTION1, s, '0'));
    end;
    // page #6
    spineditvalues[6, 1] := StrToInt(ini.ReadString(SECTION1, 'vent_lowtemp', '0'));
    for b := 0 to 23 do
    begin
      s := 'vent_disablelowtemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[6, b] := c2b(ini.ReadString(SECTION1, s, '0'));
    end;
    // page #7
    spineditvalues[7, 1] := StrToInt(ini.ReadString(SECTION1, 'vent_hightemp', '0'));
    for b := 0 to 23 do
    begin
      s := 'vent_disablehightemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[7, b] := c2b(ini.ReadString(SECTION1, s, '0'));
    end;
    // page #9
    spineditvalues[9, 1] := StrToInt(ini.ReadString(SECTION2, 'humidity_min', '0'));
    spineditvalues[9, 2] := StrToInt(ini.ReadString(SECTION2, 'humidifier_on', '0'));
    spineditvalues[9, 3] := StrToInt(ini.ReadString(SECTION2, 'humidifier_off', '0'));
    spineditvalues[9, 4] := StrToInt(ini.ReadString(SECTION2, 'humidity_max', '0'));
    for b := 0 to 23 do
    begin
      s := 'humidifier_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[9, b] := c2b(ini.ReadString(SECTION2, s, '0'));
    end;
    // page #10
    spineditvalues[10, 1] := StrToInt(ini.ReadString(SECTION2, 'temperature_min', '0'));
    spineditvalues[10, 2] := StrToInt(ini.ReadString(SECTION2, 'heater_on', '0'));
    spineditvalues[10, 3] := StrToInt(ini.ReadString(SECTION2, 'heater_off', '0'));
    spineditvalues[10, 4] := StrToInt(ini.ReadString(SECTION2, 'temperature_max', '0'));
    for b := 0 to 23 do
    begin
      s := 'heater_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[10, b] := c2b(ini.ReadString(SECTION2, s, '0'));
    end;
    // page #11
    spineditvalues[11, 1] := StrToInt(ini.ReadString(SECTION2, 'light_on1', '0'));
    spineditvalues[11, 2] := StrToInt(ini.ReadString(SECTION2, 'light_off1', '0'));
    spineditvalues[11, 3] := StrToInt(ini.ReadString(SECTION2, 'light_on2', '0'));
    spineditvalues[11, 4] := StrToInt(ini.ReadString(SECTION2, 'light_off2', '0'));
    // page #12
    spineditvalues[12, 1] := StrToInt(ini.ReadString(SECTION2, 'vent_on', '0'));
    spineditvalues[12, 2] := StrToInt(ini.ReadString(SECTION2, 'vent_off', '0'));
    spineditvalues[12, 3] := spineditvalues[5, 3];
    for b := 0 to 23 do
    begin
      s := 'vent_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[12, b] := c2b(ini.ReadString(SECTION2, s, '0'));
    end;
    // page #13
    spineditvalues[13, 1] := StrToInt(ini.ReadString(SECTION2, 'vent_lowtemp', '0'));
    for b := 0 to 23 do
    begin
      s := 'vent_disablelowtemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[13, b] := c2b(ini.ReadString(SECTION2, s, '0'));
    end;
    // page #14
    spineditvalues[14, 1] := StrToInt(ini.ReadString(SECTION2, 'vent_hightemp', '0'));
    for b := 0 to 23 do
    begin
      s := 'vent_disablehightemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b);
      checkgroupvalue[14, b] := c2b(ini.ReadString(SECTION2, s, '0'));
    end;
  except
    loadinifile := False;
  end;
  ini.Free;
end;

