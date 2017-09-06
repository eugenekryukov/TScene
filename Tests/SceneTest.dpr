program SceneTest;

uses
  System.StartUpCopy,
  FMX.Forms,
  SceneTestFrm in 'SceneTestFrm.pas' {Form27},
  FMX.Scene in '..\FMX.Scene.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm27, Form27);
  Application.Run;
end.
