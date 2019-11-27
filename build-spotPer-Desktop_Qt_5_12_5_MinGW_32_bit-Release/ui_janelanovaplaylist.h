/********************************************************************************
** Form generated from reading UI file 'janelanovaplaylist.ui'
**
** Created by: Qt User Interface Compiler version 5.12.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_JANELANOVAPLAYLIST_H
#define UI_JANELANOVAPLAYLIST_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QHeaderView>
#include <QtWidgets/QLabel>
#include <QtWidgets/QLineEdit>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QTableWidget>
#include <QtWidgets/QVBoxLayout>

QT_BEGIN_NAMESPACE

class Ui_JanelaNovaPlaylist
{
public:
    QGridLayout *gridLayout_2;
    QGridLayout *gridLayout;
    QLabel *label_3;
    QLineEdit *lineEditNomePlaylist;
    QPushButton *btnCriarPlaylist;
    QVBoxLayout *verticalLayout;
    QLabel *label;
    QTableWidget *tableWidgetAlbuns;
    QPushButton *btnPesquisarFaixas;
    QVBoxLayout *verticalLayout_2;
    QLabel *label_2;
    QTableWidget *tableWidgetFaixas;
    QPushButton *btnAddAPlaylist;

    void setupUi(QDialog *JanelaNovaPlaylist)
    {
        if (JanelaNovaPlaylist->objectName().isEmpty())
            JanelaNovaPlaylist->setObjectName(QString::fromUtf8("JanelaNovaPlaylist"));
        JanelaNovaPlaylist->resize(618, 447);
        JanelaNovaPlaylist->setModal(true);
        gridLayout_2 = new QGridLayout(JanelaNovaPlaylist);
        gridLayout_2->setObjectName(QString::fromUtf8("gridLayout_2"));
        gridLayout = new QGridLayout();
        gridLayout->setObjectName(QString::fromUtf8("gridLayout"));
        label_3 = new QLabel(JanelaNovaPlaylist);
        label_3->setObjectName(QString::fromUtf8("label_3"));

        gridLayout->addWidget(label_3, 0, 0, 1, 1);

        lineEditNomePlaylist = new QLineEdit(JanelaNovaPlaylist);
        lineEditNomePlaylist->setObjectName(QString::fromUtf8("lineEditNomePlaylist"));

        gridLayout->addWidget(lineEditNomePlaylist, 0, 1, 1, 1);

        btnCriarPlaylist = new QPushButton(JanelaNovaPlaylist);
        btnCriarPlaylist->setObjectName(QString::fromUtf8("btnCriarPlaylist"));

        gridLayout->addWidget(btnCriarPlaylist, 0, 2, 1, 1);


        gridLayout_2->addLayout(gridLayout, 0, 0, 1, 2);

        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName(QString::fromUtf8("verticalLayout"));
        label = new QLabel(JanelaNovaPlaylist);
        label->setObjectName(QString::fromUtf8("label"));

        verticalLayout->addWidget(label);

        tableWidgetAlbuns = new QTableWidget(JanelaNovaPlaylist);
        tableWidgetAlbuns->setObjectName(QString::fromUtf8("tableWidgetAlbuns"));

        verticalLayout->addWidget(tableWidgetAlbuns);

        btnPesquisarFaixas = new QPushButton(JanelaNovaPlaylist);
        btnPesquisarFaixas->setObjectName(QString::fromUtf8("btnPesquisarFaixas"));
        btnPesquisarFaixas->setCheckable(false);

        verticalLayout->addWidget(btnPesquisarFaixas);


        gridLayout_2->addLayout(verticalLayout, 1, 0, 1, 1);

        verticalLayout_2 = new QVBoxLayout();
        verticalLayout_2->setObjectName(QString::fromUtf8("verticalLayout_2"));
        label_2 = new QLabel(JanelaNovaPlaylist);
        label_2->setObjectName(QString::fromUtf8("label_2"));

        verticalLayout_2->addWidget(label_2);

        tableWidgetFaixas = new QTableWidget(JanelaNovaPlaylist);
        tableWidgetFaixas->setObjectName(QString::fromUtf8("tableWidgetFaixas"));

        verticalLayout_2->addWidget(tableWidgetFaixas);

        btnAddAPlaylist = new QPushButton(JanelaNovaPlaylist);
        btnAddAPlaylist->setObjectName(QString::fromUtf8("btnAddAPlaylist"));

        verticalLayout_2->addWidget(btnAddAPlaylist);


        gridLayout_2->addLayout(verticalLayout_2, 1, 1, 1, 1);


        retranslateUi(JanelaNovaPlaylist);

        QMetaObject::connectSlotsByName(JanelaNovaPlaylist);
    } // setupUi

    void retranslateUi(QDialog *JanelaNovaPlaylist)
    {
        JanelaNovaPlaylist->setWindowTitle(QApplication::translate("JanelaNovaPlaylist", "Nova Playlist", nullptr));
        label_3->setText(QApplication::translate("JanelaNovaPlaylist", "<html><head/><body><p><span style=\" font-size:12pt;\">Nome Playlist:</span></p></body></html>", nullptr));
        btnCriarPlaylist->setText(QApplication::translate("JanelaNovaPlaylist", "Criar Playlist", nullptr));
        label->setText(QApplication::translate("JanelaNovaPlaylist", "<html><head/><body><p><span style=\" font-size:18pt; font-weight:600;\">Albuns</span></p></body></html>", nullptr));
        btnPesquisarFaixas->setText(QApplication::translate("JanelaNovaPlaylist", "Pesquisar Faixas", nullptr));
        label_2->setText(QApplication::translate("JanelaNovaPlaylist", "<html><head/><body><p><span style=\" font-size:18pt; font-weight:600;\">Faixas</span></p></body></html>", nullptr));
        btnAddAPlaylist->setText(QApplication::translate("JanelaNovaPlaylist", "Adicionar a Playlist", nullptr));
    } // retranslateUi

};

namespace Ui {
    class JanelaNovaPlaylist: public Ui_JanelaNovaPlaylist {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_JANELANOVAPLAYLIST_H
