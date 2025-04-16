### Dockable Form Example

This example leverages `INTAServices270` which was introduced in **<span style="color:ide_violet">Delphi 11 Alexandria</span>**
to more easily create **<span style="color:ide_orange">Dockable Forms</span>**.

Using dockable forms in your plugins has always been possible, but they haven't been documented very much.  Well, to be fair,
neither has [INTAServices270](https://docwiki.embarcadero.com/Libraries/en/ToolsAPI.INTAServices270).

If you want your RAD Studio plugin to have a dockable form, create a `Frame` unit for your custom GUI elements.
Then, describe your dockable form details by creating a class which implements `INTACustomDockableForm`.  The IDE will be the one
which will call the form constructor (whenever you tell it to) and implement all the dockable form magic.

In this example, a utility unit has been provided named `DockableFormDetails.pas` that defines a class named `TDockableFormDetails` which stubs
out everything defined in `INTACustomDockableForm`.  This base class makes things a little easier for you as now all you need to do is
inherit from `TDockableFormDetails` and implement two abstract methods:
  - `function GetIdentifier:string; virtual; abstract;`
  - `function GetFrameClass:TCustomFrameClass; virtual; abstract;`

You will likely also want to override the `GetCaption` virtual method to set a custom caption.  The rest of the required methods
are stubbed out with default values and can be overridden as desired.

During your plugin's `Register` method, you should create an instance of your dockable form details and then call
[RegisterDockableForm](https://docwiki.embarcadero.com/Libraries/en/ToolsAPI.INTAServices270.RegisterDockableForm)
and pass in your details instance to provide RAD Studio with the needed information about your dockable form to be used
later when the form is created and displayed.

It's always good to call [UnregisterDockableForm](https://docwiki.embarcadero.com/Libraries/Athens/en/ToolsAPI.INTAServices270.UnregisterDockableForm)
when your plugin is being unloaded.

The Register/UnregisterDockableForm is demonstrated within the `Example.RegisterPlugin.pas` unit.

At some point, you will obviously want to create and display your form in the IDE.  You need to decide on the event which triggers this action.
In this example, we are implementing a **<span style="color:ide_orange">Menu Wizard</span>** (via `IOTAMenuWizard`) which will create a new
menu item in the `Help->Help Wizards` menu in RAD Studio.  (A future example will show how to add an item anywhere in the TMainMenu of RAD Studio.
The `IOTAMenuWizard` only creates menu items in the Help Wizards menu.)

Creating a menu wizard is demonstrated within the `Example.MenuWizard.pas` unit by implementing a `IOTAMenuWizard` which automatically calls its
[Execute](https://docwiki.embarcadero.com/Libraries/en/ToolsAPI.IOTAWizard.Execute) method whenever its menu item is clicked.

In this example, we call `ShowForm` via our `Execute` method, as seen below:

```Pascal


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


````

We have a `FDockableFormInstance:TCustomForm` field in our `TSimpleWizard` class and if it hasn't been created yet,
we call [CreateDockableForm](https://docwiki.embarcadero.com/Libraries/en/ToolsAPI.INTAServices270.CreateDockableForm)
to have the IDE create a dockable form for our use.  We then call `Show` and `BringToFront` in case the form was lost behind other
IDE windows.


The `Example.CustomFrame.pas` unit is an example custom frame to be used with our plugin.  There is nothing special about this frame - you can do most anything
that you can normally do in your Frame code.

I hope this helps clear up how to create and use **<span style="color:ide_orange">Dockable Forms</span>** within the RAD Studio IDE!  I am also doing this
to refresh my own memory as I do not do this task very often and the methods can be a bit confusing.  Thankfully, they are much better
since `INTAServices270` was introduced.


### Test It Out:
- Open the the `radExampleDockableForm.dproj` project in **<span style="color:ide_violet">RAD Studio 11</span>** or later.
- Right click on project in the Project Manager and select `Install` which will build and then install the BPL
- Click on `Help` menu, and then the `Help Wizards` child menu item.  All the custom menu items for installed `IOTAMenuWizard`'s will be displayed
- Click the menu item named `Click Me for a demonstration` created by this wizard and an example dockable form will be displayed
- The contents of the dockable form will be the frame defined in `Example.CustomFrame`
- Make some changes to the frame and rebuild.  The BPL will be unloaded (the dockable form closed) and then the BPL will be rebuilt.
- Click the Help Wizards menu again and immediately see your changes!  (This is one reason why BPLs are much better for development than DLLs.)
- Change the IDE theme and the dockable form *usually* gets themed correctly, but there are some quirks (to be attacked in a future example.)


