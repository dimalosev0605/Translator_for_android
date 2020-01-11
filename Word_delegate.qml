import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: words_list_view.width
    height: (words_list_view.height - 9 * words_list_view.spacing) / 10
    border.width: 1
    border.color: "black"

    property alias word_and_transcription: word_and_transcripton.text
    property alias means: means.text
    property alias syns: syns.text
    property alias date: date.text

    // 1 - interface in translator_page
    // 2 - in my_files_page
    // 4 - in test_page
    property int interface_flag

    color: interface_flag === 4 ? test_words.get_idx(index) ? "#00ff00" : "white" : "white"
    MouseArea {
        anchors.fill: parent
        visible: interface_flag === 4 ? true : false
        onClicked: {
//            console.log("index = " + index)
            // if user choose all words by hand -> pizda...
            if(test_words.set_idx(index)) {
                if(test_words.get_words_count() === words_page.words_count.count)
                    words_page.words_count.count = 0
                ++words_page.words_count.count;
            }
            else {
                --words_page.words_count.count;
                if(words_page.words_count.count === 0)
                    words_page.words_count.count = test_words.get_words_count()
            }
            color = test_words.get_idx(index) ? "#00ff00" : "white"
        }
    }

    Row  {
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: 30
            color: m_area.pressed ? "red" : "White"
            Text {
                id: idx
                text: index + 1
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 15
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
            MouseArea {
                id: m_area
                anchors.fill: parent
                onClicked: {
                    if(root.interface_flag === 1) {
                        words_data_model.remove_word(index)
                    }
                }
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width)/ 4
            color: root.color
            Text {
                id: word_and_transcripton
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 15
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width)/ 4
            color: root.color
            Text {
                id: means
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 15
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width)/ 4
            color: root.color
            Text {
                id: syns
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 15
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width) / 4
            color: root.color
            Text {
                id: date
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 13
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
    }

}
