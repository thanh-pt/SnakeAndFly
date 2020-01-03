import QtQuick 2.0

Item {
    width: 0
    height: 0
    property bool isMoving: false
    property int targetX
    property int targetY
    property int incX
    property int incY
    property int angle
    function moveTo(_x, _y){
        isMoving = true
        targetX = _x
        targetY = _y
        var sX = Math.abs(x-targetX)
        var sY = Math.abs(y-targetY)
        if (sX > sY){
            incY = (y > _y) ? -1 : 1
            incX = (x > targetX) ? -sX/sY : sX/sY
        } else {
            incX = (x > targetX) ? -1 : 1
            incY = (y > targetY) ? -sY/sX : sY/sX
        }
        fly_image.rotation = -Math.atan((targetX-x)/(targetY-y))*180/Math.PI
        if (targetY < y){
            fly_image.rotation = fly_image.rotation + 180
        }
    }

    Image {
        id: fly_image
        width: 50
        height: 50
        anchors.centerIn: parent
        source: "qrc:/resources/normal.png"
        function changeStatus(){
            if (source == "qrc:/resources/normal.png"){
                source = "qrc:/resources/high.png"
            } else {
                source = "qrc:/resources/normal.png"
            }
        }
    }

    Timer {
        interval: 10
        running: isMoving
        repeat: true
        onTriggered: {
            if (x == targetX || y == targetY){
                isMoving = false
            }
            x += incX
            y += incY
            fly_image.changeStatus()
        }
    }
}
