unit Example.RegisterPlugin;

interface

// Note that the Register method is Case sensitive
procedure Register;


implementation

uses
  System.SysUtils,
  ToolsAPI,
  Example.MenuWizard,
  Example.DockableFormDetails;


procedure Register;
var
  NTAServices:INTAServices270; // Alexandria 11+ made this easier
begin
  if not Supports(BorlandIDEServices, INTAServices270, NTAServices) then
    Exit;

  RegisterPackageWizard(TSimpleWizard.Create);

  TSimpleWizard.MyDockableFormDetails := TMyExampleFormDetails.Create;
  NTAServices.RegisterDockableForm(TSimpleWizard.MyDockableFormDetails);
end;


procedure Unregister;
var
  NTAServices:INTAServices270;
begin
  if not Supports(BorlandIDEServices, INTAServices270, NTAServices) then
    Exit;

  NTAServices.UnregisterDockableForm(TSimpleWizard.MyDockableFormDetails);
end;


initialization

finalization

Unregister;

end.
