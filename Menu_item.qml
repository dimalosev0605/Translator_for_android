import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: file_menu.width
    height: 30
    color: mouse_area.pressed ? "#00ff00" : "white"
    border.width: 1
    border.color: "#000000"

    property alias text: text.text
    property alias mouse_area: mouse_area

    Text {
        id: text
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        height: parent.height
        fontSizeMode: Text.Fit
        minimumPointSize: 5
        font.pointSize: 10
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
    }

}
