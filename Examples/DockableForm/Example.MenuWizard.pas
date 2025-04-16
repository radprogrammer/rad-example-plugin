unit Example.MenuWizard;

interface

uses
  ToolsAPI,
  Vcl.Forms,
  Example.DockableFormDetails;

type

  // This wizard will react to a menu click in the "Help->Help Wizards" menu
  TSimpleWizard = class(TNotifierObject, IOTANotifier, IOTAWizard, IOTAMenuWizard)
  private
    // The form instance is created when the user clicks: "Click Me for a demonstration"
    // The instance is Show'n whenever the menu is clicked again
    FDockableFormInstance:TCustomForm;
    procedure ShowForm;
  public
    // Instance created during Register, free'd during Unregister
    class var MyDockableFormDetails:TMyExampleFormDetails;

    { IOTAWizard }
    function GetIDString:string;
    function GetName:string;
    function GetState:TWizardState;
    procedure Execute;

    { IOTAMenuWizard }
    function GetMenuText:string;
  end;


implementation

uses
  System.SysUtils;


function TSimpleWizard.GetIDString:string;
begin
  Result := 'RAdProgrammer.SimpleWizardExample';
end;


function TSimpleWizard.GetName:string;
begin
  Result := 'RAD Programmer Simple Wizard';
end;


function TSimpleWizard.GetMenuText:string;
begin
  Result := 'Click Me for a demonstration';
end;


function TSimpleWizard.GetState:TWizardState;
begin
  Result := [wsEnabled];
end;


procedure TSimpleWizard.Execute;
begin
  ShowForm;
end;


procedure TSimpleWizard.ShowForm;
var
  NTAServices:INTAServices270;
begin
  if not Assigned(MyDockableFormDetails) then
    Exit;

  if not Assigned(FDockableFormInstance) then
  begin
    if not Supports(BorlandIDEServices, INTAServices270, NTAServices) then
      Exit;
    FDockableFormInstance := NTAServices.CreateDockableForm(MyDockableFormDetails);
  end;

  FDockableFormInstance.Show;
  FDockableFormInstance.BringToFront;
end;

end.
