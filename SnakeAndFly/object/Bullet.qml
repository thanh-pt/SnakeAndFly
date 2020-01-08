import QtQuick 2.0

Item {
    id: bullet_container
    width: 0
    height: 0
    z: -1
    property var dirMatchX: [-1, 1, 0, 0]
    property var dirMatchY: [0, 0, -1, 1]
    property int dir
    property int incX
    property int incY
    function run(){
        x += dirMatchX[dir] * 10
        y += dirMatchY[dir] * 10
    }
    function isOutOfRange(){
        if (x > parent.width - 20 || x < 0){
            return true
        }
        if (y > parent.width + 20 || y < 0){
            return true
        }

        return false
    }

    Rectangle {
        id: bullet_core
        width: 20
        height: 20
        anchors.centerIn: parent
        radius: 10
        color: "lightblue"
        border.width: 1
    }
}
