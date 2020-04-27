unit uConsultaMetaAssessoria;

interface

uses
  REST.Types,
  Data.Bind.Components,
  Data.Bind.ObjectScope,
  REST.Client,
  System.SysUtils,
  REST.Json,
  System.Json.Readers,
  uProduto,
  System.Json.Types,
  System.Classes;

type
  IConsulta = Interface(IInterface)
    ['{0E911E20-D972-4862-B15E-CB362C023A89}']
    function BaseURL(const Value: string): IConsulta; overload;
    function BaseURL: string; overload;
    function Token(const Value: string): IConsulta; overload;
    function Token: string; overload;
    function Ambiente(const Value: string): IConsulta; overload;
    function Ambiente: string; overload;
    function CNPJ(const Value: string): IConsulta; overload;
    function CNPJ: string; overload;
    function Usuario(const Value: string): IConsulta; overload;
    function Usuario: string; overload;
    function EAN(const Value: string): IConsulta; overload;
    function EAN: string; overload;
    function Consultar: TProduto;
    function ConsultarStatus: Boolean;
    procedure ProcessProdutoRead(Produtos: TProduto; jtr: TJsonReader);
  End;

  TConsulta = class(TInterfacedObject, IConsulta)
  strict private
    FBaseURL: string;
    FToken: string;
    FAmbiente: string;
    FCNPJ: string;
    FUsuario: string;
    FEAN: string;
  private
    procedure CreateParam(const RESTRequest: TRESTRequest;
      const ParamName, ParamValue: string);
  public
    class function New: IConsulta;
    function BaseURL(const Value: string): IConsulta; overload;
    function BaseURL: string; overload;
    function Token(const Value: string): IConsulta; overload;
    function Token: string; overload;
    function Ambiente(const Value: string): IConsulta; overload;
    function Ambiente: string; overload;
    function CNPJ(const Value: string): IConsulta; overload;
    function CNPJ: string; overload;
    function Usuario(const Value: string): IConsulta; overload;
    function Usuario: string; overload;
    function EAN(const Value: string): IConsulta; overload;
    function EAN: string; overload;
    function Consultar: TProduto;
    function ConsultarStatus: Boolean;
    procedure ProcessProdutoRead(Produtos: TProduto; jtr: TJsonReader);
  End;

implementation

{ TConsulta }
var
  eProduto: TProduto;

function TConsulta.Ambiente(const Value: string): IConsulta;
begin
  Result := Self;
  FAmbiente := Value;
end;

function TConsulta.Ambiente: string;
begin
  Result := FAmbiente;
end;

function TConsulta.BaseURL(const Value: string): IConsulta;
begin
  Result := Self;
  FBaseURL := Value;
end;

function TConsulta.BaseURL: string;
begin
  Result := FBaseURL;
end;

function TConsulta.CNPJ: string;
begin
  Result := FCNPJ;
end;

procedure TConsulta.CreateParam(const RESTRequest: TRESTRequest;
  const ParamName, ParamValue: string);
begin
  with RESTRequest.Params.AddItem do
  begin
    Name := ParamName;
    Value := ParamValue;
    Kind := TRESTRequestParameterKind.pkGETorPOST;
  end;
end;

function TConsulta.EAN: string;
begin
  Result := FEAN;
end;

class function TConsulta.New: IConsulta;
begin
  eProduto := TProduto.Create;
  Result := Self.Create;
end;

