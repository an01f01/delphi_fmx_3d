unit View.Game;

interface

uses
  Windows, System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms3D, FMX.Types3D, FMX.Forms, FMX.Graphics, 
  FMX.Dialogs, System.Math.Vectors, FMX.Objects3D, FMX.Controls3D, FMX.Layers3D;

type
  TFrm3d = class(TForm3D)
    Layer3D1: TLayer3D;
    Cube1: TCube;
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

procedure TFrm3d.Form3DCreate(Sender: TObject);
var
  Camera: TCamera;
begin
  { TODO }
  AllocConsole;
  writeln('Size: ' + self.Width.ToString + ', ' + self.height.ToString);

  writeln('Calculating pixels sizes for Layer3D');

  var tmpsp: TPoint3D := TPoint3D.Zero;
  tmpsp := self.Context.WorldToScreen(TProjection.Camera, Layer3D1.Position.Point);

  writeln('2D Position: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);

  writeln('Top Left Corner -------------------------------');

  tmpsp := self.Context.WorldToScreen(TProjection.Camera, Layer3D1.Position.Point - TPoint3D.Create(Layer3D1.Width / 2.0, Layer3D1.Height / 2.0, 0) );
  writeln('2D Position: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);

  writeln('Bottom Right Corner -------------------------------');

  tmpsp := self.Context.WorldToScreen(TProjection.Camera, Layer3D1.Position.Point + TPoint3D.Create(Layer3D1.Width / 2.0, Layer3D1.Height / 2.0, 0) );
  writeln('2D Position: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);

end;

end.
