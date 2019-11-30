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
  ComCtrls, ExtCtrls, StdCtrls, Spin, LResources, INIFiles, Process,
  frmabout, frmtransfer, untcommonproc, dos;
type
  { TForm1 }
  TForm1 = class(TForm)
    Button1: TButton;
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
    SaveDialog1: TSaveDialog;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    TreeView1: TTreeView;
    procedure Button1Click(Sender: TObject);
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
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
  private
    { private declarations }
  public
    { public declarations }
  end;
var
  Form1: TForm1;
  labelcaptions: array[0..11,1..4] of string;
  checkgroupcaption: array[0..11] of string;
  spineditvalues: array[0..11,1..4] of byte;
  checkgroupvalue: array[0..11,0..23] of boolean;
const
  visiblespinedits: array[0..11,1..4] of boolean=
  (
    (false,false,false,false),(true,true,true,true),(true,true,true,true),
    (true,true,true,true),(true,true,false,false),(true,false,false,false),
    (false,false,false,false),(true,true,true,true),(true,true,true,true),
    (true,true,true,true),(true,true,false,false),(true,false,false,false)
  );
  visiblecheckgroup: array[0..11] of boolean=
    (false,true,true,false,true,true,false,true,true,false,true,true);

Resourcestring
  MESSAGE01='Growing hyphae';
  MESSAGE02='Growing mushroom';
  MESSAGE03='Humidifying';
  MESSAGE04='Heating';
  MESSAGE05='Lighting';
  MESSAGE06='Ventilating';
  MESSAGE07='Low external temp.';
  MESSAGE08='INI files (*.ini)|*.ini|';
  MESSAGE09='Text files (*.txt)|*.txt|';
  MESSAGE10='Load from file';
  MESSAGE11='Save to file';
  MESSAGE12='Export to text file';
  MESSAGE13='File exist, overwrite?';
  MESSAGE14='ERROR: Cannot read file!';
  MESSAGE15='ERROR: Cannot write file!';
  MESSAGE16='Do you want exit?';
  MESSAGE17='ERROR: Cannot read configuration file!';
  MESSAGE18='Download file';
  MESSAGE19='Upload file';
  MESSAGE17a='Minimal relative humidity [%]';
  MESSAGE17b='Humidifier switch-on humidity [%]';
  MESSAGE17c='Humidifier switch-off humidity [%]';
  MESSAGE17d='Maximal relative humidity [%]';
  MESSAGE28a='Minimal temperature [°C]';
  MESSAGE28b='Heater switch-on temperature [°C]';
  MESSAGE28c='Heater switch-off temperature [°C]';
  MESSAGE28d='Maximal temperature [°C]';
  MESSAGE39a='Lights switch-on hour #1';
  MESSAGE39b='Lights switch-off hour #1';
  MESSAGE39c='Lights switch-on hour #2';
  MESSAGE39d='Lights switch-off hour #2';
  MESSAGE410a='Ventilators switch-on minute';
  MESSAGE410b='Ventilators switch-off minute';
  MESSAGE511a='Low external temperature [°C]';
  MESSAGE17g='Disable humidifier';
  MESSAGE28g='Disable heater';
  MESSAGE451011g='Disable ventilators';

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
  for b:=0 to 11 do
  begin
    for bb:=1 to 4 do spineditvalues[b,bb]:=0;
    for bbb:=0 to 23 do checkgroupvalue[b,bbb]:=false;
  end;
  SpinEdit1.Value:=0;
  SpinEdit2.Value:=0;
  SpinEdit3.Value:=0;
  SpinEdit4.Value:=0;
  for b:=0 to 23 do CheckGroup1.Checked[b]:=false;
end;

// open
procedure TForm1.MenuItem4Click(Sender: TObject);
var
   b, bb, bbb: byte;
