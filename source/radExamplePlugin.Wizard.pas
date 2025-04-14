//https://github.com/radprogrammer/rad-example-plugin
unit radExamplePlugin.Wizard;

interface

uses
  {Note - when you receive ToolsAPI not found error... you need access to "designide"
    DLL: Link with runtime packages: vcl;rtl;designide
    BPL: Add to Requires: vcl.dcp, rtl.dcp, desigide.dcp}
  ToolsAPI;

const
  C_PluginDisplayName = 'RAD Example Plugin';
  C_PluginUniqueID = 'RADProgrammer.ExamplePlugin';
  C_HelpMenuItemCaption = 'RAD Example Plugin Menu Item';

type

  // This example wizard will be triggered by a menu click in Help->Help Wizards
  TExampleWizard = class(TInterfacedObject, IOTAWizard, IOTAMenuWizard)
  public
    { IOTANotifier }
    procedure AfterSave;
    procedure BeforeSave;
    procedure Destroyed;
    procedure Modified;

    { IOTAWizard }
    function GetIDString:string;
    function GetName:string;
    function GetState:TWizardState;
    procedure Execute;

    { IOTAMenuWizard }
    function GetMenuText:string;
  end;


function InitializeExampleWizard:IOTAWizard;
procedure FinalizeExampleWizard;


implementation

uses
  Vcl.Dialogs;


function InitializeExampleWizard:IOTAWizard;
begin
  Result := TExampleWizard.Create;
end;


procedure FinalizeExampleWizard;
begin
  // Can do cleanup if needed
end;


procedure TExampleWizard.AfterSave;
begin
  // not called for IOTA Wizards
end;


procedure TExampleWizard.BeforeSave;
begin
  // not called for IOTA Wizards
end;


procedure TExampleWizard.Modified;
begin
  // not called for IOTA Wizards
end;


procedure TExampleWizard.Destroyed;
begin
  // Unused
end;


function TExampleWizard.GetState:TWizardState;
begin
  Result := [wsEnabled];
end;


function TExampleWizard.GetIDString:string;
begin
  Result := C_PluginUniqueID;
end;


function TExampleWizard.GetMenuText:string;
begin
  Result := C_HelpMenuItemCaption;
end;


function TExampleWizard.GetName:string;
begin
  Result := C_PluginDisplayName;
end;


procedure TExampleWizard.Execute;
begin
  ShowMessage('Hello Plugin World!');
end;


end.
