import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root_root
    property alias word_and_transcription: word_and_transcription.text
    property alias most_popular_syn: most_popular_syn.text
    property alias date: date.text

    width: search_history_words_list_view.width
    height: (search_history_words_list_view.height - 9 * search_history_words_list_view.spacing) / 10

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        onDoubleClicked: {
            user_input_field.text = search_history_words_data_model.get_word_from_history(index)
            stack_view.pop()
        }
        property bool f
        onPressed:  {
            if(mouseX > root.width * 0.2) {
                f = false
            }
            else {
                f = true
            }
        }

        preventStealing: true
        onPositionChanged: {
            console.log(mouseX)
            if(!f) return
            if(mouseX < root.width / 2)
                root.visible = true
            else
                root.visible = false
            root.x = mouseX
        }
        onReleased: {
            if(!root.visible) {
                search_history_words_data_model.remove(index)
                console.log("REMOVE")
            }
            else {
                root.x = 0
                root.visible = true
            }
        }

    }

    Rectangle {
        id: root
//        anchors.fill: parent
        width: search_history_words_list_view.width
        height: (search_history_words_list_view.height - 9 * search_history_words_list_view.spacing) / 10
        border.width: 1
        border.color: "gray"
        color: mouse_area.pressed ? "#cfcfcf" : "white"


        property int text_width: root.width / 3


        Row {
            anchors.fill: parent
            Text {
                id: word_and_transcription
                width: root.text_width
                height: root.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
            Text {
                id: most_popular_syn
                width: root.text_width
                height: root.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
            Text {
                id: date
                width: root.text_width
                height: root.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
    }

}

