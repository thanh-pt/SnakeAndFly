import QtQuick 2.0

Item {
    id: snake_container
    anchors.fill: parent
    property int _PIXEL_SIZE: 40
    property int currentDir: 1
    property var dirMatchX: [-1, 1, 0, 0]
    property var dirMatchY: [0, 0, -1, 1]
    property var matchRotation: [90, -90, 180, 0]
    property var bodys: []
    property int headX: head.x + head.width / 2
    property int headY: head.y + head.height / 2

    function moveLeft(){
        if (head.rotationHead !== matchRotation[1])
            currentDir = 0
    }

    function moveRight(){
        if (head.rotationHead !== matchRotation[0])
            currentDir = 1
    }

    function moveUp(){
        if (head.rotationHead !== matchRotation[3])
            currentDir = 2
    }

    function moveDown(){
        if (head.rotationHead !== matchRotation[2])
            currentDir = 3
    }

    function addTail(){
        var current_body = bodys[bodys.length-1]
        var new_x = current_body.x - _PIXEL_SIZE * dirMatchX[current_body.dir]
        var new_y = current_body.y - _PIXEL_SIZE * dirMatchY[current_body.dir]
        var newBody = body_component.createObject(snake_container,
                                                  {
                                                      x: new_x,
                                                      y: new_y,
                                                      dir: current_body.dir
                                                  })
        bodys.push(newBody)
    }

    function removeTail(){
        var removeResult = false;
        if (bodys.length > 1) {
            var tail = bodys.pop()
            tail.destroy()
            removeResult = true
        }
        return removeResult
    }

    function getTailImage(_dir){
        var tail_image = ""
        switch (_dir){
        case 0:
            tail_image = "qrc:/resources/snake_tail_left.png"
            break;
        case 1:
            tail_image = "qrc:/resources/snake_tail_right.png"
            break;
        case 2:
            tail_image = "qrc:/resources/snake_tail_up.png"
            break;
        case 3:
            tail_image = "qrc:/resources/snake_tail_down.png"
            break;
        }
        return tail_image
    }

    function getBodyImage(_dir, _lastDir){
        var body_image = ""
        if (_dir === 1 || _dir === 0){
            body_image = "qrc:/resources/snake_body_verizontal.png"
        } else {
            body_image = "qrc:/resources/snake_body_horizontal.png"
        }
        if ((_dir === 2 && _lastDir === 1) || (_dir === 0 && _lastDir === 3)){
            body_image = "qrc:/resources/snake_body_1.png"
        } else if ((_dir === 2 && _lastDir === 0) || (_dir === 1 && _lastDir === 3)){
            body_image = "qrc:/resources/snake_body_2.png"
        } else if ((_dir === 3 && _lastDir === 0) || (_dir === 1 && _lastDir === 2)){
            body_image = "qrc:/resources/snake_body_3.png"
        } else if ((_dir === 3 && _lastDir === 1) || (_dir === 0 && _lastDir === 2)){
            body_image = "qrc:/resources/snake_body_4.png"
        }

        return body_image
    }

    function run(){
        for (var i = bodys.length-1; i >= 0; i--){
            var body = bodys[i]
            body.x += dirMatchX[body.dir] * _PIXEL_SIZE
            body.y += dirMatchY[body.dir] * _PIXEL_SIZE
            if (i === 0){
                body.dir = currentDir
            } else {
                body.dir = bodys[i-1].dir
            }

            if (i === bodys.length-1){
                // this is tail
                body.source = getTailImage(body.dir)
            } else {
                body.source = getBodyImage(body.dir, bodys[i+1].dir)
            }
        }

        head.x += dirMatchX[currentDir] * _PIXEL_SIZE
        head.y += dirMatchY[currentDir] * _PIXEL_SIZE
        head.rotationHead = matchRotation[currentDir]
    }

    Component {
        id: body_component
        Item {
            id: id_body
            width: _PIXEL_SIZE
            height: _PIXEL_SIZE
            z: -1
            property int dir
            property string source
            Image {
                anchors.fill: parent
                source: id_body.source
            }
        }
    }

    Item {
        id: head
        width: _PIXEL_SIZE
        height: _PIXEL_SIZE
        property int rotationHead: -90
        Image {
            width: _PIXEL_SIZE + 10
            height: width
            anchors.centerIn: parent
            rotation: head.rotationHead
            source: "qrc:/resources/snake_head.png"
        }
    }


    Component.onCompleted: {
        bodys.push(body_component.createObject(snake_container, {x: head.x-_PIXEL_SIZE * 1, y: head.y, dir: currentDir}))
        for (var i = 0; i < 3; i++){
            addTail()
        }
    }
}
