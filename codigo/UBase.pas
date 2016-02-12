unit UBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, System.ImageList,
  Vcl.ImgList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.Provider, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  DBGridBeleza, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons, Vcl.Imaging.pngimage;

type
  TFBase = class(TForm)
    DS: TDataSource;
    ClientDataSet1: TClientDataSet;
    DataSetProvider1: TDataSetProvider;
    FDQuery1: TFDQuery;
    PageControl: TPageControl;
    TbDados: TTabSheet;
    grDados: TGroupBox;
    TbFiltros: TTabSheet;
    GBFiltros: TGroupBox;
    DBGridBeleza1: TDBGridBeleza;
    Panel2: TPanel;
    ImageListBase: TImageList;
    BInserir: TSpeedButton;
    BEditar: TSpeedButton;
    BExcluir: TSpeedButton;
    BSalvar: TSpeedButton;
    BCancelar: TSpeedButton;
    BPesquisar: TSpeedButton;
    BFechar: TSpeedButton;
    ImgSaveWhite: TImage;
    ImgSaveGray: TImage;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image4: TImage;
    Image5: TImage;
    Image9: TImage;
    Image10: TImage;
    BFirst: TSpeedButton;
    BPrior: TSpeedButton;
    BNext: TSpeedButton;
    BLast: TSpeedButton;
    Acoes: TActionList;
    Action5: TAction;
    BtnLimparFiltros: TButton;
    Panel1: TPanel;
    PanelFiltros: TPanel;
    ActionMostrarFiltros: TAction;

    procedure ClientDataSet1AfterCancel(DataSet: TDataSet);
    procedure ClientDataSet1AfterDelete(DataSet: TDataSet);
    procedure ClientDataSet1AfterInsert(DataSet: TDataSet);
    procedure ClientDataSet1AfterPost(DataSet: TDataSet);
    procedure DSStateChange(Sender: TObject);
    procedure ClientDataSet1BeforeInsert(DataSet: TDataSet);
    procedure ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
    procedure BInserirClick(Sender: TObject);
    procedure BEditarClick(Sender: TObject);
    procedure BExcluirClick(Sender: TObject);
    procedure BSalvarClick(Sender: TObject);
    procedure BCancelarClick(Sender: TObject);
    procedure BPesquisarClick(Sender: TObject);
    procedure BFecharClick(Sender: TObject);
    procedure BFirstClick(Sender: TObject);
    procedure BPriorClick(Sender: TObject);
    procedure BNextClick(Sender: TObject);
    procedure BLastClick(Sender: TObject);
    procedure DSDataChange(Sender: TObject; Field: TField);
    procedure Action5Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLimparFiltrosClick(Sender: TObject);
    procedure ActionMostrarFiltrosExecute(Sender: TObject);
  private
    { Private declarations }
    procedure StatusBotoes (e : integer);
  public
    { Public declarations }
    function CorCamposOnlyRead():TColor;
  end;

var
  FBase: TFBase;

implementation

{$R *.dfm}


procedure TFBase.Action5Execute(Sender: TObject);
begin
//
end;

procedure TFBase.ActionMostrarFiltrosExecute(Sender: TObject);
begin
  if(PanelFiltros.Visible = true) then
  begin
       PanelFiltros.Visible := false;
  end else
  begin
    PanelFiltros.Visible := true;
  end;

end;

procedure TFBase.ArredondarComponente(Componente: TWinControl; const Radius: SmallInt);
var
  R : TRect;
  Rgn : HRGN;
begin
  with Componente do
  begin
    R := ClientRect;
    Rgn := CreateRoundRectRgn(R.Left +2, R.Top+2, R.Right-2, R.Bottom-2, Radius, Radius);

    //Perform(EM_GETRECT, 0, lParam(@R));
    //InflateRect(R, -5, -5);
    //Perform(EM_SETRECTNP, 0, lParam(@R));
    SetWindowRgn(Handle, Rgn, True);
    Invalidate;
  end;

end;

procedure TFBase.ClientDataSet1AfterCancel(DataSet: TDataSet);
begin
 ClientDataSet1.CancelUpdates;
end;

procedure TFBase.ClientDataSet1AfterDelete(DataSet: TDataSet);
begin
  ClientDataSet1.ApplyUpdates(-1);
end;

procedure TFBase.ClientDataSet1AfterInsert(DataSet: TDataSet);
begin
    {Toda tela tem um codigo com parametro diferente.  >> SEQUENCIAL <<}
end;

