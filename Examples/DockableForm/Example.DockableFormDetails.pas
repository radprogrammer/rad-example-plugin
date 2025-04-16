unit Example.DockableFormDetails;

interface

uses
  Vcl.Forms,
  DockableFormDetails;


type

  // The IDE will create the form via CreateDockableForm and will leverage these Details to customize it
  TMyExampleFormDetails = class(TDockableFormDetails)
  public
    function GetIdentifier:string; override;
    function GetFrameClass:TCustomFrameClass; override;
    function GetCaption:string; override;
    procedure FrameCreated(AFrame:TCustomFrame); override;
  end;


implementation

uses
  Example.CustomFrame;


function TMyExampleFormDetails.GetIdentifier:string;
begin
  Result := 'MyExampleFormDetails';
end;


function TMyExampleFormDetails.GetFrameClass:TCustomFrameClass;
begin
  Result := TMyNormalFrame;
end;


function TMyExampleFormDetails.GetCaption:string;
begin
  Result := 'Example Dockable Form Caption';
end;


// Quirk: this ensures the theme is applied the first time the dockable form is displayed
// which is not always done.
procedure TMyExampleFormDetails.FrameCreated(AFrame:TCustomFrame);
begin
  inherited;
  DockableFormDetails.ApplyTheme(AFrame);
end;

end.
