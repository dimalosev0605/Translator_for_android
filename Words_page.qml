import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: words_page

    property int interface_flag

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
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























