import QtQuick 2.11
import QtQuick.Controls 2.4
import Blocks_data_model_qml 1.0
import Words_data_model_qml 1.0

Item {
    id: translator_page

    function clear_fields() {
        user_input_field.text = ""
        means_field.text = ""
        translations_filed.text = ""
    }

    Translator_menu_bar {
        id: menu_bar
    }
    Blocks_data_model {
        id: blocks_data_model
    }
    Words_data_model {
        id: words_data_model
    }
    Component {
        id: file_dialog_page_comp
        File_dialog_page {
            id: file_dialog_page
            Component.onDestruction: print("Destroying file_dialog page.")
        }
    }
    Component {
        id: words_page_comp
        Words_page {
            id: words_page
            Component.onDestruction: print("Destroying words_page.")
        }
    }
    Component {
        id: langs_page_comp
        Langs_page {
            id: langs_page
            Component.onDestruction: print("Destroying langs_page.")
        }
    }
    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            console.log("POP BACK")
            event.accepted = true
            stack_view.pop()
        }
    }

    TextField {
        id: user_input_field
        width: (translator_page.width - anchors.leftMargin * 3) * 0.75
        height: 30
        anchors.top: menu_bar.bottom
        anchors.left: menu_bar.left
        anchors.topMargin: 5
        anchors.leftMargin: 5
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: "Input text"
        onTextChanged: {
            blocks_data_model.on_input_changed(user_input_field.text)
        }
        Keys.onReturnPressed: {
            console.log("VIRTUAL_KEY_BOARD_RETURN")
            Qt.inputMethod.hide();
            focus = false
            translator_page.focus = true
        }
    }
    TextField {
        id: means_field
        width: user_input_field.width
        height: user_input_field.height
        anchors.top: user_input_field.bottom
        anchors.topMargin: 5
        anchors.left: user_input_field.left
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: "Input means"
        visible: false
    }
    TextField {
        id: translations_filed
        width: user_input_field.width
        height: user_input_field.height
        anchors.top: means_field.bottom
        anchors.topMargin: 5
        anchors.left: means_field.left
        inputMethodHints: Qt.ImhNoPredictiveText
        placeholderText: "Input translations"
        visible: means_field
    }

    Rectangle {
        id: show_hide_line_edits_btn
        visible: false
        anchors.top: user_input_field.top
        anchors.left: user_input_field.right
        anchors.leftMargin: 5
        height: user_input_field.height
        width: 60
        color: shle_btn_m_area.pressed ? "#00ff00" : "#cfcfcf"
        Text {
            text: means_field.visible ? "Hide" : "Expand"
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 3
            font.pointSize: 10
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
        }
        MouseArea {
            id: shle_btn_m_area
            anchors.fill: parent
            onClicked: {
                if(means_field.visible) {
                    means_field.visible = false
                    blocks_scroll_view_frame.anchors.top = user_input_field.bottom
                }
                else {
                    means_field.visible = true
                    blocks_scroll_view_frame.anchors.top = translations_filed.bottom
                }
            }
        }
    }
    Rectangle {
        id: add_word_btn
        visible: show_hide_line_edits_btn.visible
        anchors.left: means_field.right
        anchors.leftMargin: 5
        anchors.top: means_field.top
        width: show_hide_line_edits_btn.width
        height: means_field.height
        color: add_word_btn_m_area.pressed ? "#00ff00" : "#cfcfcf"
        Text {
            text: "Add"
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 3
            font.pointSize: 10
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
        }
        MouseArea {
            id: add_word_btn_m_area
            anchors.fill: parent
            onClicked: {
                words_data_model.add_word(user_input_field.text, blocks_data_model.get_transcription(),
                                          means_field.text, translations_filed.text)
                clear_fields()
                user_input_field.focus = true
            }
        }
    }

    Rectangle {
        id: slider_frame
        anchors.centerIn: parent
        visible: false
        z: 3
        border.width: 1
        border.color: "black"
        width: 300
        height: 90
        radius: 20
        Slider {
            id: font_size_slider
            anchors.centerIn: parent
            value: blocks_list_view.text_height
            from: 5
            to: (blocks_list_view.height - blocks_list_view.spacing * 3) / 4 / 3
            stepSize: 1
            onValueChanged: blocks_list_view.text_height = value
        }
    }

    Rectangle {
        id: blocks_scroll_view_frame
        border.width: 1
        border.color: "black"
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: user_input_field.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        ScrollView {
            anchors.fill: parent
            ListView {
                id: blocks_list_view
                anchors.fill: parent
                spacing: 10
                clip: true
                model: blocks_data_model
                property int text_height: 20
                delegate: Block_delegate {
                    transcription: String(model.transcription)
                    type_speech: String(model.type_speech)
                    syns: String(model.syns)
                    means: String(model.means)
                    examples: String(model.exaples)
                }
            }
        }
    }

}

























