unit View.Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Math,
  System.Math.Vectors, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls3D, FMX.Layers3D, FMX.Objects3D,
  FMX.Viewport3D, FMX.Memo.Types, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Memo, FMX.StdCtrls, FMX.Edit, FMX.Types3D;

type
  TFrmMainView = class(TForm)
    Viewport3D1: TViewport3D;
    Sphere1: TSphere;
    MmLog: TMemo;
    BtnSphereScreenCoord: TButton;
    LblMouseCoord: TLabel;
    EdtCoord: TEdit;
    procedure BtnSphereScreenCoordClick(Sender: TObject);
    procedure Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    { Private declarations }
    procedure LogViewportSize();
  public
    { Public declarations }
  end;

var
  FrmMainView: TFrmMainView;

implementation

{$R *.fmx}

procedure TFrmMainView.BtnSphereScreenCoordClick(Sender: TObject);
begin
  { TODO }
  //Viewport3D1.AbsoluteToLocal(Sphere1.)
  MmLog.Lines.Add(Sphere1.LocalToAbsolute3D(Sphere1.Position.Point).X.ToString);

  var tmpsp: TPoint3D := TPoint3D.Zero;
  tmpsp := Viewport3D1.Context.WorldToScreen(TProjection.Camera, Sphere1.Position.Point);

  MmLog.Lines.Add('2D Position: ' + tmpsp.X.ToString + ', ' + tmpsp.Y.ToString);

end;

procedure TFrmMainView.FormCreate(Sender: TObject);
begin
  { LOG Size }
  LogViewportSize();
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

procedure TFrmMainView.Viewport3D1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Single);
begin
  EdtCoord.Text := X.ToString + ', ' + Y.ToString;
end;

end.
