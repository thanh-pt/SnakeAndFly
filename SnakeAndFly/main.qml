import QtQuick 2.12
import QtSensors 5.11
import "qrc:/object"
import "qrc:/common"

Item {
//    width: 600
//    height: 500
    anchors.fill: parent

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
                if (fly.visible == false){
                    fly.newPosition()
                    fly.visible = true
                }
            }
            if (snake.headX == fly.x && snake.headY == fly.y){
                snake.addTail()
                fly.newPosition()
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

    Accelerometer {
        id: accel
        dataRate: 100
        active: true
        function calcPitch(x,y,z) {
            return -Math.atan2(y, Math.hypot(x, z)) * 180 / Math.PI;
        }
        function calcRoll(x,y,z) {
            return -Math.atan2(x, Math.hypot(y, z)) * 180 / Math.PI;
        }
        onReadingChanged: {
            var roll = calcRoll(accel.reading.x, accel.reading.y, accel.reading.z) * .1
            var pitch = calcPitch(accel.reading.x, accel.reading.y, accel.reading.z) * .1
            if (roll > 2){
                snake.moveRight()
            } else if (roll < -2){
                snake.moveLeft()
            }
            if (pitch > 2){
                snake.moveUp()
            } else if (pitch < -2){
                snake.moveDown()
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (snake.removeTail() === true){
                bulletManager.createBullet(snake.currentDir, snake.headX, snake.headY)
            }
        }
    }

    Fly {
        id: fly
        visible: false
        function newPosition(){
            var randX = Math.floor(Math.random() * (parent.width / Define._PIXEL_SIZE - 1)) * Define._PIXEL_SIZE
            var randY = Math.floor(Math.random() * (parent.height / Define._PIXEL_SIZE - 1))* Define._PIXEL_SIZE
            if (randX === 0){
                randX = Define._PIXEL_SIZE
            }
            if (randY === 0){
                randY = Define._PIXEL_SIZE
            }
            fly.x = randX
            fly.y = randY
        }
    }
}
