unit SceneTestFrm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects, FMX.Scene, FMX.Controls.Presentation,
  FMX.StdCtrls, FMX.Ani, FMX.Platform, FMX.Edit;

type
  TForm27 = class(TForm)
    Scene1: TScene;
    Ellipse1: TEllipse;
    PaintBox1: TPaintBox;
    Selection1: TSelection;
    Panel1: TPanel;
    FloatAnimation1: TFloatAnimation;
    PaintBox2: TPaintBox;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
    procedure FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    S: TScene;
    FRenderTime: Single;
    FFrameCount: Integer;
    FUpdateRects: array of TRectF;
    FTimerService: IFMXTimerService;
    FFps: Single;
  protected
    procedure PaintRects(const UpdateRects: array of TRectF); override;
  end;

var
  Form27: TForm27;

implementation

{$R *.fmx}

procedure TForm27.FormCreate(Sender: TObject);
begin
  TPlatformServices.Current.SupportsPlatformService(IFMXTimerService, FTimerService);
end;

procedure TForm27.FormPaint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
var
  R: TRectF;
begin
  if False then
    for R in FUpdateRects do
    begin
      Canvas.Stroke.Kind := TBrushKind.Solid;
      Canvas.Stroke.Color := $FF00FF00;
      Canvas.DrawRect(R, 0, 0, [], 1);
    end;
end;

procedure TForm27.PaintBox1Paint(Sender: TObject; Canvas: TCanvas);
var
  I, J: Integer;
begin
  for I := 0 to Trunc(PaintBox1.Width) - 1 do
    for J := 0 to Trunc(PaintBox1.Height) - 1 do
    begin
      Canvas.Fill.Kind := TBrushKind.Solid;
      Canvas.Fill.Color := $FF000000 or random($FF);
      Canvas.FillRect(TRectF.Create(I, J, I + 1, J + 1), 0, 0, [], 1);
    end;
end;

procedure TForm27.PaintRects(const UpdateRects: array of TRectF);
var
  C: Double;
begin
  if Length(UpdateRects) > 0 then
  begin
    SetLength(FUpdateRects, Length(UpdateRects));
    Move(UpdateRects[0], FUpdateRects[0], SizeOf(TRectF) * Length(UpdateRects));
    C := FTimerService.GetTick;
    inherited;
    FRenderTime := FRenderTime + (FTimerService.GetTick - C);
    FFrameCount := FFrameCount + 1;
  end;
end;

procedure TForm27.Timer1Timer(Sender: TObject);
begin
  if FFrameCount > 0 then
  begin
    FFps := 1 / (FRenderTime / FFrameCount);
    Caption := Round(FFps).ToString + ' FPS';
    FFrameCount := 0;
    FRenderTime := 0;
  end;
end;

end.
