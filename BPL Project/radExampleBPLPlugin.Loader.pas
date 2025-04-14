unit radExampleBPLPlugin.Loader;

interface

// Note that the Register method is Case sensitive
procedure Register;

implementation

uses
  radExamplePlugin.Wizard;


procedure Register;
begin
  InitializeExampleWizard;
end;


initialization

finalization

FinalizeExampleWizard;

end.
