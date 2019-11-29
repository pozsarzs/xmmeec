{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.1 * Environment characteristics editor                         | }
{ | Copyright (C) 2019 Pozsár Zsolt <pozsar.zsolt@.szerafingomba.hu>         | }
{ | frmtransfer.pas                                                          | }
{ | Download and upload remote file                                          | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.
//
//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit frmtransfer;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, CheckLst,
  StdCtrls, Process, untcommonproc;
type
  { TForm3 }
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckListBox1: TCheckListBox;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form3: TForm3;
  mode: boolean;
  error: boolean;

implementation

{$R *.lfm}
{ TForm3 }

{$I config.pas}
{$I inctransfer.pas}

// download/upload
procedure TForm3.Button1Click(Sender: TObject);
var
  b: byte;
begin
  error:=false;
  if mode then
  begin
    for b:=0 to CheckListBox1.Items.Count-1 do
      if CheckListBox1.Checked[b] then
      begin
        error:=not download(CheckListBox1.Items.Strings[b],userdir+DIR_CACHE+TMPFILE);
        exit;
      end;
  end else
  begin
    for b:=0 to CheckListBox1.Items.Count-1 do
      if CheckListBox1.Checked[b] then
      begin
        writeln(CheckListBox1.Items.Strings[b]);
//        err:=upload(TMPFILE,CheckListBox1.Items.Strings[b]);
      end;
  end;
end;

// enable/disable button
procedure TForm3.CheckListBox1ClickCheck(Sender: TObject);
var
  b: byte;
begin
  Button1.Enabled:=false;
  for b:=0 to CheckListBox1.Items.Count-1 do
    if CheckListBox1.Checked[b] then
    begin
      Button1.Enabled:=true;
      exit;
    end;
end;

//OnShow event
procedure TForm3.FormShow(Sender: TObject);
var
  b: byte;
begin
  CheckListBox1.Clear;
  Button1.Enabled:=false;
  for b:=0 to 15 do
    if length(untcommonproc.pathremotefiles[b])>0 then
      CheckListBox1.Items.Add(untcommonproc.pathremotefiles[b]);
end;

end.

