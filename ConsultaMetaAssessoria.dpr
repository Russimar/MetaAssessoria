library ConsultaMetaAssessoria;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  uConsultaMetaAssessoria in 'uConsultaMetaAssessoria.pas' {$R *.res},
  uProduto in '..\..\Retaguarda\Oficial\Utilitarios\uProduto.pas';

{$R *.res}

function ConsultarEAN(const BaseURL: WideString; const Token: WideString;
  const Ambiente: WideString; const CNPJ: WideString; const Usuario: WideString;
  const EAN: WideString): TProduto;
begin
  Result := TConsulta.New.BaseURL(BaseURL).Token(Token).Ambiente(Ambiente)
    .CNPJ(CNPJ).Usuario(Usuario).EAN(EAN).Consultar;
end;

function ConsultaStatus(const BaseURL: WideString): Boolean;
begin
  Result := TConsulta.New.BaseURL(BaseURL).ConsultarStatus;
end;

exports
  ConsultarEAN,
  ConsultaStatus;

begin

end.
