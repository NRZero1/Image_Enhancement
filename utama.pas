unit Utama;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ExtDlgs, ComCtrls, Menus, CheckLst;

type

  { TFormUtama }

  TFormUtama = class(TForm)
    btnSave: TButton;
    btnLoad: TButton;
    btnWarna: TButton;
    btnRed: TButton;
    btnGreen: TButton;
    btnBlue: TButton;
    btnGray: TButton;
    btnBiner: TButton;
    btnMonoRed: TButton;
    btnMonoGreen: TButton;
    btnMonoBlue: TButton;
    btnBrightness: TButton;
    btnContrast: TButton;
    btnInvers: TButton;
    groupMonochrome: TGroupBox;
    groupPallete: TGroupBox;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblBinerValue: TLabel;
    Image1: TImage;
    lblContrastValue: TLabel;
    lblBrightValue: TLabel;
    lblGValue: TLabel;
    OpenPictureDialog1: TOpenPictureDialog;
    radioRed: TRadioButton;
    radioGreen: TRadioButton;
    radioBlue: TRadioButton;
    radioGray: TRadioButton;
    groupBiner: TRadioGroup;
    SavePictureDialog1: TSavePictureDialog;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    toggleCompare: TToggleBox;
    trackBiner: TTrackBar;
    trackContrast: TTrackBar;
    trackBright: TTrackBar;
    trackG: TTrackBar;
    procedure btnBinerClick(Sender: TObject);
    procedure btnBlueClick(Sender: TObject);
    procedure btnBrightnessClick(Sender: TObject);
    procedure btnContrastClick(Sender: TObject);
    procedure btnGrayClick(Sender: TObject);
    procedure btnGreenClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnMonoBlueClick(Sender: TObject);
    procedure btnMonoGreenClick(Sender: TObject);
    procedure btnMonoRedClick(Sender: TObject);
    procedure btnRedClick(Sender: TObject);
    procedure btnScalingClick(Sender: TObject);
    procedure btnWarnaClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnInversClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure toggleCompareChange(Sender: TObject);
    procedure trackBinerChange(Sender: TObject);
    procedure trackBrightChange(Sender: TObject);
    procedure trackContrastChange(Sender: TObject);
    procedure trackGChange(Sender: TObject);
    procedure ColorModeChange();
  private

  public

  end;

var
  FormUtama: TFormUtama;

implementation

{$R *.lfm}

uses
  windows;

var
  bitmapR, bitmapG, bitmapB: array [0..1000, 0..1000] of Byte;
  bitmapBiner: array[0..1000, 0..1000] of Boolean;
  modeWarna: Boolean;

{ TFormUtama }

procedure TFormUtama.btnLoadClick(Sender: TObject);
var
  x,y: Integer;
begin
  if OpenPictureDialog1.Execute then
  begin
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        bitmapR[x,y] := GetRValue(Image1.Canvas.Pixels[x,y]);
        bitmapG[x,y] := GetGValue(Image1.Canvas.Pixels[x,y]);
        bitmapB[x,y] := GetBValue(Image1.Canvas.Pixels[x,y]);
      end;
    end;
  end;

  modeWarna := true;
end;

procedure TFormUtama.ColorModeChange();
var
  x,y: Integer;
  gray: Byte;
begin
  if modeWarna then
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
        Image1.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
      end;
    end;
  end;
end;

procedure TFormUtama.btnMonoBlueClick(Sender: TObject);
var
  x,y: Integer;
begin
  btnGrayClick(Sender);
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0, 0, Blue(Image2.Canvas.Pixels[x,y]));
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(0, 0, Blue(Image1.Canvas.Pixels[x,y]));
      end;
    end;
  end;
end;

procedure TFormUtama.btnMonoGreenClick(Sender: TObject);
var
  x,y: Integer;
begin
  btnGrayClick(Sender);
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0, Green(Image2.Canvas.Pixels[x,y]), 0);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(0, Green(Image1.Canvas.Pixels[x,y]), 0);
      end;
    end;
  end;
end;

procedure TFormUtama.btnMonoRedClick(Sender: TObject);
var
  x,y: Integer;
begin
  btnGrayClick(Sender);
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(Red(Image2.Canvas.Pixels[x,y]), 0, 0);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(Red(Image1.Canvas.Pixels[x,y]), 0, 0);
      end;
    end;
  end;
end;

procedure TFormUtama.btnSaveClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then;
  begin
    if toggleCompare.Checked then
    begin
      Image2.Picture.SaveToFile(SavePictureDialog1.FileName);
    end
    else
    begin
      Image1.Picture.SaveToFile(SavePictureDialog1.FileName);
    end;
  end;
end;

procedure TFormUtama.btnInversClick(Sender: TObject);
var
  InversR: Byte;
  InversG: Byte;
  InversB: Byte;
  x,y: Integer;
  RGBMax: Byte;
  gray: Byte;
