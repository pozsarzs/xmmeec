{ +--------------------------------------------------------------------------+ }
{ | XMMEEC v0.3 * Environment characteristic editor for MMxD devices         | }
{ | Copyright (C) 2019-2022 Pozsár Zsolt <pozsar.zsolt@szerafingomba.hu>     | }
{ | frmmain.pas                                                              | }
{ | Main form                                                                | }
{ +--------------------------------------------------------------------------+ }

//   This program is free software: you can redistribute it and/or modify it
// under the terms of the European Union Public License 1.1 version.

//   This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
// FOR A PARTICULAR PURPOSE.

unit frmmain;

{$MODE OBJFPC}{$H+}
interface

uses
  Buttons,
  Classes,
  ComCtrls,
  Controls,
  Dialogs,
  ExtCtrls,
  FileUtil,
  Forms,
  Graphics,
  INIFiles,
  LResources,
  Menus,
  Process,
  Spin,
  StdCtrls,
  SysUtils,
  dos,
  frmabout,
  untcommonproc;

type
  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckGroup1: TCheckGroup;
    ComboBox1: TComboBox;
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
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RadioGroup4: TRadioGroup;
    SaveDialog1: TSaveDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure ToolBar1Resize(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  checkgroupcaption: array[0..14] of string;
  checkgroupvalue: array[0..14, 0..23] of boolean;
  labelcaptions: array[0..14, 1..4] of string;
  spineditvalues: array[0..14, 1..4] of byte;

const
  visiblecheckgroup: array[0..14] of boolean =
    (False, False, True, True, False, True, True, True, False, True, True,
    False, True, True, True);
  visibleradiogroups: array[0..14] of boolean =
    (True, False, False, False, False, False, False, False, False, False, False,
    False, False, False, False);
  visiblespinedits: array[0..14, 1..4] of boolean =
    (
    (False, False, False, False),
    (False, False, False, False),
    (True, True, True, True),
    (True, True, True, True),
    (True, True, True, True),
    (True, True, True, False),
    (True, False, False, False),
    (True, False, False, False),
    (False, False, False, False),
    (True, True, True, True),
    (True, True, True, True),
    (True, True, True, True),
    (True, True, True, False),
    (True, False, False, False),
    (True, False, False, False)
    );

resourcestring
  MESSAGE01 = 'Growing hyphae';
  MESSAGE02 = 'Growing mushroom';
  MESSAGE03 = 'Humidifying';
  MESSAGE04 = 'Heating';
  MESSAGE05 = 'Lighting';
  MESSAGE06 = 'Ventilating';
  MESSAGE07 = 'Low external temp.';
  MESSAGE08 = 'INI files (*.ini)|*.ini|';
  MESSAGE09 = 'Text files (*.txt)|*.txt|';
  MESSAGE10 = 'Load from file';
  MESSAGE11 = 'Save to file';
  MESSAGE12 = 'Export to text file';
  MESSAGE13 = 'File exist, overwrite?';
  MESSAGE14 = 'Cannot read file!';
  MESSAGE15 = 'Cannot write file!';
  MESSAGE16 = 'Do you want exit?';
  MESSAGE17 = 'Cannot read configuration file!';
  MESSAGE18 = 'Download file';
  MESSAGE19 = 'Upload file';
  MESSAGE20 = 'File transfer error!';
  MESSAGE21 = 'High external temp.';
  MESSAGE22 = 'Mushroom tent';
  MESSAGE23 = 'Page';
  MESSAGE24 = 'Type';
  MESSAGE25 = 'Channel';
  MESSAGE26 = 'Common parameters';
  MESSAGE27 = 'Cannot set override!';
  MESSAGE28 = 'Cannot set override status!';
  MESSAGE0a = 'Channel #1';
  MESSAGE0b = 'Channel #2';
  MESSAGE0c = 'Channel #3';
  MESSAGE0d = 'Channel #4';
  MESSAGE29a = 'Minimal relative humidity [%]';
  MESSAGE29b = 'Humidifier switch-on humidity [%]';
  MESSAGE29c = 'Humidifier switch-off humidity [%]';
  MESSAGE29d = 'Maximal relative humidity [%]';
  MESSAGE29g = 'Disable humidifier';
  MESSAGE310a = 'Minimal temperature [°C]';
  MESSAGE310b = 'Heater switch-on temperature [°C]';
  MESSAGE310c = 'Heater switch-off temperature [°C]';
  MESSAGE310d = 'Maximal temperature [°C]';
  MESSAGE310g = 'Disable heater';
  MESSAGE411a = 'Lights switch-on hour #1';
  MESSAGE411b = 'Lights switch-off hour #1';
  MESSAGE411c = 'Lights switch-on hour #2';
  MESSAGE411d = 'Lights switch-off hour #2';
  MESSAGE512a = 'Ventilators switch-on minute';
  MESSAGE512b = 'Ventilators switch-off minute';
  MESSAGE512c = 'Relative unwanted gas content [%]';
  MESSAGE613a = 'Low external temperature [°C]';
  MESSAGE714a = 'High external temperature [°C]';
  MESSAGE567121314g = 'Disable ventilators';

implementation

{$R *.lfm}
{ TForm1 }

{$I incloadinifile.pas}
{$I incsaveinifile.pas}
{$I incsavetxtfile.pas}
{$I inctransfer.pas}

// clear
procedure TForm1.MenuItem2Click(Sender: TObject);
var
  b, bb, bbb: byte;
begin
  for b := 0 to 14 do
  begin
    for bb := 1 to 4 do
      spineditvalues[b, bb] := 0;
    for bbb := 0 to 23 do
      checkgroupvalue[b, bbb] := False;
  end;
  SpinEdit1.Value := 0;
  SpinEdit2.Value := 0;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
  for b := 0 to 23 do
    CheckGroup1.Checked[b] := False;
end;

// open
procedure TForm1.MenuItem4Click(Sender: TObject);
var
  b, bb, bbb: byte;
begin
  for b := 0 to 14 do
  begin
    for bb := 1 to 4 do
      spineditvalues[b, bb] := 0;
    for bbb := 0 to 23 do
      checkgroupvalue[b, bbb] := False;
  end;
  with OpenDialog1 do
  begin
    InitialDir := untcommonproc.userdir;
    Title := MESSAGE10;
    Filter := MESSAGE08;
    if Execute = False then
      exit;
    if not loadinifile(FileName) then
      ShowMessage(MESSAGE14);
  end;
  SpinEdit1.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 1];
  SpinEdit2.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 2];
  SpinEdit3.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 3];
  SpinEdit4.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 4];
  for b := 0 to 23 do
    CheckGroup1.Checked[b] := checkgroupvalue[TreeView1.Selected.AbsoluteIndex, b];