begin
  for b:=0 to 11 do
  begin
    for bb:=1 to 4 do spineditvalues[b,bb]:=0;
    for bbb:=0 to 23 do checkgroupvalue[b,bbb]:=false;
  end;
  with OpenDialog1 do
  begin
    InitialDir := untcommonproc.userdir;
    Title := MESSAGE10;
    Filter := MESSAGE08;
    if Execute=false then exit;
    if not loadinifile(FileName) then ShowMessage(MESSAGE14);
  end;
  SpinEdit1.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,1];
  SpinEdit2.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,2];
  SpinEdit3.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,3];
  SpinEdit4.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,4];
  for b:=0 to 23 do
    CheckGroup1.Checked[b]:=checkgroupvalue[TreeView1.Selected.AbsoluteIndex,b];
end;

// save
procedure TForm1.MenuItem5Click(Sender: TObject);
var
   f: string;
   tfdir, tfname, tfext: shortstring;

begin
  with SaveDialog1 do
  begin
    Filename:='';
    Filter:=MESSAGE08;
    InitialDir:=untcommonproc.userdir;
    Title:=MESSAGE11;
    FilterIndex := 1;
    if not Execute then exit;
    f:=FileName;
  end;
  if length(f)=0 then exit;
  fsplit(f,tfdir,tfname,tfext);
  if FSearch(tfname+tfext,tfdir)<>'' then
    if MessageDlgPos(MESSAGE13,mtConfirmation,[mbYes,mbNo],0,
      (Form1.Left+Form1.Left+Form1.Width) div 2,(Form1.Top+Form1.Top+Form1.Height) div 2)=mrNo then exit;
  if not saveinifile(f) then ShowMessage(MESSAGE15);
end;

// export
procedure TForm1.MenuItem8Click(Sender: TObject);
var
   f: string;
   tfdir, tfname, tfext: shortstring;

begin
  with SaveDialog1 do
  begin
    Filename:='';
    Filter:=MESSAGE09;
    InitialDir:=untcommonproc.userdir;
    Title:=MESSAGE12;
    FilterIndex := 1;
    if not Execute then exit;
    f:=FileName;
  end;
  if length(f)=0 then exit;
  fsplit(f,tfdir,tfname,tfext);
  if FSearch(tfname+tfext,tfdir)<>'' then
    if MessageDlgPos(MESSAGE13,mtConfirmation,[mbYes,mbNo],0,
      (Form1.Left+Form1.Left+Form1.Width) div 2,(Form1.Top+Form1.Top+Form1.Height) div 2)=mrNo then exit;
  if not savetxtfile(f) then ShowMessage(MESSAGE15);
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
(*  Form3.Caption:=MESSAGE18;
  Form3.Button1.Caption:=MenuItem11.Caption;
  frmtransfer.mode:=true;
  Form3.ShowModal;
  if not frmtransfer.error then
  begin
    if not loadinifile(userdir+DIR_CACHE+TMPFILE) then ShowMessage(MESSAGE14);
    TreeView1.Items.Item[1].Selected:=true;
    SpinEdit1.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,1];
    SpinEdit2.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,2];
    SpinEdit3.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,3];
    SpinEdit4.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,4];
    for b:=0 to 23 do
      CheckGroup1.Checked[b]:=checkgroupvalue[TreeView1.Selected.AbsoluteIndex,b];
  end;*)
end;

// upload
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
(*  Form3.Caption:=MESSAGE19;
  Form3.Button1.Caption:=MenuItem12.Caption;
  frmtransfer.mode:=false;
  Form3.ShowModal;*)
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
  spineditvalues[TreeView1.Selected.AbsoluteIndex,1]:=SpinEdit1.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex,2]:=SpinEdit2.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex,3]:=SpinEdit3.Value;
  spineditvalues[TreeView1.Selected.AbsoluteIndex,4]:=SpinEdit4.Value;
  for b:=0 to 23 do
    checkgroupvalue[TreeView1.Selected.AbsoluteIndex,b]:=CheckGroup1.Checked[b];
