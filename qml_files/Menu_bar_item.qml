import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: 30
    height: 30 // equal to translator_menu_bar.height -> reference error?!?!?!?!
    color: mouse_area.pressed ? "#00ff00" : "white"
    property alias img: img
    property alias mouse_area: mouse_area

    Image {
        id: img
        anchors.fill: parent
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
    }
}