begin
  RGBMax := 255;
  if toggleCompare.Checked then
  begin
    if modeWarna then
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Width-1 do
        begin
          InversR := RGBMax - bitmapR[x,y];
          InversG := RGBMax - bitmapG[x,y];
          InversB := RGBMax - bitmapB[x,y];
          Image2.Canvas.Pixels[x,y] := RGB(InversR, InversG, InversB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Width-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          InversR := RGBMax - gray;
          InversG := RGBMax - gray;
          InversB := RGBMax - gray;
          Image2.Canvas.Pixels[x,y] := RGB(InversR, InversG, InversB);
        end;
      end;
    end;
  end
  else
  begin
    if modeWarna then
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          InversR := RGBMax - BitmapR[x,y];
          InversG := RGBMax - BitmapG[x,y];
          InversB := RGBMax - BitmapB[x,y];
          Image1.Canvas.Pixels[x,y] := RGB(InversR, InversG, InversB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          InversR := RGBMax - gray;
          InversG := RGBMax - gray;
          InversB := RGBMax - gray;
          Image1.Canvas.Pixels[x,y] := RGB(InversR, InversG, InversB);
        end;
      end;
    end;
  end;
end;

procedure TFormUtama.FormShow(Sender: TObject);
begin
  trackBinerChange(Sender);
  trackBrightChange(Sender);
  trackContrastChange(Sender);
  trackGChange(Sender);
  toggleCompareChange(Sender);
end;

procedure TFormUtama.toggleCompareChange(Sender: TObject);
var
  x,y: Integer;
begin
  if toggleCompare.Checked then
  begin
    ScrollBox2.Visible := true;
    Image2.Visible := true;
    Image1.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    Image2.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end
  else
  begin
    ScrollBox2.Visible := false;
    Image2.Visible := false;
  end;
end;

procedure TFormUtama.trackGChange(Sender: TObject);
var
  GValue: Integer;
begin
  GValue := trackG.Position;
  lblGValue.Caption := IntToStr(GValue);
end;

procedure TFormUtama.trackContrastChange(Sender: TObject);
var
  ContrastValue: Integer;
begin
  ContrastValue := trackContrast.Position;
  lblContrastValue.Caption := IntToStr(ContrastValue);
end;

procedure TFormUtama.trackBrightChange(Sender: TObject);
var
  BrightnessValue: Integer;
begin
  BrightnessValue := trackBright.Position;
  lblBrightValue.Caption := IntToStr(BrightnessValue);
end;

procedure TFormUtama.trackBinerChange(Sender: TObject);
var
  BinerValue: Integer;
begin
  BinerValue := trackBiner.Position;
  lblBinerValue.Caption := IntToStr(BinerValue);
end;

procedure TFormUtama.btnGreenClick(Sender: TObject);
var
  x,y: Integer;
begin
  modeWarna := true;
  ColorModeChange();
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0, bitmapG[x,y], 0);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(0, bitmapG[x,y], 0);
      end;
    end;
  end;
end;

procedure TFormUtama.btnBlueClick(Sender: TObject);
var
  x,y: Integer;
begin
  modeWarna := true;
  ColorModeChange();
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0, 0, bitmapB[x,y]);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(0, 0, bitmapB[x,y]);
      end;
    end;
  end;
end;

procedure TFormUtama.btnBrightnessClick(Sender: TObject);
var
  BrightnessR: Integer;
  BrightnessG: Integer;
  BrightnessB: Integer;
  x,y: Integer;
  BrightnessLevel: Integer;
  gray: Byte;
