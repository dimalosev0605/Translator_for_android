import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: blocks_list_view.width
    height: blocks_list_view.height / 4
    border.width: 1
    border.color: "black"
    color: examples.text === "" ? "white" : "#eeeeee"

    property alias transcription: transcription.text
    property alias type_speech: type_speech.text
    property alias syns: syns.text
    property alias means: means.text
    property alias examples: examples.text

    MouseArea {
        anchors.fill: parent
        onDoubleClicked: {
            if(examples.text === "") return
            if(!examples.visible) {
                examples.visible = true
                root.color = "white"
                transcription.visible = false
                type_speech.visible = false
                syns.visible = false
                means.visible = false
            }
            else {
                examples.visible = false
                root.color = "#eeeeee"
                transcription.visible = true
                type_speech.visible = true
                syns.visible = true
                means.visible = true
            }
        }
    }

    Text {
        id: transcription
        anchors.left: root.left
        anchors.leftMargin: 2
        anchors.top: root.top
        color: "gray"
//        fontSizeMode: Text.Fit
        fontSizeMode: Text.VerticalFit
        minimumPointSize: 5
        font.pointSize: height
        height: blocks_list_view.text_height
    }
    Text {
        id: type_speech
        anchors.left: transcription.right
        anchors.leftMargin: 2
        anchors.top: transcription.top
        anchors.right: root.right
        color: "green"
//        fontSizeMode: Text.Fit
        fontSizeMode: Text.VerticalFit
        minimumPointSize: 5
        font.pointSize: height
        height: blocks_list_view.text_height
    }
    Text {
        id: syns
        anchors.top: transcription.bottom
        anchors.left: transcription.left
        color: "blue"
        width: root.width
//        fontSizeMode: Text.Fit
        fontSizeMode: Text.VerticalFit
        minimumPointSize: 5
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        font.pointSize: height
        height: blocks_list_view.text_height
    }
    Text {
        id: means
        anchors.top: syns.bottom
        anchors.left: syns.left
        color: "red"
//        fontSizeMode: Text.Fit
        fontSizeMode: Text.VerticalFit
        width: root.width
        minimumPointSize: 5
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        font.pointSize: height
        height: blocks_list_view.text_height
    }
    Text {
        id: examples
        visible: false
        anchors.fill: parent
        color: "gray"
        fontSizeMode: Text.Fit
        minimumPointSize: 5
        font.pointSize: blocks_list_view.text_height / 1.5
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
}



























