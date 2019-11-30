#include "janelanovaplaylist.h"
#include "ui_janelanovaplaylist.h"
#include <QtSql>
#include <QtDebug>
#include <QMessageBox>

JanelaNovaPlaylist::JanelaNovaPlaylist(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::JanelaNovaPlaylist)
{
    ui->setupUi(this);
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
}

JanelaNovaPlaylist::~JanelaNovaPlaylist()
{
    delete ui;
}

void JanelaNovaPlaylist::on_btnCriarPlaylist_clicked()
{
    //pegando oq esta no campo de texto
    QString nome_playlist = ui->lineEditNomePlaylist->text();

    QSqlQuery queryNovaPlaylist;
    queryNovaPlaylist.prepare("insert into playlist (nome, dt_criacao, tempo_execucao) values('"+nome_playlist+"', '25-11-2019', '00:00:00')");
    if(queryNovaPlaylist.exec()){
        QMessageBox::about(this, "Playlist criada!", "Escolha o album desejado e adicione faixas à "+nome_playlist+ "!");
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar criar a playlist!");
    }
    ui->lineEditNomePlaylist->setStyleSheet("QLineEdit {background-color: #33c88a}");
}

void JanelaNovaPlaylist::on_btnPesquisarFaixas_clicked()
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

void JanelaNovaPlaylist::on_btnAddAPlaylist_clicked()
{
    int linha1 = ui->tableWidgetAlbuns->currentRow();
    QString cod_album_selecionado = ui->tableWidgetAlbuns->item(linha1, 0)->text();

    int linha2 = ui->tableWidgetFaixas->currentRow();
    QString num_faixa_selecionado = ui->tableWidgetFaixas->item(linha2, 0)->text();

    QString nome_playlist = ui->lineEditNomePlaylist->text();
    QString cod_playlist;

    // query para obter o cod_playlist
    QSqlQuery queryCod_Playlist;
    queryCod_Playlist.prepare("select * from cod_playlist_nome('"+nome_playlist+"')");
    if(queryCod_Playlist.exec()){
        while(queryCod_Playlist.next()){
            cod_playlist = queryCod_Playlist.value(0).toString();
        }
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar obter o codigo da playlist!");
    }

    //adicionando faixa a playlist, na tabela playlist_faixa
    QSqlQuery queryAddFaixa_Playlist;
    queryAddFaixa_Playlist.prepare("insert into playlist_faixa (cod_playlist, num_faixa, cod_album) values ("+cod_playlist+","+num_faixa_selecionado+","+cod_album_selecionado+")");
    if(queryAddFaixa_Playlist.exec()){
        QMessageBox::information(this, "Faixa Adicionada", "Faixa adicionada à playlist "+nome_playlist+"!");
    }else{
        QMessageBox::warning(this, "ERRO", "Erro ao tentar adicionar a faixa à playlist!");
    }
}
