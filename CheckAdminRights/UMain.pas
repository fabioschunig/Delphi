// Exemplo de verificação se o programa possui direitos de administrador
// Data: 18/10/2022
// Baseado em:
// https://stackoverflow.com/questions/3300390/want-to-learn-if-my-application-has-admin-rights

unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfMain = class(TForm)
    lbMensagem: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    function IsAdmin(Host : string = '') : Boolean;
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
  Winapi.WinSvc;

procedure TfMain.FormCreate(Sender: TObject);
begin
  if IsAdmin then
    lbMensagem.Caption := 'Possui direitos de administrador'
  else
    lbMensagem.Caption := '*Não* possui direitos de administrador';
end;

function TfMain.IsAdmin(Host: string): Boolean;
var
  H: SC_HANDLE;
begin
  Result := True;

  if Win32Platform <> VER_PLATFORM_WIN32_NT then
    Exit;

  H := OpenSCManager(PChar(Host), nil, SC_MANAGER_ALL_ACCESS);
  Result := H <> 0;
  if Result then
    CloseServiceHandle(H);
end;

end.
