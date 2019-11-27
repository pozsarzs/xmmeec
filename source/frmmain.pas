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

unit frmmain;
{$MODE OBJFPC}{$H+}
interface
uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ComCtrls, ExtCtrls, StdCtrls, Spin, LResources, untcommonproc;
type
  { TForm1 }
  TForm1 = class(TForm)
    CheckBox1: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox20: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckGroup1: TCheckGroup;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    TreeView1: TTreeView;
    procedure FormCreate(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form1: TForm1;
const
  spinedits: array[0..11,1..4] of boolean=((false,false,false,false),(true,true,true,true),
                                          (true,true,true,true),(true,true,true,true),
                                          (true,true,true,true),(true,false,false,false),
                                          (false,false,false,false),(true,true,true,true),
                                          (true,true,true,true),(true,true,true,true),
                                          (true,true,true,true),(true,false,false,false));

  checkgroup: array[0..11] of boolean=(false,true,true,false,true,true,
                                       false,true,true,false,true,true);

Resourcestring
  MESSAGE01='';
  MESSAGE02='';
  MESSAGE03='';
  MESSAGE04='';
  MESSAGE05='';
  MESSAGE06='';
  MESSAGE07='';
  MESSAGE08='';
  MESSAGE09='';
  MESSAGE10='';
  MESSAGE11='';
  MESSAGE12='';
  MESSAGE13='';
  MESSAGE14='';
  MESSAGE15='';
  MESSAGE16='';
  MESSAGE17='';
  MESSAGE18='';
  MESSAGE19='';
  MESSAGE20='';
  MESSAGE21='';
  MESSAGE22='';
  MESSAGE23='';
  MESSAGE24='';
  MESSAGE25='';
  MESSAGE26='';
  MESSAGE27='';
  MESSAGE28='';
  MESSAGE29='';

implementation

{$R *.lfm}
{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
begin

end;

// select page
procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  Label1.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,1];
  Label2.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,2];
  Label3.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,3];
  Label4.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,4];
  SpinEdit1.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,1];
  SpinEdit2.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,2];
  SpinEdit3.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,3];
  SpinEdit4.Visible:=spinedits[TreeView1.Selected.AbsoluteIndex,4];
  CheckGroup1.Visible:=checkgroup[TreeView1.Selected.AbsoluteIndex];
end;

//create form
procedure TForm1.FormCreate(Sender: TObject);
begin
  makeuserdir;
  getlang;
  getexepath;
  Form1.Caption:='XMMEEC';
end;

end.

