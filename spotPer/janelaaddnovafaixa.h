#ifndef JANELAADDNOVAFAIXA_H
#define JANELAADDNOVAFAIXA_H

#include <QDialog>

namespace Ui {
class janelaaddnovafaixa;
}

class janelaaddnovafaixa : public QDialog
{
    Q_OBJECT

public:
    explicit janelaaddnovafaixa(QWidget *parent = nullptr, QString cod_playlist=nullptr);
    ~janelaaddnovafaixa();

private slots:
    void on_btnPesquisarFaixas_clicked();

    void on_btnAddAPlaylist_clicked();

private:
    Ui::janelaaddnovafaixa *ui;
};

#endif // JANELAADDNOVAFAIXA_H