end;


// ComboBox OnChange event
procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  if length(ComboBox1.Text)>0 then
    MenuItem11.Enabled:=true else
      MenuItem11.Enabled:=false;
  MenuItem12.Enabled:=MenuItem11.Enabled;
  ToolButton3.Enabled:=MenuItem11.Enabled;
  ToolButton4.Enabled:=MenuItem11.Enabled;
end;

// select page
procedure TForm1.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
  b: byte;
begin
  // skip empty pages
  case TreeView1.Selected.AbsoluteIndex of
    0: TreeView1.Items.Item[1].Selected:=true;
    6: TreeView1.Items.Item[7].Selected:=true;
  end;
  // set widgets
  Button1.Enabled:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,1];
  Label1.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,1];
  Label2.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,2];
  Label3.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,3];
  Label4.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,4];
  SpinEdit1.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,1];
  SpinEdit2.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,2];
  SpinEdit3.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,3];
  SpinEdit4.Visible:=visiblespinedits[TreeView1.Selected.AbsoluteIndex,4];
  CheckGroup1.Visible:=visiblecheckgroup[TreeView1.Selected.AbsoluteIndex];
  Label1.Caption:=labelcaptions[TreeView1.Selected.AbsoluteIndex,1];
  Label2.Caption:=labelcaptions[TreeView1.Selected.AbsoluteIndex,2];
  Label3.Caption:=labelcaptions[TreeView1.Selected.AbsoluteIndex,3];
  Label4.Caption:=labelcaptions[TreeView1.Selected.AbsoluteIndex,4];
  CheckGroup1.Caption:=checkgroupcaption[TreeView1.Selected.AbsoluteIndex];
  // clear values
  SpinEdit1.Value:=0;
  SpinEdit2.Value:=0;
  SpinEdit3.Value:=0;
  SpinEdit4.Value:=0;
  for b:=0 to 23 do CheckGroup1.Checked[0]:=false;
  // load values
  SpinEdit1.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,1];
  SpinEdit2.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,2];
  SpinEdit3.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,3];
  SpinEdit4.Value:=spineditvalues[TreeView1.Selected.AbsoluteIndex,4];
  for b:=0 to 23 do
    CheckGroup1.Checked[b]:=checkgroupvalue[TreeView1.Selected.AbsoluteIndex,b];
end;

// OnCloseQuery event
procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if MessageDlgPos(MESSAGE16,mtConfirmation,[mbYes,mbNo],0,
      (Form1.Left+Form1.Left+Form1.Width) div 2,
      (Form1.Top+Form1.Top+Form1.Height) div 2)=mrYes then
    CanClose:=true else CanClose:=false;
end;

// create form
procedure TForm1.FormCreate(Sender: TObject);
type
  TreeNode=TTreeNode;
var
  tn: TreeNode;
  b, bb: byte;
  cfgfile: string;