begin
  BrightnessLevel := trackBright.Position;
  if toggleCompare.Checked then
  begin
    if modeWarna then
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Height-1 do
        begin
          BrightnessR := bitmapR[x,y] + BrightnessLevel;
          BrightnessG := bitmapG[x,y] + BrightnessLevel;
          BrightnessB := bitmapB[x,y] + BrightnessLevel;

          if BrightnessR < 0 then
          begin
            BrightnessR := 0;
          end;
          if BrightnessR > 255 then
          begin
            BrightnessR := 255;
          end;

          if BrightnessG < 0 then
          begin
            BrightnessG := 0;
          end;
          if BrightnessG > 255 then
          begin
            BrightnessG := 255;
          end;

          if BrightnessB < 0 then
          begin
            BrightnessB := 0;
          end;
          if BrightnessB > 255 then
          begin
            BrightnessB := 255;
          end;

          Image2.Canvas.Pixels[x,y] := RGB(BrightnessR, BrightnessG, BrightnessB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Height-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          BrightnessR := gray + BrightnessLevel;
          BrightnessG := gray + BrightnessLevel;
          BrightnessB := gray + BrightnessLevel;

          if BrightnessR < 0 then
          begin
            BrightnessR := 0;
          end;
          if BrightnessR > 255 then
          begin
            BrightnessR := 255;
          end;

          if BrightnessG < 0 then
          begin
            BrightnessG := 0;
          end;
          if BrightnessG > 255 then
          begin
            BrightnessG := 255;
          end;

          if BrightnessB < 0 then
          begin
            BrightnessB := 0;
          end;
          if BrightnessB > 255 then
          begin
            BrightnessB := 255;
          end;

          Image2.Canvas.Pixels[x,y] := RGB(BrightnessR, BrightnessG, BrightnessB);
        end;
      end;
    end;
  end
  else
  begin
    if modeWarna then
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          BrightnessR := bitmapR[x,y] + BrightnessLevel;
          BrightnessG := bitmapG[x,y] + BrightnessLevel;
          BrightnessB := bitmapB[x,y] + BrightnessLevel;

          if BrightnessR < 0 then
          begin
            BrightnessR := 0;
          end;
          if BrightnessR > 255 then
          begin
            BrightnessR := 255;
          end;

          if BrightnessG < 0 then
          begin
            BrightnessG := 0;
          end;
          if BrightnessG > 255 then
          begin
            BrightnessG := 255;
          end;

          if BrightnessB < 0 then
          begin
            BrightnessB := 0;
          end;
          if BrightnessB > 255 then
          begin
            BrightnessB := 255;
          end;

          Image1.Canvas.Pixels[x,y] := RGB(BrightnessR, BrightnessG, BrightnessB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          BrightnessR := gray + BrightnessLevel;
          BrightnessG := gray + BrightnessLevel;
          BrightnessB := gray + BrightnessLevel;

          if BrightnessR < 0 then
          begin
            BrightnessR := 0;
          end;
          if BrightnessR > 255 then
          begin
            BrightnessR := 255;
          end;

          if BrightnessG < 0 then
          begin
            BrightnessG := 0;
          end;
          if BrightnessG > 255 then
          begin
            BrightnessG := 255;
          end;

          if BrightnessB < 0 then
          begin
            BrightnessB := 0;
          end;
          if BrightnessB > 255 then
          begin
            BrightnessB := 255;
          end;

          Image1.Canvas.Pixels[x,y] := RGB(BrightnessR, BrightnessG, BrightnessB);
        end;
      end;
    end;
  end;
end;

procedure TFormUtama.btnContrastClick(Sender: TObject);
var
  ContrastR: Integer;
  ContrastG: Integer;
  ContrastB: Integer;
  x,y: Integer;
  gray: Byte;
  P,G: Integer;
begin
  P := trackContrast.Position;
  G := trackG.Position;
  if toggleCompare.Checked then
  begin
    if modeWarna then
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Width-1 do
        begin
          ContrastR := G*(bitmapR[x,y] - P) + P;
          ContrastG := G*(bitmapG[x,y] - P) + P;
          ContrastB := G*(bitmapB[x,y] - P) + P;

          if ContrastR < 0 then
          begin
            ContrastR := 0;
          end;
          if ContrastR > 255 then
          begin
            ContrastR := 255;
          end;

          if ContrastG < 0 then
          begin
            ContrastG := 0;
          end;
          if ContrastG > 255 then
          begin
            ContrastG := 255;
          end;

          if ContrastB < 0 then
          begin
            ContrastB := 0;
          end;
          if ContrastB > 255 then
          begin
            ContrastB := 255;
          end;

          Image2.Canvas.Pixels[x,y] := RGB(ContrastR, ContrastG, ContrastB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image2.Height-1 do
      begin
        for x:=0 to Image2.Width-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          ContrastR := G*(gray - P) + P;
          ContrastG := G*(gray - P) + P;
          ContrastB := G*(gray - P) + P;

          if ContrastR < 0 then
          begin
            ContrastR := 0;
          end;
          if ContrastR > 255 then
          begin
            ContrastR := 255;
          end;

          if ContrastG < 0 then
          begin
            ContrastG := 0;
          end;
          if ContrastG > 255 then
          begin
            ContrastG := 255;
          end;

          if ContrastB < 0 then
          begin
            ContrastB := 0;
          end;
          if ContrastB > 255 then
          begin
            ContrastB := 255;
          end;

          Image2.Canvas.Pixels[x,y] := RGB(ContrastR, ContrastG, ContrastB);
        end;
      end;
    end;
  end
  else
  begin
    if modeWarna then
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          ContrastR := G*(bitmapR[x,y] - P) + P;
          ContrastG := G*(bitmapG[x,y] - P) + P;
          ContrastB := G*(bitmapB[x,y] - P) + P;

          if ContrastR < 0 then
          begin
            ContrastR := 0;
          end;
          if ContrastR > 255 then
          begin
            ContrastR := 255;
          end;

          if ContrastG < 0 then
          begin
            ContrastG := 0;
          end;
          if ContrastG > 255 then
          begin
            ContrastG := 255;
          end;

          if ContrastB < 0 then
          begin
            ContrastB := 0;
          end;
          if ContrastB > 255 then
          begin
            ContrastB := 255;
          end;

          Image1.Canvas.Pixels[x,y] := RGB(ContrastR, ContrastG, ContrastB);
        end;
      end;
    end
    else
    begin
      for y:=0 to Image1.Height-1 do
      begin
        for x:=0 to Image1.Width-1 do
        begin
          gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
          ContrastR := G*(gray - P) + P;
          ContrastG := G*(gray - P) + P;
          ContrastB := G*(gray - P) + P;

          if ContrastR < 0 then
          begin
            ContrastR := 0;
          end;
          if ContrastR > 255 then
          begin
            ContrastR := 255;
          end;

          if ContrastG < 0 then
          begin
            ContrastG := 0;
          end;
          if ContrastG > 255 then
          begin
            ContrastG := 255;
          end;

          if ContrastB < 0 then
          begin
            ContrastB := 0;
          end;
          if ContrastB > 255 then
          begin
            ContrastB := 255;
          end;

          Image1.Canvas.Pixels[x,y] := RGB(ContrastR, ContrastG, ContrastB);
        end;
      end;
    end;
  end;
end;

procedure TFormUtama.btnBinerClick(Sender: TObject);
var
  x,y: Integer;
begin
  btnGrayClick(Sender);

  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        bitmapBiner[x,y] := trackBiner.Position > Red(Image2.Canvas.Pixels[x,y]);
      end;
    end;

    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        if bitmapBiner[x,y] = True then
        begin
          Image2.Canvas.Pixels[x,y] := RGB(255,255,255);
        end
        else
        begin
          if radioRed.Checked then
          begin
            Image2.Canvas.Pixels[x,y] := RGB(255,0,0);
          end
          else if radioGreen.Checked then
          begin
            Image2.Canvas.Pixels[x,y] := RGB(0,255,0);
          end
          else if radioBlue.Checked then
          begin
            Image2.Canvas.Pixels[x,y] := RGB(0,0,255);
          end
          else
          begin
            Image2.Canvas.Pixels[x,y] := RGB(0,0,0);
          end;
        end;
      end;
    end;
  end

  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        bitmapBiner[x,y] := trackBiner.Position > Red(Image1.Canvas.Pixels[x,y]);
      end;
    end;

    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        if bitmapBiner[x,y] = True then
        begin
          Image1.Canvas.Pixels[x,y] := RGB(255,255,255);
        end
        else
        begin
          if radioRed.Checked then
          begin
            Image1.Canvas.Pixels[x,y] := RGB(255,0,0);
          end
          else if radioGreen.Checked then
          begin
            Image1.Canvas.Pixels[x,y] := RGB(0,255,0);
          end
          else if radioBlue.Checked then
          begin
            Image1.Canvas.Pixels[x,y] := RGB(0,0,255);
          end
          else
          begin
            Image1.Canvas.Pixels[x,y] := RGB(0,0,0);
          end;
        end;
      end;
    end;
  end;
end;

procedure TFormUtama.btnGrayClick(Sender: TObject);
var
  x,y: Integer;
  gray: Byte;
begin
  modeWarna := false;

  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        gray := (bitmapR[x,y] + bitmapG[x,y] + bitmapB[x,y]) div 3;
        Image2.Canvas.Pixels[x,y] := RGB(gray, gray, gray);
      end;
    end;
  end;
  ColorModeChange();
end;

procedure TFormUtama.btnRedClick(Sender: TObject);
var
  x,y: Integer;
begin
  modeWarna := true;
  ColorModeChange();
  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], 0, 0);
      end;
    end;
  end
  else
  begin
    for y:=0 to Image1.Height-1 do
    begin
      for x:=0 to Image1.Width-1 do
      begin
        Image1.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], 0, 0);
      end;
    end;
  end;
end;

procedure TFormUtama.btnScalingClick(Sender: TObject);
var
  x,y: Byte;
  x_temp: array[0..1000,0..1000] of Byte;
  y_temp: array[0..1000,0..1000] of Byte;
begin
end;

procedure TFormUtama.btnWarnaClick(Sender: TObject);
var
  x,y: Integer;
begin
  modeWarna := true;

  if toggleCompare.Checked then
  begin
    for y:=0 to Image2.Height-1 do
    begin
      for x:=0 to Image2.Width-1 do
      begin
        Image2.Canvas.Pixels[x,y] := RGB(bitmapR[x,y], bitmapG[x,y], bitmapB[x,y]);
      end;
    end;
  end;
  ColorModeChange();
end;

end.