end;

// save
procedure TForm1.MenuItem5Click(Sender: TObject);
var
  f: string;
  tfdir, tfname, tfext: shortstring;

begin
  with SaveDialog1 do
  begin
    Filename := '';
    Filter := MESSAGE08;
    InitialDir := untcommonproc.userdir;
    Title := MESSAGE11;
    FilterIndex := 1;
    if not Execute then
      exit;
    f := FileName;
  end;
  if length(f) = 0 then
    exit;
  fsplit(f, tfdir, tfname, tfext);
  if FSearch(tfname + tfext, tfdir) <> '' then
    if MessageDlgPos(MESSAGE13, mtConfirmation, [mbYes, mbNo], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2) = mrNo then
      exit;
  if not saveinifile(f) then
    ShowMessage(MESSAGE15);
end;

// export
procedure TForm1.MenuItem8Click(Sender: TObject);
var
  f: string;
  tfdir, tfname, tfext: shortstring;

begin
  with SaveDialog1 do
  begin
    Filename := '';
    Filter := MESSAGE09;
    InitialDir := untcommonproc.userdir;
    Title := MESSAGE12;
    FilterIndex := 1;
    if not Execute then
      exit;
    f := FileName;
  end;
  if length(f) = 0 then
    exit;
  fsplit(f, tfdir, tfname, tfext);
  if FSearch(tfname + tfext, tfdir) <> '' then
    if MessageDlgPos(MESSAGE13, mtConfirmation, [mbYes, mbNo], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2) = mrNo then
      exit;
  if not savetxtfile(f) then
    ShowMessage(MESSAGE15);
end;

// exit
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  Close;
end;

