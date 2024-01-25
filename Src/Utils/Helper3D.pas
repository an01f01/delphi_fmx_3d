unit Helper3D;

interface

uses System.Math, FMX.Platform, System.Types,
  System.Math.Vectors, FMX.Types3D, FMX.Layers3D, Generics.Collections;

type

  TLayer2DCoords = Record
    TopRight    : TPoint3D;
    TopLeft     : TPoint3D;
    BottomRight : TPoint3D;
    BottomLeft  : TPoint3D;
    Size        : TPoint3D;
  end;

  ScreenHelper = Class(TObject)
  public
    class function GetScreenScale: Single;
    class function GetScreenSize: TPointF;
    class function CalculateScreenPosition(Context: TContext3D; Point: TPoint3D; Scale: TPoint3D; Rotation: TPoint3D; Translation: TPoint3D; ApplyScreenScale: Boolean = False): TPoint3D; static;
    class function CalculateLayerSize(Context: TContext3D; Layer: TLayer3D): TLayer2DCoords;
  end;

implementation

class function ScreenHelper.GetScreenScale: Single;
var
   ScreenService: IFMXScreenService;
begin
   Result := 1;
   if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(ScreenService)) then
   begin
      Result := ScreenService.GetScreenScale;
   end;
end;

class function ScreenHelper.GetScreenSize: TPointF;
var
   ScreenService: IFMXScreenService;
begin
   Result := TPointF.Zero;
   if TPlatformServices.Current.SupportsPlatformService (IFMXScreenService, IInterface(ScreenService)) then
   begin
      Result := ScreenService.GetScreenSize;
   end;
end;

class function ScreenHelper.CalculateScreenPosition(Context: TContext3D; Point: TPoint3D; Scale: TPoint3D; Rotation: TPoint3D; Translation: TPoint3D; ApplyScreenScale: Boolean = False): TPoint3D;
var
  Tmpsp: TPoint3D;
begin
  Tmpsp := TPoint3D.Zero;
  Tmpsp := Point;
  Tmpsp := Tmpsp * TMatrix3D.CreateScaling(Scale);
  Tmpsp := Tmpsp * TMatrix3D.CreateRotationX(DegToRad(Rotation.X));
  Tmpsp := Tmpsp * TMatrix3D.CreateRotationY(DegToRad(Rotation.Y));
  Tmpsp := Tmpsp * TMatrix3D.CreateRotationZ(DegToRad(Rotation.Z));
  Tmpsp := Tmpsp * TMatrix3D.CreateTranslation(Translation);
  Tmpsp := Context.WorldToScreen(TProjection.Camera,Tmpsp);
  if ApplyScreenScale then begin
    Tmpsp := Tmpsp / GetScreenScale;
  end;
  Result := Tmpsp;
end;

{ Returns Width and Height of TLayer3D as a TPoint3D, where X is for Width and Y is for Height }
class function ScreenHelper.CalculateLayerSize(Context: TContext3D; Layer: TLayer3D): TLayer2DCoords;
var
  LayerCoords: TLayer2DCoords;
begin
  { Calc Left, then Right }
  LayerCoords.TopRight := CalculateScreenPosition(Context, TPoint3D.Create(Layer.Width/2, Layer.Height/2, 0), Layer.Scale.Point, Layer.RotationAngle.Point, Layer.Position.Point);
  LayerCoords.TopLeft := CalculateScreenPosition(Context, TPoint3D.Create(-Layer.Width/2, Layer.Height/2, 0), Layer.Scale.Point, Layer.RotationAngle.Point, Layer.Position.Point);
  { Calc Top, then Bottom}
  LayerCoords.BottomRight := CalculateScreenPosition(Context, TPoint3D.Create(Layer.Width/2, -Layer.Height/2, 0), Layer.Scale.Point, Layer.RotationAngle.Point, Layer.Position.Point);
  LayerCoords.BottomLeft := CalculateScreenPosition(Context, TPoint3D.Create(-Layer.Width/2, -Layer.Height/2, 0), Layer.Scale.Point, Layer.RotationAngle.Point, Layer.Position.Point);

  LayerCoords.Size := TPoint3D.Zero;
  LayerCoords.Size.X := (LayerCoords.TopRight.X - LayerCoords.BottomLeft.X);
  LayerCoords.Size.Y := (LayerCoords.TopRight.Y - LayerCoords.BottomLeft.Y);
  Result := LayerCoords;
end;


end.
