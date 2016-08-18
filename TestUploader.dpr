program TestUploader;

uses
  Forms,
  TestUploaderUnit in 'TestUploaderUnit.pas' {FTestUploader};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFTestUploader, FTestUploader);
  Application.Run;
end.
