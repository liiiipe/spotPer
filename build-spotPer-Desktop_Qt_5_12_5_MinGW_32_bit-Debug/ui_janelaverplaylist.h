/********************************************************************************
** Form generated from reading UI file 'janelaverplaylist.ui'
**
** Created by: Qt User Interface Compiler version 5.12.5
**
** WARNING! All changes made in this file will be lost when recompiling UI file!
********************************************************************************/

#ifndef UI_JANELAVERPLAYLIST_H
#define UI_JANELAVERPLAYLIST_H

#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QDialog>

QT_BEGIN_NAMESPACE

class Ui_JanelaVerPlaylist
{
public:

    void setupUi(QDialog *JanelaVerPlaylist)
    {
        if (JanelaVerPlaylist->objectName().isEmpty())
            JanelaVerPlaylist->setObjectName(QString::fromUtf8("JanelaVerPlaylist"));
        JanelaVerPlaylist->resize(400, 300);

        retranslateUi(JanelaVerPlaylist);

        QMetaObject::connectSlotsByName(JanelaVerPlaylist);
    } // setupUi

    void retranslateUi(QDialog *JanelaVerPlaylist)
    {
        JanelaVerPlaylist->setWindowTitle(QApplication::translate("JanelaVerPlaylist", "Ver Playlist", nullptr));
    } // retranslateUi

};

namespace Ui {
    class JanelaVerPlaylist: public Ui_JanelaVerPlaylist {};
} // namespace Ui

QT_END_NAMESPACE

#endif // UI_JANELAVERPLAYLIST_H