// download
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  b: byte;
begin
  if download(ComboBox1.ItemIndex, userdir + TMPFILE) then
  begin
    loadinifile(userdir + TMPFILE);
    TreeView1.Items.Item[1].Selected := True;
    SpinEdit1.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 1];
    SpinEdit2.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 2];
    SpinEdit3.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 3];
    SpinEdit4.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 4];
    for b := 0 to 23 do
      CheckGroup1.Checked[b] := checkgroupvalue[TreeView1.Selected.AbsoluteIndex, b];
  end
  else
    MessageDlgPos(MESSAGE20, mtWarning, [mbOK], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2);
end;

// upload
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  if not saveinifile(userdir + TMPFILE) then
    ShowMessage(MESSAGE15);
  if not upload(ComboBox1.ItemIndex, userdir + TMPFILE) then
    MessageDlgPos(MESSAGE20, mtWarning, [mbOK], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2);
end;

// show about dialog
procedure TForm1.MenuItem16Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

// apply values
procedure TForm1.Button1Click(Sender: TObject);
var
  b: byte;
begin
  spineditvalues[TreeView1.Selected.AbsoluteIndex, 1] := SpinEdit1.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex, 2] := SpinEdit2.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex, 3] := SpinEdit3.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex, 4] := SpinEdit4.Value;
  for b := 0 to 23 do
    checkgroupvalue[TreeView1.Selected.AbsoluteIndex, b] := CheckGroup1.Checked[b];
end;

// get override
procedure TForm1.Button2Click(Sender: TObject);
var
  s: string;
begin
  s := getoverride(ComboBox1.ItemIndex);
  if s = '' then
    MessageDlgPos(MESSAGE28, mtWarning, [mbOK], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2)
  else
  begin
    RadioGroup1.ItemIndex := StrToInt(s[1]);
    RadioGroup2.ItemIndex := StrToInt(s[2]);
    RadioGroup3.ItemIndex := StrToInt(s[3]);
    RadioGroup4.ItemIndex := StrToInt(s[4]);
  end;
end;

// set override
procedure TForm1.Button3Click(Sender: TObject);
begin
  if not setoverride(ComboBox1.ItemIndex, RadioGroup1.ItemIndex,
    RadioGroup2.ItemIndex, RadioGroup3.ItemIndex, RadioGroup4.ItemIndex) then
    MessageDlgPos(MESSAGE27, mtWarning, [mbOK], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2);
end;

// select page
procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  b: byte;
begin
  // skip empty pages
  case TreeView1.Selected.AbsoluteIndex of
    1: TreeView1.Items.Item[2].Selected := True;
    8: TreeView1.Items.Item[9].Selected := True;
  end;
  // set widgets
  b := TreeView1.Selected.AbsoluteIndex + 1;
  if b > 1 then
    Dec(b);
  if b > 8 then
    Dec(b);
  StatusBar1.Panels.Items[0].Text :=
    MESSAGE23 + ': ' + IntToStr(b) + '/' + IntToStr(TreeView1.Items.Count - 2);
  Button1.Enabled := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 1];
  Button2.Visible := visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  Button3.Visible := Button2.Visible;
  CheckGroup1.Visible := visiblecheckgroup[TreeView1.Selected.AbsoluteIndex];
  Label1.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 1] or
    visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  Label2.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 2] or
    visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  Label3.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 3] or
    visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  Label4.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 4] or
    visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  RadioGroup1.Visible := visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  RadioGroup2.Visible := visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  RadioGroup3.Visible := visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  RadioGroup4.Visible := visibleradiogroups[TreeView1.Selected.AbsoluteIndex];
  SpinEdit1.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 1];
  SpinEdit2.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 2];
  SpinEdit3.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 3];
  SpinEdit4.Visible := visiblespinedits[TreeView1.Selected.AbsoluteIndex, 4];
  Label1.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 1];
  Label2.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 2];
  Label3.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 3];
  Label4.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 4];
  CheckGroup1.Caption := checkgroupcaption[TreeView1.Selected.AbsoluteIndex];
  // clear values
  SpinEdit1.Value := 0;
  SpinEdit2.Value := 0;
  SpinEdit3.Value := 0;
  SpinEdit4.Value := 0;
  for b := 0 to 23 do
    CheckGroup1.Checked[0] := False;
  // load values
  SpinEdit1.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 1];
  SpinEdit2.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 2];
  SpinEdit3.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 3];
  SpinEdit4.Value := spineditvalues[TreeView1.Selected.AbsoluteIndex, 4];
  for b := 0 to 23 do
    CheckGroup1.Checked[b] := checkgroupvalue[TreeView1.Selected.AbsoluteIndex, b];
