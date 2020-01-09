#ifndef APPMAIN_H
#define APPMAIN_H

#include <QObject>
#include <QQuickView>

class AppMain : QObject
{
    Q_OBJECT
private:
    QQuickView* m_view;
public:
    AppMain();
};

#endif // APPMAIN_H
