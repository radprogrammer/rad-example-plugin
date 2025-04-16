unit Example.CustomFrame;

interface

uses
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  Vcl.Controls,
  System.Classes;

type

  // Note that there is nothing at all special about this frame.
  // You could include it in a stand-alone VCL project to easily run/debug this frame's operation
  // It is obviously missing any ToolsAPI calls - but you can/should mock those as needed.
  TMyNormalFrame = class(TFrame)
    Image1:TImage;
    Label1:TLabel;
    linkHome:TLinkLabel;
    procedure linkHomeLinkClick(Sender:TObject; const Link:string; LinkType:TSysLinkType);
  end;


implementation

uses
  Winapi.Windows,
  Winapi.ShellAPI;

{$R *.dfm}


procedure TMyNormalFrame.linkHomeLinkClick(Sender:TObject; const Link:string; LinkType:TSysLinkType);
begin
  ShellExecute(0, 'open', PChar(Link), nil, nil, SW_SHOWNORMAL);
end;

end.
