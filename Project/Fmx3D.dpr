program Fmx3D;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\Src\Views\View.Main.pas' {FrmMainView},
  View.Game in '..\Src\Views\View.Game.pas' {Frm3d},
  Helper3D in '..\Src\Utils\Helper3D.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMainView, FrmMainView);
  Application.Run;
end.
