import QtQuick 2.12
import QtQuick.Window 2.12

import "qrc:/object"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property var bulletComponent: Qt.createComponent("qrc:/object/Bullet.qml")
    Fly {
        id: fly
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            snake.moveTo(mouseX, mouseY)
            var sX = Math.abs(mouseX - snake.x)
            var sY = Math.abs(mouseY - snake.y)
            var _incY = 0
            var _incX = 0
            if (sX > sY){
                _incY = (snake.y > mouseY) ? -1 : 1
                _incX = (snake.x > mouseX) ? -sX/sY : sX/sY
            } else {
                _incX = (snake.x > mouseX) ? -1 : 1
                _incY = (snake.y > mouseY) ? -sY/sX : sY/sX
            }
            bulletComponent.createObject(parent,
                                         {
                                             x: snake.x,
                                             y: snake.y,
                                             incX: _incX,
                                             incY: _incY
                                         })
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            fly.moveTo(Math.floor(Math.random() * parent.width),
                       Math.floor(Math.random() * parent.height))
        }
    }
    Snake {
        id: snake
        x: 100
        y: 100
    }
}
