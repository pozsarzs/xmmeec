{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.3 * Environment characteristic editor for MMxD devices         | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | incsavetxtfile.pas                                                       | }
{ | Save txt file                                                            | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

// export values to text file
function savetxtfile(filename: string): boolean;
var
  b: byte;
  txf: Text;

  function b2c(b: boolean): char;
  begin
    if b then
      b2c := '1'
    else
      b2c := '0';
  end;

begin
  savetxtfile := True;
  try
    Assign(txf, filename);
    rewrite(txf);
    writeln(txf, 'I. ' + MESSAGE26);
    writeln(txf, '');
    writeln(txf, labelcaptions[5, 3] + ': ', IntToStr(spineditvalues[5, 3]));
    writeln(txf, '');
    writeln(txf, '');
    writeln(txf, 'II. ' + MESSAGE01);
    writeln(txf, '');
    // page #2
    for b := 1 to 4 do
      writeln(txf, labelcaptions[2, b] + ': ', IntToStr(spineditvalues[2, b]));
    writeln(txf, MESSAGE29g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[2, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #3
    for b := 1 to 4 do
      writeln(txf, labelcaptions[3, b] + ': ', IntToStr(spineditvalues[3, b]));
    writeln(txf, MESSAGE310g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[3, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #4
    for b := 1 to 4 do
      writeln(txf, labelcaptions[4, b] + ': ', IntToStr(spineditvalues[4, b]));
    writeln(txf, '');
    // page #5
    for b := 1 to 2 do
      writeln(txf, labelcaptions[5, b] + ': ', IntToStr(spineditvalues[5, b]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[5, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #6
    writeln(txf, labelcaptions[6, 1] + ': ', IntToStr(spineditvalues[6, 1]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[6, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #7
    writeln(txf, labelcaptions[7, 1] + ': ', IntToStr(spineditvalues[7, 1]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[7, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    writeln(txf, '');
    writeln(txf, 'III. ' + MESSAGE02);
    writeln(txf, '');
    // page #9
    for b := 1 to 4 do
      writeln(txf, labelcaptions[9, b] + ': ', IntToStr(spineditvalues[9, b]));
    writeln(txf, MESSAGE29g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[9, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #10
    for b := 1 to 4 do
      writeln(txf, labelcaptions[10, b] + ': ', IntToStr(spineditvalues[10, b]));
    writeln(txf, MESSAGE310g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[10, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #11
    for b := 1 to 4 do
      writeln(txf, labelcaptions[11, b] + ': ', IntToStr(spineditvalues[11, b]));
    writeln(txf, '');
    // page #12
    for b := 1 to 2 do
      writeln(txf, labelcaptions[12, b] + ': ', IntToStr(spineditvalues[12, b]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[12, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #13
    writeln(txf, labelcaptions[13, 1] + ': ', IntToStr(spineditvalues[13, 1]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[13, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    writeln(txf, '');
    // page #14
    writeln(txf, labelcaptions[14, 1] + ': ', IntToStr(spineditvalues[14, 1]));
    writeln(txf, MESSAGE567121314g + ':');
    for b := 0 to 23 do
      if checkgroupvalue[14, b] then
        writeln(txf, '  ' + IntToStr(b) + '.00-' + IntToStr(b) + '.59');
    Close(txf);
  except
    savetxtfile := False;
  end;
end;

