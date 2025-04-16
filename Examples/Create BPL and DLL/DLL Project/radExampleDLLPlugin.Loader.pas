{ DLL debugging notes

  Can debug a DLL by debugging the Delphi IDE using Run-Params->Host Application: $(BDS)\bin\bds.exe.   Params: -pDelphi
  Just add it to Experts registry key AFTER you started your initial RAD Studio

  - Ensure RAD Studio is closed
  - Remove your DLL if it is listed in the Experts registry key
  - Launch RAD Studio as your main debugging session
  - Open your DLL plugin project
  - Ensure your Run Params are configured
  - Add your DLL to the Experts registry key (so the next launched copy of RAD Studio sees it)
  - Run DLL project in your main debugging session
    (ignore the various startup errors which are expected when debugging an IDE instance with the IDE)

  Its somewhat easier to CREATE/DEBUG a BPL project, and much easier to LOAD/UNLOAD a BPL
  Its much better to DEPLOY a DLL project due to unit name conflicts in BPLs
}
unit radExampleDLLPlugin.Loader;

interface

implementation
uses
  ToolsAPI,
  radExamplePlugin.Wizard;


function ExampleDllInit(const BorlandIDEServices:IInterface;
                        RegisterProc:TWizardRegisterProc;
                        var Terminate:TWizardTerminateProc):Boolean; stdcall;
begin
  Result := Assigned(BorlandIDEServices);
  if Result then
  begin
    RegisterProc(InitializeExampleWizard);
    Terminate := FinalizeExampleWizard;
  end;
end;


exports ExampleDllInit name ToolsAPI.WizardEntryPoint;


end.
