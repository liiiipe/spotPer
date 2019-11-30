#ifndef JANELAVERPLAYLIST_H
#define JANELAVERPLAYLIST_H

#include <QDialog>

namespace Ui {
class JanelaVerPlaylist;
}

class JanelaVerPlaylist : public QDialog
{
    Q_OBJECT

public:
    explicit JanelaVerPlaylist(QWidget *parent = nullptr);
    ~JanelaVerPlaylist();

private slots:
    void on_btnPesquisarFaixas_clicked();

    void on_btnDeletarFaixa_clicked();

private:
    Ui::JanelaVerPlaylist *ui;
};

#endif // JANELAVERPLAYLIST_H
