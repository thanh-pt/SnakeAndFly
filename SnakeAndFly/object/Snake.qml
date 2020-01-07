import QtQuick 2.0

Item {
    id: snake_container
    anchors.fill: parent
    property int _PIXEL_SIZE: 40
    property int currentDir: 1
    property var dirMatchX: [-1, 1, 0, 0]
    property var dirMatchY: [0, 0, -1, 1]
    property var matchRotation: [90, -90, 180, 0]
    property var tails: []
    property int headX: head.x + head.width / 2
    property int headY: head.y + head.height / 2

    function moveLeft(){
        currentDir = 0
    }

    function moveRight(){
        currentDir = 1
    }

    function moveUp(){
        currentDir = 2
    }

    function moveDown(){
        currentDir = 3
    }

    function addTail(){
        var current_tail = tails[tails.length-1]
        var new_x = current_tail.x - _PIXEL_SIZE * dirMatchX[current_tail.dir]
        var new_y = current_tail.y - _PIXEL_SIZE * dirMatchY[current_tail.dir]
        var newTail = tail_component.createObject(snake_container,
                                                  {
                                                      x: new_x,
                                                      y: new_y,
                                                      dir: current_tail.dir
                                                  })
        tails.push(newTail)
    }

    function run(){
        for (var i = tails.length-1; i > 0; i--){
            tails[i].x += dirMatchX[tails[i].dir] * _PIXEL_SIZE
            tails[i].y += dirMatchY[tails[i].dir] * _PIXEL_SIZE
            tails[i].dir = tails[i-1].dir
        }

        tails[0].x += dirMatchX[tails[0].dir] * _PIXEL_SIZE
        tails[0].y += dirMatchY[tails[0].dir] * _PIXEL_SIZE
        tails[0].dir = currentDir

        head.x += dirMatchX[currentDir] * _PIXEL_SIZE
        head.y += dirMatchY[currentDir] * _PIXEL_SIZE
        head.rotation = matchRotation[currentDir]
    }

    Component {
        id: tail_component
        Item {
            id: id_tail
            width: _PIXEL_SIZE
            height: _PIXEL_SIZE
            property int dir
            Rectangle {
                width: 20
                height: 20
                radius: 5
                anchors.centerIn: parent
                color: "#2ecc71"
                border.width: 1
                Text {
                    text: id_tail.dir
                    anchors.centerIn: parent
                }
            }
        }
    }

    Image {
        id: head
        width: _PIXEL_SIZE
        height: _PIXEL_SIZE
        rotation: -90
        source: "qrc:/resources/snake_head.png"
    }

    Component.onCompleted: {
        tails.push(tail_component.createObject(snake_container, {x: head.x-_PIXEL_SIZE * 1, y: head.y, dir: currentDir}))
    }
}
