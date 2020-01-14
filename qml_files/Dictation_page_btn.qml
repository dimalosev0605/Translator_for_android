import QtQuick 2.9
import QtQuick.Controls 2.4

Rectangle {
    id: root

    property alias text: text.text
    property alias mouse_area: mouse_area
    property int idx

    border.width: 1
    border.color: "black"
    color: mouse_area.pressed ? "#00ff00" : "white"
    width: dictation_page.width / 2
    height: 40
    Text {
        id: text
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
    }
    MouseArea {
        id: mouse_area
        anchors.fill: parent
        onClicked: {
            if(test_words.get_ran() === idx) {
                if(test_words.get_checked())
                    test_words.rand_generator_2()
                else
                    test_words.rand_generator()
                b_0.text = test_words.get(0)
                b_1.text = test_words.get(1)
                b_2.text = test_words.get(2)
                b_3.text = test_words.get(3)
                qstn_text.text = test_words.get_qstn()
                right_answ.score++;
                miss_answ.flag = true
            }
            else {
                if(miss_answ.flag) {
                    miss_answ.flag = false
                    miss_answ.score++;
                }
            }
        }
    }
}















