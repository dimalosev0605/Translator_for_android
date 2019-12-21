import QtQuick 2.9
import QtQuick.Controls 2.4

Item {
    id: dictation_page

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }

    Rectangle {
        id: qstn_rect
        width: parent.width / 2
        anchors.bottom: col.top
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        height: 40
//        border.width: 1
//        border.color: "black"
        Text {
            id: qstn_text
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 5
            font.pointSize: 13
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            text: test_words.get_qstn()
        }
    }
    Column {
        id: col
        anchors.centerIn: parent
        spacing: 10
        Dictation_page_btn {
            id: b_0
            text: test_words.get(0)
            idx: 0
        }
        Dictation_page_btn {
            id: b_1
            text: test_words.get(1)
            idx: 1
        }
        Dictation_page_btn {
            id: b_2
            text: test_words.get(2)
            idx: 2
        }
        Dictation_page_btn {
            id: b_3
            text: test_words.get(3)
            idx: 3
        }
    }
    Text {
        id: right_answ
        property int score: 0
        anchors.left: col.left
        anchors.top: col.bottom
        anchors.topMargin: 5
        color: "#00ff00"
        text: score
    }
    Text {
        id: miss_answ
        property int score: 0
        property bool flag: true
        anchors.right: col.right
        anchors.top: col.bottom
        anchors.topMargin: 5
        color: "#ff0000"
        text: score
    }
}




























