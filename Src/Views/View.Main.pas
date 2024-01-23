unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Math,
  System.Math.Vectors, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls3D, FMX.Layers3D, FMX.Objects3D,
  FMX.Viewport3D, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Types3D, FMX.Objects;

type
  TFrmMainView = class(TForm)
    Viewport3D1: TViewport3D;
    MmLog: TMemo;
    BtnCubeScreenCoord: TButton;
    LblMouseCoord: TLabel;
    EdtCoord: TEdit;
    Cube1: TCube;
    PaintBox1: TPaintBox;
    Layer3D1: TLayer3D;
    Layer3D2: TLayer3D;
    Switch1: TSwitch;
    Circle1: TCircle;
    Circle2: TCircle;
    Circle3: TCircle;
    Circle4: TCircle;
    Circle5: TCircle;
    BtnForm3D: TButton;
    procedure BtnCubeScreenCoordClick(Sender: TObject);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure Switch1Click(Sender: TObject);
    procedure BtnForm3DClick(Sender: TObject);
  private
    { Private declarations }
    procedure LogViewportSize();
    procedure PaintElements(ABmp: TBitmap; AVP: TViewport3D; ACube: TCube);
  public
    { Public declarations }
  end;

var
  FrmMainView: TFrmMainView;

implementation

{$R *.fmx}

uses
  View.Game,
  Helper3D;

type
  TFakeCube = class(TCube);

procedure TFrmMainView.BtnCubeScreenCoordClick(Sender: TObject);
begin
  var tmpsp: TLayer2DCoords;
  tmpsp := ScreenHelper.CalculateLayerSize(Viewport3D1.Context, Layer3D1);
  MmLog.Lines.Add('Layer Pixel Size: ' + tmpsp.Size.X.ToString + ' ' + tmpsp.Size.Y.ToString);
end;

procedure TFrmMainView.FormCreate(Sender: TObject);
var
  Camera: TCamera;
  iI, FSize: Integer;
  FLabl: String;
  tmpsp: TPoint3D;
  tmpr: TRectF;
begin
  { LOG Size }
  LogViewportSize();
  PaintBox1.Visible := True;
end;

procedure TFrmMainView.FormResize(Sender: TObject);
begin
  LogViewportSize();
end;

procedure TFrmMainView.LogViewportSize();
begin
  MmLog.Lines.Add('Position: ' + Viewport3D1.Position.X.ToString + ', ' + Viewport3D1.Position.Y.ToString);
  MmLog.Lines.Add('Size: ' + Viewport3D1.Width.ToString + ', ' + Viewport3D1.Height.ToString);
end;

procedure TFrmMainView.PaintElements(ABmp: TBitmap; AVP: TViewport3D; ACube: TCube);
const
  DRAW_STRING_NEW_LINE = 16;
var
  Camera: TCamera;
  iI, FSize: Integer;
  FLabl: String;
  tmpsp: TPoint3D;
  tmpr: TRectF;