procedure TConsulta.ProcessProdutoRead(Produtos: TProduto; jtr: TJsonReader);
begin
  try
    while jtr.Read do
    begin
      if jtr.TokenType = TjsonToken.PropertyName then
      begin
        if jtr.Value.ToString = 'Codigo' then
        begin
          jtr.Read;
          eProduto.Codigo := jtr.Value.AsInteger;
        end;

        if jtr.Value.ToString = 'EAN' then
        begin
          jtr.Read;
          eProduto.EAN := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'produtoDescricao' then
        begin
          jtr.Read;
          eProduto.Descricao := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'embalagemUnitariaUnidadeSigla' then
        begin
          jtr.Read;
          eProduto.UnidadeMedidaSigla := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tributarioNcm' then
        begin
          jtr.Read;
          eProduto.NCM := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tributarioCest' then
        begin
          jtr.Read;
          eProduto.CEST := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'produtoDiasValidade' then
        begin
          jtr.Read;
          eProduto.DiasValidade := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'embalagemUnitariaPesoBruto' then
        begin
          jtr.Read;
          eProduto.PesoBruto := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'embalagemUnitariaPesoLiquido' then
        begin
          jtr.Read;
          eProduto.PesoLiquido := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'TribRegraCodPerfilOrigem' then
        begin
          jtr.Read;
          eProduto.Origem := jtr.Value.AsInteger;
        end;

        if jtr.Value.ToString = 'tribRegraCfop' then
        begin
          jtr.Read;
          eProduto.Cfop := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tribIcmsCst' then
        begin
          jtr.Read;
          eProduto.CSTICMS := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tribIcmsAliq' then
        begin
          jtr.Read;
          eProduto.AliqICMS := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tribIcmsReducao' then
        begin
          jtr.Read;
          eProduto.RedBaseICMS := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'tribRegraPisCst' then
        begin
          jtr.Read;
          if copy(eProduto.Cfop, 1, 1) = '5' then
            eProduto.CSTPIS := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'fisRegraCofinsCst' then
        begin
          jtr.Read;
          if copy(eProduto.Cfop, 1, 1) = '5' then
            eProduto.CSTCofins := jtr.Value.AsString;
        end;

        if jtr.Value.ToString = 'resultadoConsulta' then
        begin
          jtr.Read;
          eProduto.ResultadoConsulta := jtr.Value.AsString;
        end;

        // if jtr.TokenType = TJsonToken.EndObject then
        // begin
        // Result := eProduto;
        // end;
      end;
    end;
  finally
  end;
end;

function TConsulta.EAN(const Value: string): IConsulta;
begin
  Result := Self;
  FEAN := Value;
end;

function TConsulta.Consultar: TProduto;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  // eProdutos : TProduto;
  sr: TStringReader;
  jtr: TJsonTextReader;
begin
  // eProduto := TProduto.Create;
  RESTClient := TRESTClient.Create(nil);
  try
    RESTRequest := TRESTRequest.Create(nil);
    try
      RESTResponse := TRESTResponse.Create(nil);
      try
        RESTRequest.Client := RESTClient;
        RESTRequest.Response := RESTResponse;
        RESTClient.BaseURL := FBaseURL;
        RESTClient.ContentType := 'application/x-www-form-urlencoded';
        RESTRequest.Method := TRESTRequestMethod.rmPOST;
        RESTRequest.Params.AddHeader('token', FToken);
        RESTRequest.Params.AddHeader('ambiente', FAmbiente);
        CreateParam(RESTRequest, 'cnpj', FCNPJ);
        CreateParam(RESTRequest, 'ean', FEAN);
        CreateParam(RESTRequest, 'usuario', FUsuario);
        RESTRequest.Execute;
        sr := TStringReader.Create(RESTResponse.JSONValue.ToString);
        try
          jtr := TJsonTextReader.Create(sr);
          try
            while jtr.Read do
            begin
              if jtr.TokenType = TjsonToken.StartObject then
                ProcessProdutoRead(eProduto, jtr);
            end;
          finally
            FreeAndNil(jtr);
          end;
        finally
          FreeAndNil(sr);
        end;
      finally
        FreeAndNil(RESTResponse);
      end;
    finally
      FreeAndNil(RESTRequest);
    end;
  finally
    FreeAndNil(RESTClient);
  end;
  Result := eProduto;
end;

function TConsulta.ConsultarStatus: Boolean;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
begin
  RESTClient := TRESTClient.Create(nil);
  try
    RESTRequest := TRESTRequest.Create(nil);
    try
      RESTResponse := TRESTResponse.Create(nil);
      try
        RESTRequest.Client := RESTClient;
        RESTRequest.Response := RESTResponse;
        RESTClient.BaseURL := FBaseURL;
        RESTClient.ContentType := 'application/x-www-form-urlencoded';
        RESTRequest.Method := TRESTRequestMethod.rmPOST;
        try
          RESTRequest.Execute;
        except
          Result := False;
        end;
        Result := RESTResponse.StatusCode = 200
      finally
        FreeAndNil(RESTResponse);
      end;
    finally
      FreeAndNil(RESTRequest);
    end;
  finally
    FreeAndNil(RESTClient);
  end;
end;

function TConsulta.CNPJ(const Value: string): IConsulta;
begin
  Result := Self;
  FCNPJ := Value;
end;

function TConsulta.Token: string;
begin
  Result := FToken;
end;

function TConsulta.Token(const Value: string): IConsulta;
begin
  Result := Self;
  FToken := Value;
end;

function TConsulta.Usuario(const Value: string): IConsulta;
begin
  Result := Self;
  FUsuario := Value;
end;

function TConsulta.Usuario: string;
begin
  Result := FUsuario;
end;

end.
