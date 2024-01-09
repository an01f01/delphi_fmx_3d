program Fmx3D;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Main in '..\Src\Views\View.Main.pas' {FrmMainView},
  View.Game in '..\Src\Views\View.Game.pas' {Frm3d};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrm3d, Frm3d);
  Application.Run;
end.
