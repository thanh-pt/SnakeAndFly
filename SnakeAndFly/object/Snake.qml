import QtQuick 2.0

Item {
    function moveTo(_x, _y){
        head.rotation = -Math.atan((_x-x)/(_y-y))*180/Math.PI
        if (_y < y){
            head.rotation = head.rotation + 180
        }
    }
    Image {
        id: head
        width: 70
        height: 70
        source: "qrc:/resources/snake_head.png"
    }
}
