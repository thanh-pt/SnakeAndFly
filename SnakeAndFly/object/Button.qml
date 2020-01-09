import QtQuick 2.0

Rectangle {
    border.width: 1
    color: "#1abc9c"
    property string text
    signal clicked()
    Text {
        anchors.centerIn: parent
        text: parent.text
    }
    MouseArea {
        anchors.fill: parent
        onClicked: parent.clicked()
    }
}
