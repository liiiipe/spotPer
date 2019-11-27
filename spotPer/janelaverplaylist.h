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

private:
    Ui::JanelaVerPlaylist *ui;
};

#endif // JANELAVERPLAYLIST_H
