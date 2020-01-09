#include "AppMain.h"

AppMain::AppMain()
{
    m_view = new QQuickView(QUrl("qrc:/main.qml"));
    m_view->show();
}
