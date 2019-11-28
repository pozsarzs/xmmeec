{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | incsavetxtfile.pas                                                       | }
{ | include file                                                             | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.
// export values to text file

function savetxtfile(filename: string): boolean;
var
  txf: text;
  b: byte;
  s: string;

  function b2c(b: boolean): char;
  begin
    if b then b2c:='1' else b2c:='0';
  end;

begin
  savetxtfile:=true;
  try
    assign(txf,filename);
    rewrite(txf);
    writeln(txf,'1.'+MESSAGE01);
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[1,b]+': ',inttostr(spineditvalues[1,b]));
    writeln(txf,MESSAGE17g+':');
    for b:=0 to 23 do
      if checkgroupvalue[1,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[2,b]+': ',inttostr(spineditvalues[2,b]));
    writeln(txf,MESSAGE28g+':');
    for b:=0 to 23 do
      if checkgroupvalue[2,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[3,b]+': ',inttostr(spineditvalues[3,b]));
    writeln(txf,'');
    for b:=1 to 2 do writeln(txf,labelcaptions[4,b]+': ',inttostr(spineditvalues[4,b]));
    writeln(txf,MESSAGE451011g+':');
    for b:=0 to 23 do
      if checkgroupvalue[4,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    writeln(txf,labelcaptions[5,1]+': ',inttostr(spineditvalues[5,1]));
    writeln(txf,MESSAGE451011g+':');
    for b:=0 to 23 do
      if checkgroupvalue[5,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    writeln(txf,'');
    writeln(txf,'2.'+MESSAGE02);
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[7,b]+': ',inttostr(spineditvalues[7,b]));
    writeln(txf,MESSAGE17g+':');
    for b:=0 to 23 do
      if checkgroupvalue[7,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[8,b]+': ',inttostr(spineditvalues[8,b]));
    writeln(txf,MESSAGE28g+':');
    for b:=0 to 23 do
      if checkgroupvalue[8,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    for b:=1 to 4 do writeln(txf,labelcaptions[9,b]+': ',inttostr(spineditvalues[9,b]));
    for b:=1 to 2 do writeln(txf,labelcaptions[10,b]+': ',inttostr(spineditvalues[10,b]));
    writeln(txf,MESSAGE451011g+':');
    for b:=0 to 23 do
      if checkgroupvalue[10,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    writeln(txf,'');
    writeln(txf,labelcaptions[11,1]+': ',inttostr(spineditvalues[11,1]));
    writeln(txf,MESSAGE451011g+':');
    for b:=0 to 23 do
      if checkgroupvalue[11,b] then
        writeln(txf,'  '+inttostr(b)+'.00-'+inttostr(b)+'.59');
    close(txf);
  except
    savetxtfile:=false;
  end;
end;
