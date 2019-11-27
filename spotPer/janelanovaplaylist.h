#ifndef JANELANOVAPLAYLIST_H
#define JANELANOVAPLAYLIST_H

#include <QDialog>

namespace Ui {
class JanelaNovaPlaylist;
}

class JanelaNovaPlaylist : public QDialog
{
    Q_OBJECT

public:
    explicit JanelaNovaPlaylist(QWidget *parent = nullptr);
    ~JanelaNovaPlaylist();

private slots:
    void on_btnPesquisarFaixas_clicked();

    void on_btnCriarPlaylist_clicked();

    void on_btnAddAPlaylist_clicked();

private:
    Ui::JanelaNovaPlaylist *ui;
};

#endif // JANELANOVAPLAYLIST_H
