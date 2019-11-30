#include "janelaaddnovafaixa.h"
#include "ui_janelaaddnovafaixa.h"
#include <QtSql>
#include <QtDebug>
#include <QMessageBox>

static QString cod_playlist_selecionado;
static QString nome_playlist_selecionado;

janelaaddnovafaixa::janelaaddnovafaixa(QWidget *parent, QString cod_playlist) :
    QDialog(parent),
    ui(new Ui::janelaaddnovafaixa)
{
    ui->setupUi(this);

    cod_playlist_selecionado = cod_playlist;
    //exibindo albuns
    QSqlQuery queryAlbuns;
    queryAlbuns.prepare("select cod_album, descricao from album");
    if(queryAlbuns.exec()){
        int cont=0;
        ui->tableWidgetAlbuns->setColumnCount(2);
        while(queryAlbuns.next()){
            ui->tableWidgetAlbuns->insertRow(cont);
            ui->tableWidgetAlbuns->setItem(cont, 0, new QTableWidgetItem(queryAlbuns.value(0).toString()));
            ui->tableWidgetAlbuns->setItem(cont, 1, new QTableWidgetItem(queryAlbuns.value(1).toString()));
            cont++;
        }
        //setando largura das colunas
        ui->tableWidgetAlbuns->setColumnWidth(0, 65);
        ui->tableWidgetAlbuns->setColumnWidth(1, 243);

        //setando nome das colunas, nao edicao de conteudo, selecionando linha inteira, desabilitando numero das linhas, e mudando cor da linha
        QStringList cabecalhos = {"Código", "Album"};
        ui->tableWidgetAlbuns->setHorizontalHeaderLabels(cabecalhos);
        ui->tableWidgetAlbuns->setEditTriggers(QAbstractItemView::NoEditTriggers);
        ui->tableWidgetAlbuns->setSelectionBehavior(QAbstractItemView::SelectRows);
        ui->tableWidgetAlbuns->verticalHeader()->setVisible(false);
        ui->tableWidgetAlbuns->setStyleSheet("QTableView {selection-background-color: #33c88a}");
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar exibir os albuns existentes!");
    }

    //obter nome playlist e botar no btn
    QSqlQuery queryNome_Playlist;
    QString nome_playlist;
    queryNome_Playlist.prepare("select nome from playlist where cod_playlist="+cod_playlist_selecionado);
    if(queryNome_Playlist.exec()){
        while(queryNome_Playlist.next()){
            nome_playlist = queryNome_Playlist.value(0).toString();
        }
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar obter o nome da playlist!");
    }

    ui->btnAddAPlaylist->setText("Adicionar à Playlist "+nome_playlist);

    nome_playlist_selecionado = nome_playlist;
}

janelaaddnovafaixa::~janelaaddnovafaixa()
{
    delete ui;
}

void janelaaddnovafaixa::on_btnPesquisarFaixas_clicked()
{
    //apagando as faixas do album selecionado anteriormente
    ui->tableWidgetFaixas->setRowCount(0);

    //exibindo faixas
    int linha = ui->tableWidgetAlbuns->currentRow();
    QString cod_album_selecionado = ui->tableWidgetAlbuns->item(linha, 0)->text();
    QSqlQuery queryFaixas;
    queryFaixas.prepare("select num_faixa, descricao from faixa where cod_album="+cod_album_selecionado);
    if(queryFaixas.exec()){
        int cont = 0;
        ui->tableWidgetFaixas->setColumnCount(2);
        while(queryFaixas.next()){
            ui->tableWidgetFaixas->insertRow(cont);
            ui->tableWidgetFaixas->setItem(cont, 0, new QTableWidgetItem(queryFaixas.value(0).toString()));
            ui->tableWidgetFaixas->setItem(cont, 1, new QTableWidgetItem(queryFaixas.value(1).toString()));
            cont++;
        }

        //setando largura das colunas
        ui->tableWidgetFaixas->setColumnWidth(0, 65);
        ui->tableWidgetFaixas->setColumnWidth(1, 243);

        //setando nome das colunas, nao edicao de conteudo, selecionando linha inteira, desabilitando numero das linhas, e mudando cor da linha
        QStringList cabecalhos = {"Número", "Faixa"};
        ui->tableWidgetFaixas->setHorizontalHeaderLabels(cabecalhos);
        ui->tableWidgetFaixas->setEditTriggers(QAbstractItemView::NoEditTriggers);
        ui->tableWidgetFaixas->setSelectionBehavior(QAbstractItemView::SelectRows);
        ui->tableWidgetFaixas->verticalHeader()->setVisible(false);
        ui->tableWidgetFaixas->setStyleSheet("QTableView {selection-background-color: #33c88a}");

    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar exibir as faixas existentes!");
    }
}

void janelaaddnovafaixa::on_btnAddAPlaylist_clicked()
{
    int linha1 = ui->tableWidgetAlbuns->currentRow();
    QString cod_album_selecionado = ui->tableWidgetAlbuns->item(linha1, 0)->text();

    int linha2 = ui->tableWidgetFaixas->currentRow();
    QString num_faixa_selecionado = ui->tableWidgetFaixas->item(linha2, 0)->text();

    QSqlQuery queryAddFaixa_Playlist;
    queryAddFaixa_Playlist.prepare("insert into playlist_faixa (cod_playlist, num_faixa, cod_album) values ("+cod_playlist_selecionado+","+num_faixa_selecionado+","+cod_album_selecionado+")");
    if(queryAddFaixa_Playlist.exec()){
        QMessageBox::about(this, "Faixa Adicionada", "Faixa adicionada à playlist "+nome_playlist_selecionado+"!");
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar adicionar a faixa à playlist!");
    }
}
