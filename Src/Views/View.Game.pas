unit View.Game;

interface

uses

{$IFDEF WINDOWS}
  Windows,
{$ENDIF}
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D, FMX.Layers3D,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls, System.Math;

type
  TFrm3d = class(TForm3D)
    Layer3D1: TLayer3D;
    Cube1: TCube;
    Plane1: TPlane;
    procedure Form3DCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm3d: TFrm3d;

implementation

{$R *.fmx}

uses Helper3D;

type
  TFakeCube = class(TCube);
  TFakePlane = class(TPlane);

procedure TFrm3d.Form3DCreate(Sender: TObject);
var
  Camera: TCamera;
  iI, FSize: Integer;
  FLabl: String;
  tmpsp: TPoint3D;
  tmpr: TRectF;
begin


{$IFDEF WINDOWS}
  AllocConsole;
{$ENDIF}

  writeln('Size: ' + self.Width.ToString + ', ' + self.height.ToString);
  writeln('Calculating pixels sizes for Layer3D');

  var LayerCoords: TLayer2DCoords;
  LayerCoords := ScreenHelper.CalculateLayerSize(self.Context, Layer3D1);
  writeln('Layer Pixel Size: ' + LayerCoords.Size.X.ToString + ' ' + LayerCoords.Size.Y.ToString);

  tmpsp := TPoint3D.Zero;

  for iI := 0 to TFakeCube(Cube1).Data.VertexBuffer.Length -1 do begin
    tmpsp := TPoint3D.Zero;
    tmpsp := ScreenHelper.CalculateScreenPosition(self.Context,
      TFakeCube(Cube1).Data.VertexBuffer.Vertices[iI]+Cube1.Position.Point, Cube1.Scale.Point, Cube1.RotationAngle.Point, Cube1.Position.Point);
    writeln(' Vertice[' + iI.ToString + ']: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);
  end;

  tmpsp := self.Context.WorldToScreen(TProjection.Camera, Plane1.Position.Point);
  writeln('Plane Center Position: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);

  for iI := 0 to TFakePlane(Plane1).Data.VertexBuffer.Length -1 do begin
    tmpsp := TPoint3D.Zero;
    tmpsp := ScreenHelper.CalculateScreenPosition(self.Context,
      TFakePlane(Plane1).Data.VertexBuffer.Vertices[iI], Plane1.Scale.Point, Plane1.RotationAngle.Point, Plane1.Position.Point);
    writeln(' Vertice[' + iI.ToString + ']: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);
  end;

  writeln('Top Left Corner -------------------------------');

  var pt: TPoint3D := TPoint3D.Zero;
  pt := ScreenHelper.CalculateScreenPosition(self.Context,
    TPoint3D.Zero, Layer3D1.Scale.Point, Layer3D1.RotationAngle.Point, Layer3D1.Position.Point);
  writeln(' Layer3D1: ' + pt.X.ToString + ', ' + pt.Y.ToString);

end;

end.
