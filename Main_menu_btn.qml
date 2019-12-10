import QtQuick 2.9
import QtQuick.Controls 2.4

Rectangle {
    id: root
    border.width: 1
    border.color: "black"
    color: mouse_area.pressed ? "#00ff00" : "white"
    width: 100
    height: 40

    property alias mouse_area: mouse_area
    property alias text: text.text

    Text {
        id: text
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: parent.width
        height: parent.height
        fontSizeMode: Text.Fit
        minimumPointSize: 5
        font.pointSize: 15  // was 10
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
    }

}