begin
  makeuserdir;
  getlang;
  getexepath;
  deletefile(userdir+DIR_CACHE+TMPFILE);
  Form1.Caption:=APPNAME+' v.'+VERSION;
  // load configuration
  {$IFDEF UseFHS}
    cfgfile:=instpath+'etc/xmmeec.ini';
    if instpath='/usr/' then cfgfile:='/etc/xmmeec.ini';
  {$ELSE}
    cfgfile:=exepath+'settings/xmmeec.ini';
  {$ENDIF}
  if fsearch('xmmeec.ini',userdir+DIR_CONFIG)<>''
    then cfgfile:=userdir+DIR_CONFIG+'xmmeec.ini';
  loadconfig(cfgfile);
  // make tree
  TreeView1.Items.Clear;
  tn:=TreeView1.Items.Add(nil,MESSAGE01);
  TreeView1.Items.AddChild(tn,MESSAGE03);
  TreeView1.Items.AddChild(tn,MESSAGE04);
  TreeView1.Items.AddChild(tn,MESSAGE05);
  tn:=TreeView1.Items.AddChild(tn,MESSAGE06);
  TreeView1.Items.AddChild(tn,MESSAGE07);
  tn:=TreeView1.Items.Add(nil,MESSAGE02);
  TreeView1.Items.AddChild(tn,MESSAGE03);
  TreeView1.Items.AddChild(tn,MESSAGE04);
  TreeView1.Items.AddChild(tn,MESSAGE05);
  tn:=TreeView1.Items.AddChild(tn,MESSAGE06);
  TreeView1.Items.AddChild(tn,MESSAGE07);
  // set names
  for b:=0 to 11 do
    for bb:=1 to 4 do
      labelcaptions[b,bb]:='';
  labelcaptions[1,1]:=MESSAGE17a;
  labelcaptions[1,2]:=MESSAGE17b;
  labelcaptions[1,3]:=MESSAGE17c;
  labelcaptions[1,4]:=MESSAGE17d;
  labelcaptions[2,1]:=MESSAGE28a;
  labelcaptions[2,2]:=MESSAGE28b;
  labelcaptions[2,3]:=MESSAGE28c;
  labelcaptions[2,4]:=MESSAGE28d;
  labelcaptions[3,1]:=MESSAGE39a;
  labelcaptions[3,2]:=MESSAGE39b;
  labelcaptions[3,3]:=MESSAGE39c;
  labelcaptions[3,4]:=MESSAGE39d;
  labelcaptions[4,1]:=MESSAGE410a;
  labelcaptions[4,2]:=MESSAGE410b;
  labelcaptions[5,1]:=MESSAGE511a;
  labelcaptions[7,1]:=MESSAGE17a;
  labelcaptions[7,2]:=MESSAGE17b;
  labelcaptions[7,3]:=MESSAGE17c;
  labelcaptions[7,4]:=MESSAGE17d;
  labelcaptions[8,1]:=MESSAGE28a;
  labelcaptions[8,2]:=MESSAGE28b;
  labelcaptions[8,3]:=MESSAGE28c;
  labelcaptions[8,4]:=MESSAGE28d;
  labelcaptions[9,1]:=MESSAGE39a;
  labelcaptions[9,2]:=MESSAGE39b;
  labelcaptions[9,3]:=MESSAGE39c;
  labelcaptions[9,4]:=MESSAGE39d;
  labelcaptions[10,1]:=MESSAGE410a;
  labelcaptions[10,2]:=MESSAGE410b;
  labelcaptions[11,1]:=MESSAGE511a;
  for b:=0 to 11 do
    checkgroupcaption[b]:='';
  checkgroupcaption[1]:=MESSAGE17g;
  checkgroupcaption[2]:=MESSAGE28g;
  checkgroupcaption[4]:=MESSAGE451011g;
  checkgroupcaption[5]:=MESSAGE451011g;
  checkgroupcaption[7]:=MESSAGE17g;
  checkgroupcaption[8]:=MESSAGE28g;
  checkgroupcaption[10]:=MESSAGE451011g;
  checkgroupcaption[11]:=MESSAGE451011g;
  // create checkboxes
  for b:=0 to 23 do
    CheckGroup1.Items.Add(inttostr(b)+'.00-'+inttostr(b)+'.59');
  if not loadconfig(cfgfile) then
    MessageDlgPos(MESSAGE13,mtError,[mbOK],0,
      (Form1.Left+Form1.Left+Form1.Width) div 2,
      (Form1.Top+Form1.Top+Form1.Height) div 2);
  TreeView1.Items.Item[1].Selected:=true;
  // fill combobox
  ComboBox1.Clear;
  for b:=0 to 15 do
   if length(pathremotefiles[b])>0 then
     ComboBox1.Items.Add(pathremotefiles[b]);
end;

end.

