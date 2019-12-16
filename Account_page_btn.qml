import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    property alias text: text.text
    property alias mouse_area: mouse_area
    color: enabled ? mouse_area.pressed ? "#00ff00" : "white" : "#cfcfcf"
    border.width: 1
    border.color: "black"

    Text {
        id: text
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        height: parent.height
        fontSizeMode: Text.Fit
        minimumPointSize: 3
        font.pointSize: 10
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
    }
}
