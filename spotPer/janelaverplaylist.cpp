#include "janelaverplaylist.h"
#include "ui_janelaverplaylist.h"

JanelaVerPlaylist::JanelaVerPlaylist(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::JanelaVerPlaylist)
{
    ui->setupUi(this);
}

JanelaVerPlaylist::~JanelaVerPlaylist()
{
    delete ui;
}
