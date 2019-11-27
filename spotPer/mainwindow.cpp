#include "mainwindow.h"
#include "ui_mainwindow.h"
#include "janelanovaplaylist.h"
#include "janelaverplaylist.h"

static QSqlDatabase db = QSqlDatabase::addDatabase("QODBC");

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QString servername = "DESKTOP-5LSHH6H\\SQLEXPRESS";
    QString dbname = "BDspotPer";
    QString dbuser = "sa";
    QString dbpassword = "123456";

    db.setConnectOptions();

    QString dsn = QString("DRIVER={SQL Server};SERVER=%1;DATABASE=%2;UID=%3;PWD=%4").arg(servername).arg(dbname).arg(dbuser).arg(dbpassword);

    db.setDatabaseName(dsn);

    if(db.open()){
        qDebug() << "db conectado!";
    }
    else{
        qDebug() << "Algum erro aconteceu! " ;
    }
}

MainWindow::~MainWindow()
{
    delete ui;
}


void MainWindow::on_btnNovaPlaylist_clicked()
{
    JanelaNovaPlaylist novaPlaylist;
    novaPlaylist.exec();
}

void MainWindow::on_btnVerPlaylist_clicked()
{
    JanelaVerPlaylist verPlaylist;
    verPlaylist.exec();
}