procedure TFBase.ClientDataSet1AfterPost(DataSet: TDataSet);
begin
  ClientDataSet1.ApplyUpdates(-1);
end;


procedure TFBase.ClientDataSet1BeforeInsert(DataSet: TDataSet);
var i : integer;
begin

 TClientDataSet( dataset).IndexFieldNames := '';

  for i := 0 to TClientDataSet(DataSet).IndexDefs.Count - 1 do
  begin
    TClientDataSet(DataSet).IndexDefs.delete(i);
  end;
end;

function TFBase.CorCamposOnlyRead: TColor;
begin
  Result := $00CECBC2;
end;

procedure TFBase.DSDataChange(Sender: TObject; Field: TField);
begin
//
end;

procedure TFBase.DSStateChange(Sender: TObject);
begin
    tbFiltros.TabVisible := ds.DataSet.State in [dsBrowse, dsInactive];
    grDados.Enabled      := ds.DataSet.State in dsEditModes;

    if ds.DataSet.State in dsEditModes then
      StatusBotoes(1)
    else
      StatusBotoes(2);
end;

procedure TFBase.FormShow(Sender: TObject);
begin
  BPesquisar.Click;
  ArredondarComponente(BtnLimparFiltros, 60);
end;

procedure TFBase.BInserirClick(Sender: TObject);
begin
  if not ds.DataSet.Active then
        ds.DataSet.Open;

    PageControl.ActivePageIndex := 0;
    ds.DataSet.Append;

end;

procedure TFBase.BLastClick(Sender: TObject);
begin
DS.DataSet.Last;
end;

procedure TFBase.BNextClick(Sender: TObject);
begin
DS.DataSet.Next;
end;

procedure TFBase.BEditarClick(Sender: TObject);
begin
if ds.DataSet.Active then
    begin
        if not ds.DataSet.IsEmpty then
        begin
            ds.DataSet.Edit;
            PageControl.ActivePageIndex := 0;
        end else
            ShowMessage('N�o H� Registros para Altera��o.');
    end;

end;

procedure TFBase.BExcluirClick(Sender: TObject);
begin
if ds.DataSet.Active then
  begin
    if not ds.DataSet.IsEmpty then
    begin
        if (Application.MessageBox('Deseja Deletar ', 'Deletar', MB_YESNO + MB_ICONQUESTION) = id_yes) then
        begin
          ds.DataSet.Delete;
        end;
    end
    else
        ShowMessage('N�o H� registros');
  end;

end;

procedure TFBase.BFecharClick(Sender: TObject);
begin
  close;
end;

procedure TFBase.BFirstClick(Sender: TObject);
begin
DS.DataSet.First;
end;

procedure TFBase.BSalvarClick(Sender: TObject);
begin
DS.DataSet.Post;
DS.OnDataChange(Sender, nil);
end;

procedure TFBase.BtnLimparFiltrosClick(Sender: TObject);
begin
//
  ClientDataSet1.Filtered := false;
end;

procedure TFBase.BCancelarClick(Sender: TObject);
begin
if (Application.MessageBox('Deseja Cancelar ', 'Cancelar', MB_YESNO + MB_ICONQUESTION )= id_yes) then
    begin
        action5.Execute;
        ds.DataSet.Cancel;
        DS.OnDataChange(Sender, nil);
    end;

end;

procedure TFBase.BPesquisarClick(Sender: TObject);
begin
  DS.DataSet.Close;
  DS.DataSet.Open;
end;

procedure TFBase.BPriorClick(Sender: TObject);
begin
DS.DataSet.Prior;
end;

procedure TFBase.StatusBotoes(e: integer);
begin
//
  BSalvar.Enabled := e=1;

  BCancelar.Enabled := e=1;

  //Next Prior Lest Fi
  BPrior.Enabled := (e=2) and not (DS.DataSet.IsEmpty);
  BNext.Enabled := (e=2) and not (DS.DataSet.IsEmpty);
  BFirst.Enabled := (e=2) and not (DS.DataSet.IsEmpty);
  BLast.Enabled := (e=2) and not (DS.DataSet.IsEmpty);
  BFechar.Enabled := (e=2) and not (DS.DataSet.IsEmpty);

  BInserir.Enabled := e=2;

  BExcluir.Enabled := (e=2) and not (DS.DataSet.IsEmpty);

  BEditar.Enabled := (e=2) and not (DS.DataSet.IsEmpty);

  BEditar.Enabled := (e=2) and not (DS.DataSet.IsEmpty);

  BPesquisar.Enabled := e=2;

end;

end.
