#include "janelaverplaylist.h"
#include "ui_janelaverplaylist.h"

#include "janelaaddnovafaixa.h"

#include <QtSql>
#include <QtDebug>
#include <QMessageBox>

JanelaVerPlaylist::JanelaVerPlaylist(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::JanelaVerPlaylist)
{
    ui->setupUi(this);

    //exibindo playlists
    QSqlQuery queryPlaylist;
    queryPlaylist.prepare("select cod_playlist, nome from playlist");
    if(queryPlaylist.exec()){
        int cont=0;
        ui->tableWidgetPlaylists->setColumnCount(2);
        while(queryPlaylist.next()){
            ui->tableWidgetPlaylists->insertRow(cont);
            ui->tableWidgetPlaylists->setItem(cont, 0, new QTableWidgetItem(queryPlaylist.value(0).toString()));
            ui->tableWidgetPlaylists->setItem(cont, 1, new QTableWidgetItem(queryPlaylist.value(1).toString()));
            cont++;
        }
        //setando largura das colunas
        ui->tableWidgetPlaylists->setColumnWidth(0, 65);
        ui->tableWidgetPlaylists->setColumnWidth(1, 189);

        //setando nome das colunas, nao edicao de conteudo, selecionando linha inteira, desabilitando numero das linhas, e mudando cor da linha
        QStringList cabecalhos = {"Código", "Nome"};
        ui->tableWidgetPlaylists->setHorizontalHeaderLabels(cabecalhos);
        ui->tableWidgetPlaylists->setEditTriggers(QAbstractItemView::NoEditTriggers);
        ui->tableWidgetPlaylists->setSelectionBehavior(QAbstractItemView::SelectRows);
        ui->tableWidgetPlaylists->verticalHeader()->setVisible(false);
        ui->tableWidgetPlaylists->setStyleSheet("QTableView {selection-background-color: #33c88a}");
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar exibir as playlists existentes!");
    }

}

JanelaVerPlaylist::~JanelaVerPlaylist()
{
    delete ui;
}

void JanelaVerPlaylist::on_btnPesquisarFaixas_clicked()
{
    //apagando as faixas do album selecionado anteriormente
    ui->tableWidgetFaixas->setRowCount(0);

    //exibindo faixas
    int linha = ui->tableWidgetPlaylists->currentRow();
    QString cod_playlist_selecionado = ui->tableWidgetPlaylists->item(linha, 0)->text();
    QSqlQuery queryFaixas_Playlist;
    queryFaixas_Playlist.prepare("select f.cod_album, f.num_faixa, f.descricao from faixa f, playlist_faixa pf where f.num_faixa = pf.num_faixa and f.cod_album = pf.cod_album and pf.cod_playlist="+cod_playlist_selecionado);
    if(queryFaixas_Playlist.exec()){
        int cont = 0;
        ui->tableWidgetFaixas->setColumnCount(3);
        while(queryFaixas_Playlist.next()){
            ui->tableWidgetFaixas->insertRow(cont);
            ui->tableWidgetFaixas->setItem(cont, 0, new QTableWidgetItem(queryFaixas_Playlist.value(0).toString()));
            ui->tableWidgetFaixas->setItem(cont, 1, new QTableWidgetItem(queryFaixas_Playlist.value(1).toString()));
            ui->tableWidgetFaixas->setItem(cont, 2, new QTableWidgetItem(queryFaixas_Playlist.value(2).toString()));
            cont++;
        }

        //setando largura das colunas
        ui->tableWidgetFaixas->setColumnWidth(0, 75);
        ui->tableWidgetFaixas->setColumnWidth(1, 75);
        ui->tableWidgetFaixas->setColumnWidth(2, 212);

        //setando nome das colunas, nao edicao de conteudo, selecionando linha inteira, desabilitando numero das linhas, e mudando cor da linha
        QStringList cabecalhos = {"Cod Album", "Número", "Faixa"};
        ui->tableWidgetFaixas->setHorizontalHeaderLabels(cabecalhos);
        ui->tableWidgetFaixas->setEditTriggers(QAbstractItemView::NoEditTriggers);
        ui->tableWidgetFaixas->setSelectionBehavior(QAbstractItemView::SelectRows);
        ui->tableWidgetFaixas->verticalHeader()->setVisible(false);
        ui->tableWidgetFaixas->setStyleSheet("QTableView {selection-background-color: #33c88a}");

    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar exibir as faixas existentes da playlist!");
    }
}

void JanelaVerPlaylist::on_btnDeletarFaixa_clicked()
{
    int linha1 = ui->tableWidgetPlaylists->currentRow();
    QString cod_playlist_selecionado = ui->tableWidgetPlaylists->item(linha1, 0)->text();

    int linha2 = ui->tableWidgetFaixas->currentRow();
    QString cod_album_faixa_selecionado = ui->tableWidgetFaixas->item(linha2, 0)->text();

    int linha3 = ui->tableWidgetFaixas->currentRow();
    QString num_faixa_selecionado = ui->tableWidgetFaixas->item(linha3, 1)->text();

    //deletando faixa
    QSqlQuery queryDeleteFaixa;
    queryDeleteFaixa.prepare("delete from playlist_faixa where cod_playlist="+cod_playlist_selecionado+" and cod_album="+cod_album_faixa_selecionado+" and num_faixa="+num_faixa_selecionado);
    if(queryDeleteFaixa.exec()){
        on_btnPesquisarFaixas_clicked();
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar deletar faixa existente da playlist!");
    }

}

void JanelaVerPlaylist::on_btnAddNovaFaixa_clicked()
{
    int linha1 = ui->tableWidgetPlaylists->currentRow();
    QString cod_playlist_selecionado = ui->tableWidgetPlaylists->item(linha1, 0)->text();

    janelaaddnovafaixa addnovafaixa(this, cod_playlist_selecionado);
    addnovafaixa.exec();

    on_btnPesquisarFaixas_clicked();
}