begin
  FSize := 3;
  ABMP.Canvas.Fill.Color := TAlphaColorRec.Green;
  ABMP.Canvas.Stroke.Color := ABMP.Canvas.Fill.Color;
  ABMP.Canvas.Stroke.Kind := TBrushKind.Solid;
  ABMP.Canvas.Stroke.Thickness := 1;


  MmLog.Lines.Add('POSITION CENTER: ' + Layer3D1.Position.X.ToString + ', ' + (Layer3D1.Position.Y-Layer3D1.Height/2.0).ToString);


  tmpsp := AVP.Context.WorldToScreen(TProjection.Camera,TPoint3D.Create(Layer3D1.Position.X, Layer3D1.Position.Y, Layer3D1.Position.Z));
  FLabl := Format('X:%0.2f Y:%0.2f',[tmpsp.X,tmpsp.Y]);

  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context,
    TPoint3D.Zero, Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  Circle1.Position.X := tmpsp.X - Circle1.Width / 2;
  Circle1.Position.Y := tmpsp.Y - Circle1.Width / 2;

  tmpsp.X := tmpsp.X - PaintBox1.Position.X;
  tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
  tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
  ABMP.Canvas.FillEllipse(tmpr,100, TBrush.Create(TBrushKind.Solid,TAlphaColorRec.Aqua));

  tmpsp := TPoint3D.Zero;
  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context,
    TPoint3D.Create(-Layer3D1.Width/2, -Layer3D1.Height/2, 0.0), Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  Circle2.Position.X := tmpsp.X - Circle2.Width / 2;
  Circle2.Position.Y := tmpsp.Y - Circle2.Width / 2;

  tmpsp.X := tmpsp.X - PaintBox1.Position.X;
  tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
  tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
  ABMP.Canvas.FillEllipse(tmpr, 100, TBrush.Create(TBrushKind.Solid,TAlphaColorRec.Beige));


  tmpsp := TPoint3D.Zero;
  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context,
    TPoint3D.Create(Layer3D1.Width/2, -Layer3D1.Height/2, 0.0), Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  Circle3.Position.X := tmpsp.X - Circle3.Width / 2;
  Circle3.Position.Y := tmpsp.Y - Circle3.Width / 2;

  tmpsp.X := tmpsp.X - PaintBox1.Position.X;
  tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
  tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
  ABMP.Canvas.FillEllipse(tmpr, 100, TBrush.Create(TBrushKind.Solid,TAlphaColorRec.Firebrick));


  tmpsp := TPoint3D.Zero;
  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context,
    TPoint3D.Create(-Layer3D1.Width/2, Layer3D1.Height/2, 0.0), Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  Circle4.Position.X := tmpsp.X - Circle4.Width / 2;
  Circle4.Position.Y := tmpsp.Y - Circle4.Width / 2;

  tmpsp.X := tmpsp.X - PaintBox1.Position.X;
  tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
  tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
  ABMP.Canvas.FillEllipse(tmpr, 100, TBrush.Create(TBrushKind.Solid,TAlphaColorRec.Yellow));


  tmpsp := TPoint3D.Zero;
  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context,
    TPoint3D.Create(Layer3D1.Width/2, Layer3D1.Height/2, 0.0), Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  Circle5.Position.X := tmpsp.X - Circle5.Width / 2;
  Circle5.Position.Y := tmpsp.Y - Circle5.Width / 2;

  tmpsp.X := tmpsp.X - PaintBox1.Position.X;
  tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
  tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
  ABMP.Canvas.FillEllipse(tmpr, 100, TBrush.Create(TBrushKind.Solid,TAlphaColorRec.Red));


  var FakeCube: TFakeCube;
  FakeCube := TFakeCube(ACube);
  var Vertices: integer := FakeCube.Data.VertexBuffer.Length -1;
  var Scale := TPoint3D.Create(FakeCube.FScale.X, FakeCube.FScale.Y, FakeCube.FScale.Z);

  var PtOffset := AVP.Context.WorldToScreen(TProjection.Camera, ACube.Position.Point);
  MmLog.Lines.Add('Offset: ' + PtOffset.X.ToString + ', ' + PtOffset.Y.ToString + ', ' + PtOffset.Z.ToString);

  MmLog.Lines.Add('Fake C Position: ' + FakeCube.Position.X.ToString + ', ' + FakeCube.Position.Y.ToString + ', ' + FakeCube.Position.Z.ToString);
  MmLog.Lines.Add('Fake C Scale: ' + Scale.X.ToString + ', ' + Scale.Y.ToString + ', ' + Scale.Z.ToString);

  tmpsp := TPoint3D.Zero;
  tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context, FakeCube.Data.VertexBuffer.Vertices[0], Scale, ACube.RotationAngle.Point, ACube.Position.Point);

  Circle1.Position.X := tmpsp.X - Circle1.Width / 2;
  Circle1.Position.Y := tmpsp.Y - Circle1.Width / 2;

  for iI := 0 to Vertices do begin
    tmpsp := TPoint3D.Zero;
    tmpsp := ScreenHelper.CalculateScreenPosition(AVP.Context, FakeCube.Data.VertexBuffer.Vertices[iI], Scale, ACube.RotationAngle.Point, ACube.Position.Point);

    FLabl := Format('X:%0.2f Y:%0.2f',[tmpsp.X,tmpsp.Y]);

    tmpsp.X := tmpsp.X - PaintBox1.Position.X;
    tmpsp.Y := tmpsp.Y - PaintBox1.Position.Y;
    tmpr := RectF(tmpsp.X -FSize, tmpsp.Y -FSize, tmpsp.X +FSize, tmpsp.Y +FSize);
    ABMP.Canvas.FillEllipse(tmpr,100);

    tmpsp.Offset(FSize+3,-FSize,0);
    tmpr := TRectF.Create(tmpsp.X, tmpsp.Y -Min(DRAW_STRING_NEW_LINE, ABMP.Canvas.TextHeight(FLabl)), tmpsp.X +ABMP.Canvas.TextWidth(FLabl), tmpsp.Y);
    //ABMP.Canvas.FillText(tmpr, FLabl, false, 100, [], TTextAlign.Leading, TTextAlign.Leading);
  end;
end;

procedure TFrmMainView.BtnForm3DClick(Sender: TObject);
begin
  var Frm3d: TFrm3d;
  Frm3d := TFrm3d.Create(self);
  Frm3d.Show;
end;

procedure TFrmMainView.Switch1Click(Sender: TObject);
begin
  Layer3D2.Visible := not Layer3D2.IsVisible;
end;

procedure TFrmMainView.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var
  tmpBmp: TBitmap;
begin
  tmpBmp := TBitmap.Create(Trunc(Viewport3D1.Width), Trunc(Viewport3D1.Height));
  try
    tmpBmp.Resize(Trunc(PaintBox1.Width), Trunc(PaintBox1.Height));
    if tmpBmp.Canvas.BeginScene then begin
      tmpBmp.Canvas.Clear(TAlphaColorRec.Null);
      PaintElements(tmpBmp,Viewport3D1,Cube1);
      tmpBmp.Canvas.EndScene;
    end;
    PaintBox1.Canvas.DrawBitmap(tmpBmp, tmpBmp.BoundsF, tmpBmp.BoundsF.CenterAt(PaintBox1.BoundsRect), 1);
  finally
    tmpBmp.Free;
  end;
end;

procedure TFrmMainView.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  EdtCoord.Text := X.ToString + ', ' + Y.ToString;
end;

end.
