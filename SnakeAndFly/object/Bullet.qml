import QtQuick 2.0

Item {
    id: bullet_container
    property int incX
    property int incY
    function increasePosition(){
        x += incX
        y += incY
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
        radius: 10
        color: "lightblue"
        border.width: 1
    }
}
