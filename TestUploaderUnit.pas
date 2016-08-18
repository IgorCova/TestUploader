unit TestUploaderUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ShlObj, cxShellCommon, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxShellComboBox, StdCtrls, cxCheckBox, Menus,
  cxButtons, Vcl.ExtCtrls, System.Actions, Vcl.ActnList, cxButtonEdit,
  Vcl.ImgList, Vcl.Imaging.GIFImg, dxGDIPlusClasses, cxClasses, cxImage, cxLabel, GxPanel, TB2Item, SpTBXItem;

type
  TFTestUploader = class(TForm)
    ilEmpty: TImageList;
    alActions: TActionList;
    aBeginWork: TAction;
    imgOpen: TcxImage;
    aClose: TAction;
    aHIde: TAction;
    aShowMenu: TAction;
    aShow: TAction;
    tiEmptyIcon: TTrayIcon;
    pmRb: TSpTBXPopupMenu;
    rbiClose: TTBItem;
    pnlSettings: TGxPanel;
    pnlTasks: TGxPanel;
    imgBackground: TcxImage;
    lbTask: TcxLabel;
    edtTask: TcxTextEdit;
    cbMS: TcxCheckBox;
    cbAPS: TcxCheckBox;
    cbCVL: TcxCheckBox;
    cbCRM: TcxCheckBox;
    cbHR: TcxCheckBox;
    cbIns: TcxCheckBox;
    cbSSU: TcxCheckBox;
    cbMSCbpl: TcxCheckBox;
    cbROS: TcxCheckBox;
    cbRC: TcxCheckBox;
    cbSIO: TcxCheckBox;
    cbRSM: TcxCheckBox;
    cbCar: TcxCheckBox;
    imgClose: TcxImage;
    imgHideWindow: TcxImage;
    imgMenu: TcxImage;
    imgGo: TcxImage;
    imgMenuBack: TcxImage;
    cxLabel1: TcxLabel;
    scbWinRar: TcxShellComboBox;
    scbWork: TcxShellComboBox;
    cxLabel2: TcxLabel;
    cbRst: TcxCheckBox;
    aEvery: TAction;
    aColorizeChecks: TAction;
    aMeLike: TAction;
    tmrIsdrift: TTimer;
    cbCx: TcxCheckBox;
    cbLib: TcxCheckBox;
    cbTaxi: TcxCheckBox;
    cbMts: TcxCheckBox;
    cbEvery: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure imgSetttingClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure aBeginWorkExecute(Sender: TObject);
    procedure aCloseExecute(Sender: TObject);
    procedure aHIdeExecute(Sender: TObject);
    procedure aShowMenuExecute(Sender: TObject);
    procedure aShowExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure aEveryExecute(Sender: TObject);
    procedure aColorizeChecksExecute(Sender: TObject);
    procedure aMeLikeExecute(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure imgOpenFocusChanged(Sender: TObject);
    procedure LastFocus(var Mess : TMessage); message WM_ACTIVATE;
    procedure tmrIsdriftTimer(Sender: TObject);
    procedure AppMinimize(Sender: TObject);
    procedure imgBackgroundClick(Sender: TObject);
  private
    IsDrift : Boolean;
    IsCreateDrift : Boolean;
    IsOpenWindow : Boolean;
    delx, dely : integer;
    IsAll : boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTestUploader: TFTestUploader;

implementation
uses IniFiles, ShellAPI;
{$R *.dfm}

procedure TFTestUploader.LastFocus(var Mess : TMessage);
var
MyMouse: TMouse;
begin
 // if  Mess.wParam = WA_INACTIVE then
   // aHIde.Execute;
end;

procedure TFTestUploader.tmrIsdriftTimer(Sender: TObject);
begin
  if IsCreateDrift then aShow.Execute;
end;

procedure TFTestUploader.FormCreate(Sender: TObject);
var
  IniFile: TIniFile;
  MyMouse: TMouse;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    scbWinRar.AbsolutePath := IniFile.ReadString('Path', 'WinRar', '');
    scbWork.AbsolutePath   := IniFile.ReadString('Path', 'Work', '');
    edtTask.Text           := IniFile.ReadString('Task', 'Num', '');
  finally
    IniFile.Free;
  end;
  FTestUploader.Left := MyMouse.CursorPos.x - 35 ;
  FTestUploader.Top := MyMouse.CursorPos.y - 45;
  if FTestUploader.Left < 1 then FTestUploader.Left := 0;
  if FTestUploader.Top < 1 then FTestUploader.Top := 0;
  FTestUploader.Width := 105;
  FTestUploader.Height := 70;
  IsCreateDrift := True;
  imgOpen.Cursor := crHandPoint;

//  SetWindowLong(Application.Handle, GWL_EXSTYLE, NOT WS_EX_APPWINDOW);
//  Application.OnMinimize := AppMinimize;
//  Application.OnRestore := AppMinimize;
//  Application.Minimize;
//  AppMinimize(Self);
end;

procedure TFTestUploader.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var CountPlus: Integer;
begin
  if edtTask.Focused then
  begin
    if key = 13 then
      aBeginWork.Execute;
  end else begin
    if key =  96 then cbSio.Checked    := not cbSio.Checked;       //0
    if key =  97 then cbCRM.Checked    := not cbCRM.Checked;       //1
    if key =  98 then cbCVL.Checked    := not cbCVL.Checked;       //2
    if key =  99 then cbRc.Checked     := not cbRc.Checked;        //3
    if key = 100 then cbHr.Checked     := not cbHr.Checked;        //4
    if key = 101 then cbIns.Checked    := not cbIns.Checked;       //5
    if key = 102 then cbSSu.Checked    := not cbSSU.Checked;       //6
    if key = 103 then cbAPS.Checked    := not cbAPS.Checked;       //7
    if key = 104 then cbCAr.Checked    := not cbCAr.Checked;       //8
    if key = 105 then cbRSM.Checked    := not cbRSM.Checked;       //9
    if key = 111 then cbTaxi.Checked   := not cbTaxi.Checked;      ///

    if key = 107 then //+
    begin
      if cbMSCbpl.Checked then
        CountPlus := 1
      else
        CountPlus := 0;

      if cbCx.Checked then
        CountPlus := 2;

      if cbLib.Checked then
        CountPlus := 3;

      if CountPlus = 0 then
        cbMSCbpl.Checked := not cbMSCbpl.Checked
      else if CountPlus = 1 then
        cbCx.Checked := not cbCx.Checked
      else if CountPlus = 2 then
        cbLib.Checked := not cbLib.Checked
      else if CountPLus = 3 then
      begin
         cbMSCbpl.Checked := False;
         cbCx.Checked := False;
         cbLib.Checked  := False;
      end;
    end;

    if key = 109 then cbMS.Checked     := not cbMS.Checked;        //-
    if key = 110 then cbROS.Checked    := not cbROS.Checked;      //,
    if key = 106 then cbRst.Checked    := not cbRst.Checked;        //*
    if key = 190 then cbMts.Checked    := not cbMts.Checked;      // > / . / ю ';
    if key = 13 then  edtTask.SetFocus;
  end;
end;

procedure TFTestUploader.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  delx := x;
  dely := y;
  IsDrift := True;
end;

procedure TFTestUploader.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var MyMouse : TMouse;
begin
  if IsDrift then
  begin
    FTestUploader.Left := FTestUploader.Left + x - delx ;
    FTestUploader.Top := FTestUploader.Top + y - dely;
    if FTestUploader.Left < 1 then FTestUploader.Left := 0;
    if FTestUploader.Top < 1 then FTestUploader.Top := 0;
  end;
  imgOpen.Height := 75;
  if IsCreateDrift then
  begin
    if not aShow.Enabled then
      aShow.Enabled := True;
    FTestUploader.Left := MyMouse.CursorPos.x - 60 ;
    FTestUploader.Top := MyMouse.CursorPos.y - 35;
  end;
end;

procedure TFTestUploader.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  IsDrift := False;
  imgOpen.Height := 70;
end;

procedure TFTestUploader.imgBackgroundClick(Sender: TObject);
begin
  WinExec(PAnsiChar('ibserver.exe'), SW_SHOWNORMAL);
end;

procedure TFTestUploader.imgOpenFocusChanged(Sender: TObject);
var MyMouse : TMouse;
begin

end;

procedure TFTestUploader.imgSetttingClick(Sender: TObject);
begin
  pnlSettings.Visible :=  not pnlSettings.Visible;
end;

procedure TFTestUploader.FormClick(Sender: TObject);
begin
  aShow.Execute;
end;

procedure TFTestUploader.FormClose(Sender: TObject; var Action: TCloseAction);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    IniFile.WriteString('Path', 'WinRar',scbWinRar.AbsolutePath);
    IniFile.WriteString('Path', 'Work',  scbWork.AbsolutePath  );
    IniFile.WriteString('Task', 'Num',   edtTask.Text          );
  finally
    IniFile.Free;
  end;
end;

procedure TFTestUploader.aBeginWorkExecute(Sender: TObject);
const
  _param = 'a -ep  %0:s %1:s';
  _file = '\\str-data.aamajor.local\DevFile\TestBuilds\%0:s\EmptyParam.rar';
var
  rar, param, work, afile: String;
begin
  rar := scbWinRar.AbsolutePath + '\rar.exe';
  param := '';
  if cbMS.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbMS.Hint;//'"' + scbWork.AbsolutePath + '\' + cbMS.Hint + '"'
  end;
  if cbAPS.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbAPS.Hint;//'"' + scbWork.AbsolutePath + '\' + cbAPS.Hint + '"'
  end;
  if cbCar.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbCar.Hint;//scbWork.AbsolutePath + '\' + cbCar.Hint + '"'
  end;
  if cbCRM.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbCRM.Hint;//'"' + scbWork.AbsolutePath + '\' + cbCRM.Hint + '"'
  end;
  if cbCVL.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbCVL.Hint;//'"' + scbWork.AbsolutePath + '\' + cbCVL.Hint + '"'
  end;
  if cbHR.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbHR.Hint;//'"' + scbWork.AbsolutePath + '\' + cbHR.Hint + '"'
  end;
  if cbIns.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbIns.Hint;//'"' + scbWork.AbsolutePath + '\' + cbIns.Hint + '"'
  end;
  if cbRC.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbRC.Hint;//'"' + scbWork.AbsolutePath + '\' + cbRC.Hint + '"'
  end;
  if cbROS.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbROS.Hint;//'"' + scbWork.AbsolutePath + '\' + cbROS.Hint + '"'
  end;
  if cbRSM.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbRSM.Hint;//'"' + scbWork.AbsolutePath + '\' + cbRSM.Hint + '"'
  end;
  if cbSIO.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbSIO.Hint;//'"' + scbWork.AbsolutePath + '\' + cbSIO.Hint + '"'
  end;
  if cbSSU.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbSSU.Hint;//"' + scbWork.AbsolutePath + '\' + cbSSU.Hint + '"'
  end;
  if cbMSCbpl.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbMSCbpl.Hint;//"' + scbWork.AbsolutePath + '\' + cbMSCbpl.Hint + '"'
  end;
  if cbCx.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbCx.Hint;//"' + scbWork.AbsolutePath + '\' + cbCx.Hint + '"'
  end;
  if cbLib.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbLib.Hint;//"' + scbWork.AbsolutePath + '\' + cbLib.Hint + '"'
  end;
  if cbTaxi.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbTaxi.Hint;//"' + scbWork.AbsolutePath + '\' + cbLib.Hint + '"'
  end;
  if cbMts.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbMts.Hint;//"' + scbWork.AbsolutePath + '\' + cbLib.Hint + '"'
  end;
  if cbRst.Checked then
  begin
    if param <> '' then
      param := param + ' ';
    param := param + cbRst.Hint;//"' + scbWork.AbsolutePath + '\' + cbLib.Hint + '"'
  end;

  if cbMS.Checked
    or cbAPS.Checked
    or cbCar.Checked
    or cbCRM.Checked
    or cbCVL.Checked
    or cbHR.Checked
    or cbIns.Checked
    or cbRC.Checked
    or cbROS.Checked
    or cbRSM.Checked
    or cbSIO.Checked
    or cbSSU.Checked
    or cbMSCbpl.Checked
    or cbCx.Checked
    or cbLib.Checked
    or cbTaxi.Checked
    or cbMts.Checked
    or cbRst.Checked then
  begin
    afile := Format(_file, [edtTask.Text]);
    param := Format(_param, [afile, param]);
    work := scbWork.AbsolutePath;
    if FileExists(afile) then
      DeleteFile(afile);
    if not DirectoryExists(ExtractFilePath(afile)) then
      CreateDir(ExtractFilePath(afile));
    ShellExecute(0, nil, PWideChar(rar), PWideChar(param), PWideChar(work), SW_RESTORE);
  end
  else
  cbEvery.SetFocus;
  aHIde.Execute;
end;

procedure TFTestUploader.aCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFTestUploader.aColorizeChecksExecute(Sender: TObject);
var
  TextColorCheck : TColor;
  TextColorUnCheck : TColor;
begin
  TextColorCheck := clLime;
  TextColorUnCheck := $00FFC68C;
  if cbEvery.Checked then
    cbEvery.Style.BorderColor := TextColorCheck
  else cbEvery.Style.BorderColor := TextColorUnCheck;

  if cbSio.Checked then
    cbSio.Style.BorderColor := TextColorCheck
  else cbSio.Style.BorderColor := TextColorUnCheck;

  if cbCRM.Checked then
    cbCRM.Style.BorderColor := TextColorCheck
  else cbCRM.Style.BorderColor := TextColorUnCheck;

  if cbCVL.Checked then
    cbCVL.Style.BorderColor := TextColorCheck
  else cbCVL.Style.BorderColor := TextColorUnCheck;

  if cbRc.Checked then
    cbRc.Style.BorderColor := TextColorCheck
  else cbRc.Style.BorderColor := TextColorUnCheck;

  if cbIns.Checked then
    cbIns.Style.BorderColor := TextColorCheck
  else cbIns.Style.BorderColor := TextColorUnCheck;

  if cbHr.Checked then
    cbHr.Style.BorderColor := TextColorCheck
  else cbHr.Style.BorderColor := TextColorUnCheck;

  if cbSSu.Checked then
    cbSSu.Style.BorderColor := TextColorCheck
  else cbSSu.Style.BorderColor := TextColorUnCheck;

  if cbCAr.Checked then
    cbCAr.Style.BorderColor := TextColorCheck
  else cbCAr.Style.BorderColor := TextColorUnCheck;

  if cbaps.Checked then
    cbaps.Style.BorderColor := TextColorCheck
  else cbaps.Style.BorderColor := TextColorUnCheck;

  if cbRSM.Checked then
    cbRSM.Style.BorderColor := TextColorCheck
  else cbRSM.Style.BorderColor := TextColorUnCheck;

  if cbMSCbpl.Checked then
    cbMSCbpl.Style.BorderColor := TextColorCheck
  else cbMSCbpl.Style.BorderColor := TextColorUnCheck;

  if cbMS.Checked then
    cbMS.Style.BorderColor := TextColorCheck
  else cbMS.Style.BorderColor := TextColorUnCheck;

  if cbROS.Checked then
    cbROS.Style.BorderColor := TextColorCheck
  else cbROS.Style.BorderColor := TextColorUnCheck;

  if cbCx.Checked then
    cbCx.Style.BorderColor := TextColorCheck
  else cbCx.Style.BorderColor := TextColorUnCheck;

  if cbLib.Checked then
    cbLib.Style.BorderColor := TextColorCheck
  else cbLib.Style.BorderColor := TextColorUnCheck;

  if cbTaxi.Checked then
    cbTaxi.Style.BorderColor := TextColorCheck
  else cbTaxi.Style.BorderColor := TextColorUnCheck;

  if cbMts.Checked then
    cbMts.Style.BorderColor := TextColorCheck
  else cbMts.Style.BorderColor := TextColorUnCheck;

  if cbRst.Checked then
    cbRst.Style.BorderColor := TextColorCheck
  else cbRst.Style.BorderColor := TextColorUnCheck;
end;

procedure TFTestUploader.aEveryExecute(Sender: TObject);
begin
  IsAll   := cbEvery.Checked;
  cbEvery.Checked  := IsAll;
  cbSio.Checked    := IsAll;
  cbCRM.Checked    := IsAll;
  cbCVL.Checked    := IsAll;
  cbRc.Checked     := IsAll;
  cbIns.Checked    := IsAll;
  cbHr.Checked     := IsAll;
  cbIns.Checked    := IsAll;
  cbSSu.Checked    := IsAll;
  cbAPS.Checked    := IsAll;
  cbCAr.Checked    := IsAll;
  cbRSM.Checked    := IsAll;
  cbMSCbpl.Checked := IsAll;
  cbMS.Checked     := IsAll;
  cbROS.Checked    := IsAll;
  cbCx.Checked     := IsAll;
  cbLib.Checked    := IsAll;
  cbTaxi.Checked   := IsAll;
  cbMts.Checked   := IsAll;
  cbRst.Checked   := IsAll;
end;

procedure TFTestUploader.aHIdeExecute(Sender: TObject);
begin
  IsOpenWindow := False;
  FTestUploader.Height := 70;
  FTestUploader.Width := 110;
  aHIde.Enabled  := False;
  aBeginWork.Enabled  := False;
  aClose.Enabled  := False;
  aShowMenu.Enabled  := False;
end;

procedure TFTestUploader.aMeLikeExecute(Sender: TObject);
const
  _file = '\\192.168.3.147\Users\Public\Desktop\ћнеЌравитс€.txt';
  _param = 'a -ep  %0:s %1:s';
begin
//Ќадо будет сделать
end;

procedure TFTestUploader.AppMinimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TFTestUploader.aShowExecute(Sender: TObject);
begin
  IsCreateDrift := False;
  IsOpenWindow := True;
  FTestUploader.Height := 390;
  FTestUploader.Width := 400;
  aHIde.Enabled  := True;
  aBeginWork.Enabled  := True;
  aClose.Enabled  := True;
  aShowMenu.Enabled  := True;
  pnlSettings.Visible := False;
  pnlTasks.Visible := True
end;

procedure TFTestUploader.aShowMenuExecute(Sender: TObject);
begin
  pnlSettings.Visible := not pnlSettings.Visible;
  pnlTasks.Visible :=  not pnlSettings.Visible
end;

procedure TFTestUploader.btnExitClick(Sender: TObject);
begin
  FTestUploader.Hide;
  FTestUploader.Close;
end;

end.
