import QtQuick 2.0
import "qrc:/common"

Item {
    id: bullet_container
    width: Define._PIXEL_SIZE
    height: width
    z: -1
    property var dirMatchX: [-1, 1, 0, 0]
    property var dirMatchY: [0, 0, -1, 1]
    property int dir
    property int incX
    property int incY
    function run(){
        x += dirMatchX[dir] * Define._PIXEL_SIZE
        y += dirMatchY[dir] * Define._PIXEL_SIZE
    }
    function isOutOfRange(){
        if (x > parent.width - Define._PIXEL_SIZE || x < 0){
            return true
        }
        if (y > parent.height - Define._PIXEL_SIZE || y < 0){
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
