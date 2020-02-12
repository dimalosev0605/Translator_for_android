import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: words_page

    property int interface_flag
    property alias start_btn_text: start_btn_text
    // 4 - interface for test page, any other number - for my_files_page or translator_page.

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
    }

    Menu_bar_item {
        id: options_btn
        anchors.left: back_btn.right
        anchors.leftMargin: 5
        anchors.top: back_btn.top
        img.source: "qrc:/icons/settings_btn_icon.svg"
        RotationAnimation {
            id: rotation_anim
            target: options_btn.img
            duration: 1000
            from: 0
            to: 360
        }
        mouse_area.onClicked: {
            rotation_anim.start()
            if(!options_field.visible) {
                options_field.visible = true
                scroll_view.anchors.top = options_field.bottom
            }
            else {
                options_field.visible = false
                scroll_view.anchors.top = back_btn.bottom
            }
        }
    }
    Text {
        id: info_lbl
        text: "Choose words for testing"
        visible: interface_flag === 4 ? true : false
        anchors.left: options_btn.right
        anchors.top: options_btn.top
        anchors.right: start_btn.left
        height: options_btn.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        minimumPointSize: 5
        font.pointSize: 10
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }

    Rectangle {
        id: options_field
        visible: false
        border.width: 1
        border.color: "black"
        anchors.left: back_btn.left
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.right: words_page.right
        anchors.rightMargin: 5
        height: find_text_field.height + find_text_field.anchors.topMargin + next_occur_btn.height + next_occur_btn.anchors.topMargin + 5
        + show_hide_date_column_btn.height + show_hide_date_column_btn.anchors.bottomMargin

        TextField {
            id: find_text_field
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            width: options_field.width * 0.4
            height: 30
            inputMethodHints: Qt.ImhNoPredictiveText
            placeholderText: "Search"
            property int word_orrences_count: 0
            onTextChanged: {
                word_orrences_count = words_data_model.find_word(find_text_field.text)
                info_about_searching.curr_idx = words_data_model.get_curr_index()
                if(words_data_model.get_first_occurence_index() === -1) {
                    if(words_list_view.currentIndex !== -1) {
                        words_list_view.currentItem.focus = false
                        words_list_view.currentIndex = -1
                    }
                }
                else {
                    words_list_view.currentIndex = words_data_model.get_first_occurence_index()
                }
            }
            Keys.onReturnPressed: {
                Qt.inputMethod.hide();
                focus = false
            }
        }
        Text {
            id: font_size_slider_text
            anchors.left: find_text_field.right
            anchors.leftMargin: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            height: 30
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            minimumPointSize: 3
            font.pointSize: 12
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            text: "Font size: " + font_size_slider.value
        }
        Slider {
            id: font_size_slider
            anchors.left: font_size_slider_text.left
            anchors.top: font_size_slider_text.bottom
            anchors.right: font_size_slider_text.right
            height: 30
            from: 5
            to: 20
            value: 15
            stepSize: 1
        }

        Text {
            id: info_about_searching
            anchors.left: find_text_field.left
            anchors.top: find_text_field.bottom
            anchors.topMargin: 3
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            minimumPointSize: 3
            font.pointSize: 12
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            width: prev_occur_btn.x - find_text_field.x
            height: 30
            property int curr_idx: words_data_model.get_curr_index()
            text: find_text_field.word_orrences_count !== 0 ? curr_idx + "/" + find_text_field.word_orrences_count : "Not found"
        }
        Rectangle {
            id: next_occur_btn
            height: 30
            width: 30
            anchors.right: find_text_field.right
            anchors.top: find_text_field.bottom
            anchors.topMargin: 5
            color: next_occur_btn_m_area.pressed ? "#00ff00" : "white"
            border.width: 1
            border.color: "black"
            Image {
                anchors.fill: parent
                source: "qrc:/icons/next_arr.svg"
            }
            MouseArea {
                id: next_occur_btn_m_area
                anchors.fill: parent
                onClicked: {
                    if(find_text_field.word_orrences_count === 0) return;
                    words_list_view.currentIndex = words_data_model.increase_word_occur_index()
                    info_about_searching.curr_idx = words_data_model.get_curr_index()
                }
            }
        }
        Rectangle {
            id: prev_occur_btn
            height: next_occur_btn.height
            width: next_occur_btn.width
            anchors.right: next_occur_btn.left
            anchors.rightMargin: 5
            anchors.top: next_occur_btn.top
            color: prev_occur_btn_m_area.pressed ? "#00ff00" : "white"
            border.width: 1
            border.color: "black"
            Image {
                anchors.fill: parent
                source: "qrc:/icons/previous_arr.svg"
            }
            MouseArea {
                id: prev_occur_btn_m_area
                anchors.fill: parent
                onClicked: {
                    if(find_text_field.word_orrences_count === 0) return;
                    words_list_view.currentIndex = words_data_model.decrease_word_occur_index()
                    info_about_searching.curr_idx = words_data_model.get_curr_index()
                }
            }
        }

        Rectangle {
            id: show_hide_date_column_btn
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            border.color: "black"
            border.width: 1
            height: 30
            width: 100
            color: show_hide_date_column_btn_m_area.pressed ? "#00ff00" : "white"
            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 12
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: words_list_view.is_date_visible ? "Hide date" : "Show date"
            }

            MouseArea {
                id: show_hide_date_column_btn_m_area
                anchors.fill: parent
                onClicked: {
                    if(words_list_view.column_count === 4) {
                        --words_list_view.column_count
                        words_list_view.is_date_visible = false
                    }
                    else {
                        ++words_list_view.column_count
                        words_list_view.is_date_visible = true
                    }
                }
            }
        }

    }

    Rectangle {
        // item visible only if interface == 4.
        id: start_btn
        visible: interface_flag === 4 ? true : false
        color: mouse_area.pressed ? "#00ff00" : "white"
        border.width: 1
        border.color: "black"
        width: words_page.width * 0.3
        height: back_btn.height
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        Text {
            id: start_btn_text
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 5
            font.pointSize: 15
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            color: mouse_area.pressed ? "#000000" : count < 4 ? "#ff0000" : "#00ff00"
            property string default_text: "Start"
            property int count: interface_flag === 4 ? test_words.get_words_count() : 0
            text : default_text + count
        }
        MouseArea {
            id: mouse_area
            anchors.fill: parent
            onClicked: {
                if(start_btn_text.count < 4) return
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
        id: scroll_view
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
            highlightMoveVelocity: 1600
            clip: true
            currentIndex: -1
            property int column_count: 4
            property bool is_date_visible: true
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























