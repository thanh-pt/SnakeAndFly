import QtQuick 2.0

Item {
    id: bullet_container
    property int incX
    property int incY
    Rectangle {
        width: 20
        height: 20
        radius: 10
        color: "lightblue"
        border.width: 1
    }
    Timer {
        id: timer
        interval: 5
        running: true
        repeat: true
        onTriggered: {
            x += incX
            y += incY
        }
    }
    onXChanged: {
        if (x > parent.width - 20 || x < 0){
            timer.stop()
        }
    }
    onYChanged: {
        if (y > parent.width + 20 || y < 0){
            timer.stop()
        }
    }
}
