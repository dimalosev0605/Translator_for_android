import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: search_history_words_list_view.width
    height: (search_history_words_list_view.height - 9 * search_history_words_list_view.spacing) / 10
    border.width: 1
    border.color: "gray"
    color: mouse_area.pressed ? "#cfcfcf" : "white"

    property alias word_and_transcription: word_and_transcription.text
    property alias most_popular_syn: most_popular_syn.text
    property alias date: date.text

    property int text_width: root.width / 3

    MouseArea {
        id: mouse_area
        anchors.fill: parent
        onDoubleClicked: {
            user_input_field.text = search_history_words_data_model.get_word_from_history(index)
            stack_view.pop()
        }
        // swipe code
//        preventStealing: true
//        property real velocity: 0.0
//        property int xStart: 0
//        property int xPrev: 0
//        property bool tracing: false
//        onPressed: {
//            xStart = mouse.x
//            xPrev = mouse.x
//            velocity = 0
//            tracing = true
//            console.log( " pressed  "+xStart)
//            console.log( " pressed  "+xPrev)
//        }
//        onPositionChanged: {
//            if ( !tracing ) return
//            var currVel = (mouse.x-xPrev)
//            velocity = (velocity + currVel)/2.0
//            xPrev = mouse.x
//            if ( velocity > 15 && mouse.x > parent.width*0.2 ) {
//                tracing = false
//                console.log( " positioned  ")
//            }
//        }
//        onReleased: {
//            tracing = false
//            if ( velocity > 15 && mouse.x > parent.width*0.2 ) {
//                // SWIPE DETECTED !! EMIT SIGNAL or DO your action
//                console.log("abcccccccccc")
//            }
//        }
        // end swipe code
    }
//    search_history_words_data_model.remove(index)

    Row {
        anchors.fill: parent
        Text {
            id: word_and_transcription
            width: text_width
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
            width: text_width
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
            width: text_width
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
