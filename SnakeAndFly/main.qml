import QtQuick 2.12
import QtQuick.Window 2.12

import "qrc:/object"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    property var bulletManager: []
    property var bulletComponent: Qt.createComponent("qrc:/object/Bullet.qml")
    Fly {
        id: fly
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            snake.moveTo(mouseX, mouseY)
            // calculate target
            var sX = Math.abs(mouseX - snake.x)
            var sY = Math.abs(mouseY - snake.y)
            var distance = Math.sqrt(sX * sX + sY * sY)
            var _incY = sY / distance * 10
            var _incX = sX / distance * 10
            if (sX > sY){
                _incY *= (snake.y > mouseY) ? -1 : 1
                _incX *= (snake.x > mouseX) ? -1 : 1
            } else {
                _incX *= (snake.x > mouseX) ? -1 : 1
                _incY *= (snake.y > mouseY) ? -1 : 1
            }
            var bulletObj = bulletComponent.createObject(parent,
                                                         {
                                                             x: snake.x,
                                                             y: snake.y,
                                                             incX: _incX,
                                                             incY: _incY
                                                         })
            bulletManager.push(bulletObj)
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
    Timer {
        interval: 10
        running: true
        repeat: true
        onTriggered: {
            for (var i = 0; i < bulletManager.length; i++){
                var bullet = bulletManager[i]
                if (bullet.isOutOfRange()){
                    bullet.destroy()
                    bulletManager.splice(i, 1)
                } else {
                    bullet.increasePosition()
                }
            }
        }
    }

    Snake {
        id: snake
        x: 100
        y: 100
    }
}
