import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: 30
    height: 30
    color: mouse_area.pressed ? "#00ff00" : "white"

    Image {
        id: img
        anchors.fill: parent
        source: "qrc:/icons/back_btn_icon.svg"
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
        onClicked: stack_view.pop()
    }

}
