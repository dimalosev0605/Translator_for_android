import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: words_page

    property int interface_flag
    // 4 - interface for test page

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
    }
    Rectangle {
        // if interface == 4
        id: start_btn
        visible: interface_flag === 4 ? true : false
        color: mouse_area.pressed ? "#00ff00" : "white"
        border.width: 1
        border.color: "black"
        width: 60
        height: back_btn.height
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        Text {
            id: text
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 5
            font.pointSize: 10
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            text: "Start"
        }
        MouseArea {
            id: mouse_area
            anchors.fill: parent
            onClicked: {
                if(test_words.get_checked()) {
                    test_words.prepare()
                    test_words.rand_generator_2()
                }
                else {
                    test_words.rand_generator()
                }
                stack_view.push(dictation_page_comp)
            }
        }
    }

    ScrollView {
        anchors.left: back_btn.left
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.right: words_page.right
        anchors.rightMargin: 5
        anchors.bottom: words_page.bottom
        anchors.bottomMargin: 5
        ListView {
            id: words_list_view
            anchors.fill: parent
            spacing: 5
            model: words_data_model
            clip: true
            delegate: Word_delegate {
                interface_flag: words_page.interface_flag
                word_and_transcription: String(model.word + '\n' + model.transcription)
                means: String(model.means)
                syns: String(model.syns)
                date: String(model.date)
            }
        }
    }

}























