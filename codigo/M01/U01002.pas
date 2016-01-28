unit U01002;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UBase, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  System.Actions, Vcl.ActnList, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider, Datasnap.DBClient, System.ImageList, Vcl.ImgList,
  Vcl.Grids, Vcl.DBGrids, DBGridBeleza, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls;

type
  TF01002 = class(TFBase)
    FDQuery1idcronometrista: TIntegerField;
    FDQuery1nome: TStringField;
    ClientDataSet1idcronometrista: TIntegerField;
    ClientDataSet1nome: TStringField;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    procedure acInserirExecute(Sender: TObject);
    procedure acEditarExecute(Sender: TObject);
    procedure ClientDataSet1AfterInsert(DataSet: TDataSet);
    procedure acSalvarExecute(Sender: TObject);
    procedure acCancelarExecute(Sender: TObject);
    procedure acExcluirExecute(Sender: TObject);
    procedure BInserirClick(Sender: TObject);
    procedure BEditarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F01002: TF01002;

implementation

{$R *.dfm}

uses
uDataModule;

procedure TF01002.acCancelarExecute(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := clWindow;
end;

procedure TF01002.acEditarExecute(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := CorCamposOnlyRead();
end;

procedure TF01002.acExcluirExecute(Sender: TObject);
begin
  DModule.qAux.Close;
  DModule.qAux.SQL.Text := 'select * from cronometragem c where c.idCronometrista =:idC';
  DModule.qAux.ParamByName('idC').AsInteger:= (ClientDataSet1idcronometrista.AsInteger);
  DModule.qAux.Open;
  if(DModule.qAux.IsEmpty)then
  begin
    inherited;
  end else
    ShowMessage('Cronometragem vinculada ao Cronometrista. N�o � poss�vel excluir.');

end;

procedure TF01002.acInserirExecute(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := CorCamposOnlyRead();
end;

procedure TF01002.acSalvarExecute(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := clWindow;
end;

procedure TF01002.Action5Execute(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := clWindow;
end;

procedure TF01002.BEditarClick(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := CorCamposOnlyRead();
end;

procedure TF01002.BExcluirClick(Sender: TObject);
begin
  inherited;
  DModule.qAux.Close;
  DModule.qAux.SQL.Text := 'select * from cronometragem c where c.idCronometrista =:idC';
  DModule.qAux.ParamByName('idC').AsInteger:= (ClientDataSet1idcronometrista.AsInteger);
  DModule.qAux.Open;
  if(DModule.qAux.IsEmpty)then
  begin
    inherited;
  end else
    ShowMessage('Cronometragem vinculada ao Cronometrista. N�o � poss�vel excluir.');

end;

procedure TF01002.BInserirClick(Sender: TObject);
begin
  inherited;
  DBEdit1.Color := CorCamposOnlyRead();
end;

procedure TF01002.BSalvarClick(Sender: TObject);
begin
  if trim(DBEdit2.Text) <> '' then
    begin
      inherited;
      DBEdit1.Color := clWindow;
    end else
      begin
       showmessage('Preencha o Campo Descri��o');
       DBEdit2.SetFocus;
      end;
end;

procedure TF01002.ClientDataSet1AfterInsert(DataSet: TDataSet);
begin
  inherited;
  ClientDataSet1idcronometrista.AsInteger := DModule.buscaProximoParametro('seqCronometrista');

end;

Initialization
  RegisterClass(TF01002);
Finalization
  UnRegisterClass(TF01002);
end.
