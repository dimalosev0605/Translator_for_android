import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }
    Text {
        id: header_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        height: back_btn.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        minimumPointSize: 3
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        text: "Searh history"
    }

    Rectangle {
        id: scroll_frame
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
//        border.width: 1
//        border.color: "black"
        ScrollView {
            anchors.fill: parent
            ListView {
                id: search_history_words_list_view
                anchors.fill: parent
                spacing: 10
                clip: true
                model: search_history_words_data_model
                delegate: History_word_delegate {
                    word_and_transcription: String(model.word) + "  " + String(model.transcription)
                    most_popular_syn: String(model.most_popular_syn)
                    date: String(model.date)
                }
            }
        }
    }
}
