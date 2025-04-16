unit DockableFormDetails;

interface

uses
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ComCtrls,
  Vcl.ImgList,
  Vcl.Menus,
  System.IniFiles,
  DesignIntf,
  ToolsAPI;


type
  // implement ToolsAPI interface: INTACustomDockableForm = interface(IUnknown)
  // All methods marked virtual with Noop or standard implementation
  // Except two abstract methods that need to be overriden: GetIdentifier + GetFrameClass

  // This gives the IDE information about your dockable form.
  TDockableFormDetails = class(TInterfacedObject, INTACustomDockableForm)
  public
    /// <summary>
    /// Returns the Caption for the Dockable Form
    /// </summary>
    function GetCaption:string; virtual;
    /// <summary>
    /// Returns a unique identifier for this form.  This should not be translated.
    /// This identifier is used as the section name when saving information for
    /// this form in the desktop state file
    /// </summary>
    function GetIdentifier:string; virtual; abstract;
    /// <summary>
    /// Returns the class of the frame that you want embedded in the dockable form
    /// </summary>
    function GetFrameClass:TCustomFrameClass; virtual; abstract;
    /// <summary>
    /// Called when an instance of the specified frame class is created
    /// </summary>
    procedure FrameCreated(AFrame:TCustomFrame); virtual;
    /// <summary>
    /// Returns an action list that is used to populate the form's context menu.
    /// By default the context menu will have 2 items that are common to all
    /// dockable forms in the IDE: &quot;Stay on top&quot; and &quot;Dockable&quot;.  If the form
    /// has a toolbar, there will also be a &quot;Toolbar&quot; menu item.  If this
    /// function returns a non-nil action list, the items in the action list will
    /// be added to the menu (above the default items).  To specify sub-menus, use
    /// categories for the actions contained in the Action List.  Any action that
    /// has a Category set, will appear on a sub-menu in the context menu.  The
    /// Caption of the Parent menu will be the Category name.
    /// </summary>
    function GetMenuActionList:TCustomActionList; virtual;
    /// <summary>
    /// Returns an image list that contains the images associated with the action
    /// list returned by GetMenuActionList
    /// </summary>
    function GetMenuImageList:TCustomImageList; virtual;
    /// <summary>
    /// Called when the popup menu is about to be shown.  This allows further
    /// customization beyond just adding items from an Action List
    /// </summary>
    procedure CustomizePopupMenu(PopupMenu:TPopupMenu); virtual;
    /// <summary>
    /// Returns an action list that is used to populate a toolbar on the form.  If
    /// nil is returned, then the dockable form will not have a toolbar.  Items in
    /// the Action List that have '-' as the caption will be added to the toolbar
    /// as a separator
    /// </summary>
    function GetToolBarActionList:TCustomActionList; virtual;
    /// <summary>
    /// Returns an image list that contains the images associated with the action
    /// list returned by GetToolbarActionList
    /// </summary>
    function GetToolBarImageList:TCustomImageList; virtual;
    /// <summary>
    /// Called after the toolbar has been populated with the Action List returned
    /// from GetToolbarActionList.  This allows further customization beyond just
    /// adding items from an Action List
    /// </summary>
    procedure CustomizeToolBar(ToolBar:TToolBar); virtual;
    /// <summary>
    /// Called when state for this form is saved to a desktop file.  The Section
    /// paramter is passed in for convenience, but it should match the string
    /// returned by GetIdentifier.  This is only called for INTACustomDockableForm
    /// instances that have been registered using INTAServices.RegisterDockableForm.
    /// IsProject indicates whether the desktop being saved is a project desktop
    /// (as opposed to a dekstop state)
    /// </summary>
    procedure SaveWindowState(Desktop:TCustomIniFile; const Section:string; IsProject:Boolean); virtual;
    /// <summary>
    /// Called when state for this form is loaded from a desktop file.  The
    /// Section paramter is passed in for convenience, but it should match the
    /// string returned by GetIdentifier.  This is only called for
    /// INTACustomDockableForm instances that have been registered using
    /// INTAServices.RegisterDockableForm
    /// </summary>
    procedure LoadWindowState(Desktop:TCustomIniFile; const Section:string); virtual;
    /// <summary>
    /// Allows the form to control the enabled state of the clipboard commands on
    /// the IDE's &quot;Edit&quot; menu when this view is active
    /// </summary>
    function GetEditState:TEditState; virtual;
    /// <summary>
    /// Called when the user uses one of the clipboard commands on the IDE's &quot;Edit&quot;
    /// menu
    /// </summary>
    function EditAction(Action:TEditAction):Boolean; virtual;

    property Caption:string read GetCaption;
    property Identifier:string read GetIdentifier;
    property FrameClass:TCustomFrameClass read GetFrameClass;
    property MenuActionList:TCustomActionList read GetMenuActionList;
    property MenuImageList:TCustomImageList read GetMenuImageList;
    property ToolbarActionList:TCustomActionList read GetToolBarActionList;
    property ToolbarImageList:TCustomImageList read GetToolBarImageList;
  end;


procedure ApplyTheme(const Frame:TCustomFrame);

implementation

uses
  System.SysUtils;


procedure ApplyTheme(const Frame:TCustomFrame);
var
  IDEThemingServices:IOTAIDEThemingServices250;
begin
  if not Supports(BorlandIDEServices, IOTAIDEThemingServices250, IDEThemingServices) then
    Exit;

  IDEThemingServices.ApplyTheme(Frame);
end;


procedure Noop; inline;
begin
  // intentionally empty
end;


procedure TDockableFormDetails.CustomizePopupMenu(PopupMenu:TPopupMenu);
begin
  Noop;
end;


procedure TDockableFormDetails.CustomizeToolBar(ToolBar:TToolBar);
begin
  Noop;
end;


function TDockableFormDetails.EditAction(Action:TEditAction):Boolean;
begin
  Result := True;
end;


procedure TDockableFormDetails.FrameCreated(AFrame:TCustomFrame);
begin
  Noop;
end;


function TDockableFormDetails.GetCaption:string;
begin
  Result := 'Plugin';
end;


function TDockableFormDetails.GetEditState:TEditState;
begin
  Result := [];
end;


function TDockableFormDetails.GetMenuActionList:TCustomActionList;
begin
  Result := nil;
end;


function TDockableFormDetails.GetMenuImageList:TCustomImageList;
begin
  Result := nil;
end;


function TDockableFormDetails.GetToolBarActionList:TCustomActionList;
begin
  Result := nil;
end;


function TDockableFormDetails.GetToolBarImageList:TCustomImageList;
begin
  Result := nil;
end;


procedure TDockableFormDetails.LoadWindowState(Desktop:TCustomIniFile; const Section:string);
begin
  Noop;
end;


procedure TDockableFormDetails.SaveWindowState(Desktop:TCustomIniFile; const Section:string; IsProject:Boolean);
begin
  Noop;
end;


end.
