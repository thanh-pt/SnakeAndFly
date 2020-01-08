import QtQuick 2.12
import QtQuick.Window 2.12

import "qrc:/object"

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Snake and Fly")

    Timer {
        id: main_timer
        interval: 100
        running: true
        repeat: true
        property int snake_triger: 0
        onTriggered: {
            bulletManager.updateBullets()
            if (snake_triger++ == 3){
                snake.run()
                snake_triger = 0
            }
        }
    }

    Item {
        id: bulletManager
        property var bulletComponent: Qt.createComponent("qrc:/object/Bullet.qml")
        property var bullets: []
        function createBullet(_dir, _x, _y){
            var bulletObj = bulletComponent.createObject(parent,
                                                         {
                                                             x: _x,
                                                             y: _y,
                                                             dir: _dir
                                                         })
            bullets.push(bulletObj)
        }
        function updateBullets(){
            for (var i = 0; i < bullets.length; i++){
                var bullet = bullets[i]
                if (bullet.isOutOfRange()){
                    bullet.destroy()
                    bullets.splice(i, 1)
                } else {
                    bullet.run()
                }
            }
        }
    }

    Snake {
        id: snake
    }

    Item {
        id: keypad_manager
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            switch (event.key){
            case Qt.Key_Left:
                snake.moveLeft()
                break;
            case Qt.Key_Right:
                snake.moveRight()
                break;
            case Qt.Key_Up:
                snake.moveUp()
                break;
            case Qt.Key_Down:
                snake.moveDown()
                break;
            case Qt.Key_Space:
                if (snake.removeTail() === true){
                    bulletManager.createBullet(snake.currentDir, snake.headX, snake.headY)
                }
                break;
            }
        }
    }
}