end;

// resize ComboBox
procedure TForm1.ToolBar1Resize(Sender: TObject);
begin
  ComboBox1.Width := ToolBar1.Width - 110;
end;

// ComboBox OnChange event
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if length(ComboBox1.Text) > 0 then
    MenuItem11.Enabled := True
  else
    MenuItem11.Enabled := False;
  MenuItem12.Enabled := MenuItem11.Enabled;
  SpeedButton3.Enabled := MenuItem11.Enabled;
  SpeedButton4.Enabled := MenuItem11.Enabled;
  StatusBar1.Panels.Items[1].Text :=
    MESSAGE24 + ': ' + uppercase(dev_type[ComboBox1.ItemIndex + 1]);
  StatusBar1.Panels.Items[2].Text :=
    MESSAGE25 + ': #' + IntToStr(dev_chan[ComboBox1.ItemIndex + 1]);
  case uppercase(dev_type[ComboBox1.ItemIndex + 1]) of
    'MM5D':
    begin
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 1] := MESSAGE04;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 2] := MESSAGE05;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 3] := MESSAGE06;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 4] := MESSAGE03;
      Label4.Visible := True;
      RadioGroup4.Visible := True;
      Button2.AnchorToNeighbour(akTop, 8, RadioGroup4);
    end;
    'MM8D':
    begin
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 1] := MESSAGE05;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 2] := MESSAGE06;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 3] := MESSAGE04;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 4] := '';
      Label4.Visible := False;
      RadioGroup4.Visible := False;
      Button2.AnchorToNeighbour(akTop, 8, RadioGroup3);
    end;
    else
    begin
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 1] := MESSAGE03;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 2] := MESSAGE05;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 3] := MESSAGE06;
      labelcaptions[TreeView1.Selected.AbsoluteIndex, 4] := MESSAGE04;
      Label4.Visible := True;
      RadioGroup4.Visible := True;
      Button2.AnchorToNeighbour(akTop, 8, RadioGroup4);
    end;
  end;
  Label1.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 1];
  Label2.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 2];
  Label3.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 3];
  Label4.Caption := labelcaptions[TreeView1.Selected.AbsoluteIndex, 4];
end;

// OnCloseQuery event
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if MessageDlgPos(MESSAGE16, mtConfirmation, [mbYes, mbNo], 0,
    (Form1.Left + Form1.Left + Form1.Width) div 2, (Form1.Top +
    Form1.Top + Form1.Height) div 2) = mrYes then
    CanClose := True
  else
    CanClose := False;
end;

// create form
procedure TForm1.FormCreate(Sender: TObject);
type
  TreeNode = TTreeNode;
var
  b, bb: byte;
  cfgfile: string;
  tn1, tn2, tn3: TreeNode;
