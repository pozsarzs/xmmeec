{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.3 * Environment characteristic editor for MMxD devices         | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | incsaveinifile.pas                                                       | }
{ | Save ini file                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// save values to ini file
function saveinifile(filename: string): boolean;
var
  b: byte;
  iif: Text;
  s: string;
const
  HEADER1 = '; +----------------------------------------------------------------------------+';
  HEADER2 = '; | XMMEEC v0.3 * Environment characteristic editor for MMxD devices           |';
  HEADER3 = '; | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>       |';
  HEADER4 = '; | envir.ini                                                                  |';
  HEADER5 = '; | growing environment characteristics                                        |';

  function b2c(b: boolean): char;
  begin
    if b then
      b2c := '1'
    else
      b2c := '0';
  end;

begin
  saveinifile := True;
  try
    Assign(iif, filename);
    rewrite(iif);
    writeln(iif, HEADER1);
    writeln(iif, HEADER2);
    writeln(iif, HEADER3);
    writeln(iif, HEADER4);
    writeln(iif, HEADER5);
    writeln(iif, HEADER1);
    writeln(iif, '');
    writeln(iif, '[common]');
    writeln(iif, '; common parameters');
    writeln(iif, 'gasconcentrate_max=', IntToStr(spineditvalues[5, 3]));
    writeln(iif, '');
    writeln(iif, '[hyphae]');
    // page #2
    writeln(iif, '; humidifier');
    writeln(iif, 'humidity_min=', IntToStr(spineditvalues[2, 1]));
    writeln(iif, 'humidifier_on=', IntToStr(spineditvalues[2, 2]));
    writeln(iif, 'humidifier_off=', IntToStr(spineditvalues[2, 3]));
    writeln(iif, 'humidity_max=', IntToStr(spineditvalues[2, 4]));
    for b := 0 to 23 do
    begin
      s := 'humidifier_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[2, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    // page #3
    writeln(iif, '; heaters');
    writeln(iif, 'temperature_min=', IntToStr(spineditvalues[3, 1]));
    writeln(iif, 'heater_on=', IntToStr(spineditvalues[3, 2]));
    writeln(iif, 'heater_off=', IntToStr(spineditvalues[3, 3]));
    writeln(iif, 'temperature_max=', IntToStr(spineditvalues[3, 4]));
    for b := 0 to 23 do
    begin
      s := 'heater_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[3, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    // page #4
    writeln(iif, '; lights');
    writeln(iif, 'light_on1=', IntToStr(spineditvalues[4, 1]));
    writeln(iif, 'light_off1=', IntToStr(spineditvalues[4, 2]));
    writeln(iif, 'light_on2=', IntToStr(spineditvalues[4, 3]));
    writeln(iif, 'light_off2=', IntToStr(spineditvalues[4, 4]));
    writeln(iif, '');
    // page #5
    writeln(iif, '; ventillators');
    writeln(iif, 'vent_on=', IntToStr(spineditvalues[5, 1]));
    writeln(iif, 'vent_off=', IntToStr(spineditvalues[5, 2]));
    for b := 0 to 23 do
    begin
      s := 'vent_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[5, b]);
      writeln(iif, s);
    end;
    // page #6
    writeln(iif, 'vent_lowtemp=', IntToStr(spineditvalues[6, 1]));
    for b := 0 to 23 do
    begin
      s := 'vent_disablelowtemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[6, b]);
      writeln(iif, s);
    end;
    // page #7
    writeln(iif, 'vent_hightemp=', IntToStr(spineditvalues[7, 1]));
    for b := 0 to 23 do
    begin
      s := 'vent_disablehightemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[7, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    writeln(iif, '[mushroom]');
    // page #9
    writeln(iif, '; humidifier');
    writeln(iif, 'humidity_min=', IntToStr(spineditvalues[9, 1]));
    writeln(iif, 'humidifier_on=', IntToStr(spineditvalues[9, 2]));
    writeln(iif, 'humidifier_off=', IntToStr(spineditvalues[9, 3]));
    writeln(iif, 'humidity_max=', IntToStr(spineditvalues[9, 4]));
    for b := 0 to 23 do
    begin
      s := 'humidifier_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[9, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    // page #10
    writeln(iif, '; heaters');
    writeln(iif, 'temperature_min=', IntToStr(spineditvalues[10, 1]));
    writeln(iif, 'heater_on=', IntToStr(spineditvalues[10, 2]));
    writeln(iif, 'heater_off=', IntToStr(spineditvalues[10, 3]));
    writeln(iif, 'temperature_max=', IntToStr(spineditvalues[10, 4]));
    for b := 0 to 23 do
    begin
      s := 'heater_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[10, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    // page #11
    writeln(iif, '; lights');
    writeln(iif, 'light_on1=', IntToStr(spineditvalues[11, 1]));
    writeln(iif, 'light_off1=', IntToStr(spineditvalues[11, 2]));
    writeln(iif, 'light_on2=', IntToStr(spineditvalues[11, 3]));
    writeln(iif, 'light_off2=', IntToStr(spineditvalues[11, 4]));
    writeln(iif, '');
    // page #12
    writeln(iif, '; ventillators');
    writeln(iif, 'vent_on=', IntToStr(spineditvalues[12, 1]));
    writeln(iif, 'vent_off=', IntToStr(spineditvalues[12, 2]));
    for b := 0 to 23 do
    begin
      s := 'vent_disable_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[12, b]);
      writeln(iif, s);
    end;
    // page #13
    writeln(iif, 'vent_lowtemp=', IntToStr(spineditvalues[13, 1]));
    for b := 0 to 23 do
    begin
      s := 'vent_disablelowtemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[13, b]);
      writeln(iif, s);
    end;
    // page #14
    writeln(iif, 'vent_hightemp=', IntToStr(spineditvalues[14, 1]));
    for b := 0 to 23 do
    begin
      s := 'vent_disablehightemp_';
      if b < 10 then
        s := s + '0';
      s := s + IntToStr(b) + '=' + b2c(checkgroupvalue[14, b]);
      writeln(iif, s);
    end;
    writeln(iif, '');
    Close(iif);
  except
    saveinifile := False;
  end;
end;

