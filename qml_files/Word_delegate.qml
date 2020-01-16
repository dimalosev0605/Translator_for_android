import QtQuick 2.11
import QtQuick.Controls 2.4

Rectangle {
    id: root
    width: words_list_view.width
    height: (words_list_view.height - 9 * words_list_view.spacing) / 10
    border.width: 1
    border.color: "black"

    onFocusChanged: {
        if(focus) {
            root.color = "yellow"
        }
        else {
            if(interface_flag === 4) {
                if(test_words.get_idx(index))
                    root.color = "#00ff00"
                else
                    root.color = "white"
                color: interface_flag === 4 ? test_words.get_idx(index) ? "#00ff00" : "white" : "white"
            }
            else {
                root.color = "white"
            }
        }
    }

    property alias word_and_transcription: word_and_transcripton.text
    property alias means: means.text
    property alias syns: syns.text
    property alias date: date.text

    // 1 - interface in translator_page
    // 2 - in my_files_page
    // 4 - in test_page
    property int interface_flag
    property int font_size: font_size_slider.value

    color: interface_flag === 4 ? test_words.get_idx(index) ? "#00ff00" : "white" : "white"
    MouseArea {
        anchors.fill: parent
        visible: interface_flag === 4 ? true : false
        onClicked: {
//            console.log("index = " + index)
            // if user choose all words by hand -> pizda...
            if(test_words.set_idx(index)) {
                if(test_words.get_words_count() === words_page.start_btn_text.count)
                    words_page.start_btn_text.count = 0
                ++words_page.start_btn_text.count;
            }
            else {
                --words_page.start_btn_text.count;
                if(words_page.start_btn_text.count === 0)
                    words_page.start_btn_text.count = test_words.get_words_count()
            }
            color = test_words.get_idx(index) ? "#00ff00" : "white"
        }
    }

    Row  {
        Rectangle {
            id: idx_rect
            border.width: 1
            border.color: "black"
            height: root.height
            width: 30
            color: m_area.pressed ? "red" : "white"
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
            width: (root.width - idx.width) / words_list_view.column_count
            color: root.color
            Text {
                id: word_and_transcripton
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: font_size
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width) / words_list_view.column_count
            color: root.color
            Text {
                id: means
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: font_size
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width) / words_list_view.column_count
            color: root.color
            Text {
                id: syns
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: font_size
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
        Rectangle {
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx.width) / words_list_view.column_count
            color: root.color
            visible: words_list_view.is_date_visible
            Text {
                id: date
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: font_size
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
            }
        }
    }

}