begin
  makeuserdir;
  getlang;
  getexepath;
  deletefile(userdir + TMPFILE);
  Form1.Caption := APPNAME + ' v' + VERSION;
  // load configuration
  {$IFDEF UseFHS}
  cfgfile := INSTPATH + 'etc/xmmeec.ini';
  if INSTPATH = '/usr/' then
    cfgfile := '/etc/xmmeec.ini';
  {$ELSE}
  cfgfile := exepath + 'settings/xmmeec.ini';
  {$ENDIF}
  if FSearch('xmmeec.ini', userdir + DIR_CONFIG) <> '' then
    cfgfile := userdir + DIR_CONFIG + 'xmmeec.ini';
  loadconfig(cfgfile);
  // make tree
  TreeView1.Items.Clear;
  tn1 := TreeView1.Items.Add(nil, MESSAGE22);
  tn2 := TreeView1.Items.AddChild(tn1, MESSAGE01);
  TreeView1.Items.AddChild(tn2, MESSAGE03);
  TreeView1.Items.AddChild(tn2, MESSAGE04);
  TreeView1.Items.AddChild(tn2, MESSAGE05);
  tn3 := TreeView1.Items.AddChild(tn2, MESSAGE06);
  TreeView1.Items.AddChild(tn3, MESSAGE07);
  TreeView1.Items.AddChild(tn3, MESSAGE21);
  tn2 := TreeView1.Items.AddChild(tn1, MESSAGE02);
  TreeView1.Items.AddChild(tn2, MESSAGE03);
  TreeView1.Items.AddChild(tn2, MESSAGE04);
  TreeView1.Items.AddChild(tn2, MESSAGE05);
  tn3 := TreeView1.Items.AddChild(tn2, MESSAGE06);
  TreeView1.Items.AddChild(tn3, MESSAGE07);
  TreeView1.Items.AddChild(tn3, MESSAGE21);
  // set names
  for b := 0 to 14 do
    for bb := 1 to 4 do
      labelcaptions[b, bb] := '';
  labelcaptions[2, 1] := MESSAGE29a;
  labelcaptions[2, 2] := MESSAGE29b;
  labelcaptions[2, 3] := MESSAGE29c;
  labelcaptions[2, 4] := MESSAGE29d;
  labelcaptions[3, 1] := MESSAGE310a;
  labelcaptions[3, 2] := MESSAGE310b;
  labelcaptions[3, 3] := MESSAGE310c;
  labelcaptions[3, 4] := MESSAGE310d;
  labelcaptions[4, 1] := MESSAGE411a;
  labelcaptions[4, 2] := MESSAGE411b;
  labelcaptions[4, 3] := MESSAGE411c;
  labelcaptions[4, 4] := MESSAGE411d;
  labelcaptions[5, 1] := MESSAGE512a;
  labelcaptions[5, 2] := MESSAGE512b;
  labelcaptions[5, 3] := MESSAGE512c;
  labelcaptions[6, 1] := MESSAGE613a;
  labelcaptions[7, 1] := MESSAGE714a;
  labelcaptions[9, 1] := MESSAGE29a;
  labelcaptions[9, 2] := MESSAGE29b;
  labelcaptions[9, 3] := MESSAGE29c;
  labelcaptions[9, 4] := MESSAGE29d;
  labelcaptions[10, 1] := MESSAGE310a;
  labelcaptions[10, 2] := MESSAGE310b;
  labelcaptions[10, 3] := MESSAGE310c;
  labelcaptions[10, 4] := MESSAGE310d;
  labelcaptions[11, 1] := MESSAGE411a;
  labelcaptions[11, 2] := MESSAGE411b;
  labelcaptions[11, 3] := MESSAGE411c;
  labelcaptions[11, 4] := MESSAGE411d;
  labelcaptions[12, 1] := MESSAGE512a;
  labelcaptions[12, 2] := MESSAGE512b;
  labelcaptions[12, 3] := MESSAGE512c;
  labelcaptions[13, 1] := MESSAGE613a;
  labelcaptions[14, 1] := MESSAGE714a;
  for b := 0 to 14 do
    checkgroupcaption[b] := '';
  checkgroupcaption[2] := MESSAGE29g;
  checkgroupcaption[3] := MESSAGE310g;
  checkgroupcaption[5] := MESSAGE567121314g;
  checkgroupcaption[6] := MESSAGE567121314g;
  checkgroupcaption[7] := MESSAGE567121314g;
  checkgroupcaption[8] := MESSAGE567121314g;
  checkgroupcaption[9] := MESSAGE29g;
  checkgroupcaption[10] := MESSAGE310g;
  checkgroupcaption[12] := MESSAGE567121314g;
  checkgroupcaption[13] := MESSAGE567121314g;
  checkgroupcaption[14] := MESSAGE567121314g;
  // create checkboxes
  for b := 0 to 23 do
    CheckGroup1.Items.Add(IntToStr(b) + '.00-' + IntToStr(b) + '.59');
  if not loadconfig(cfgfile) then
    MessageDlgPos(MESSAGE13, mtError, [mbOK], 0,
      (Form1.Left + Form1.Left + Form1.Width) div 2,
      (Form1.Top + Form1.Top + Form1.Height) div 2);
  TreeView1.Items.Item[0].Selected := True;
  // fill combobox
  ComboBox1.Clear;
  for b := 1 to 32 do
    if length(dev_name[b]) > 0 then
      ComboBox1.Items.Add(dev_name[b] + ' (' + dev_user[b] + ':' +
        IntToStr(dev_port[b]) + ')');
  if ComboBox1.Items.Count > 0 then
  begin
    ComboBox1.ItemIndex := 0;
    ComboBox1Change(Sender);
  end;
end;

end.
