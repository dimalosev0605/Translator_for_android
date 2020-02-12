import QtQuick 2.11
import QtQuick.Controls 2.4
import Blocks_data_model_qml 1.0
import Words_data_model_qml 1.0
import Search_history_data_model_qml 1.0

Item {
    id: translator_page
    focus: true

    function clear_fields() {
        user_input_field.clear()
        means_field.clear()
        translations_filed.clear()
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
    Search_history_data_model {
        id: search_history_words_data_model
    }
    Component {
        id: file_dialog_page_comp
        File_dialog_page {
            id: file_dialog_page
        }
    }
    Component {
        id: words_page_comp
        Words_page {
            id: words_page
            interface_flag: 1 // 1 means not 4.
        }
    }
    Component {
        id: langs_page_comp
        Langs_page {
            id: langs_page
        }
    }
    Component {
        id: search_history_page_comp
        Search_history_page {
            id: search_history_page
        }
    }

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            event.accepted = true
            stack_view.pop()
        }
    }

    property int clear_icon_height: 24

    SequentialAnimation {
        id: clear_fields_anim
        ScaleAnimator {
            id: increase_scale_anim
            from: 1
            to: 1.1
            duration: 200
        }
        ScaleAnimator {
            id: decrease_scale_anim
            from: 1.1
            to: 1
            duration: 200
        }
    }

    TextField {
        id: user_input_field
        width: (translator_page.width - anchors.leftMargin * 3) * 0.75 - clear_uif_btn.width
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
        rightPadding: clear_uif_btn.width + clear_uif_btn.anchors.rightMargin * 2
        Image {
            id: clear_uif_btn
            height: clear_icon_height
            width: height
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/icons/clear_icon.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user_input_field.clear()
                    increase_scale_anim.target = clear_uif_btn
                    decrease_scale_anim.target = clear_uif_btn
                    clear_fields_anim.start()
                }
            }
        }
        Keys.onReturnPressed: {
            Qt.inputMethod.hide();
            focus = false
            translator_page.focus = true
            search_history_words_data_model.push_front(user_input_field.text, blocks_data_model.get_transcription(),
                                                       blocks_data_model.get_most_popular_syn())
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
        rightPadding: clear_mf_btn.width + clear_mf_btn.anchors.rightMargin * 2
        Image {
            id: clear_mf_btn
            height: clear_icon_height
            width: height
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/icons/clear_icon.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    means_field.clear()
                    increase_scale_anim.target = clear_mf_btn
                    decrease_scale_anim.target = clear_mf_btn
                    clear_fields_anim.start()
                }
            }
        }
        Keys.onReturnPressed: {
            Qt.inputMethod.hide();
            focus = false
            translator_page.focus = true
        }
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
        rightPadding: clear_tf_btn.width + clear_tf_btn.anchors.rightMargin * 2
        Image {
            id: clear_tf_btn
            height: clear_icon_height
            width: height
            anchors.right: parent.right
            anchors.rightMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/icons/clear_icon.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    translations_filed.clear()
                    increase_scale_anim.target = clear_tf_btn
                    decrease_scale_anim.target = clear_tf_btn
                    clear_fields_anim.start()
                }
            }
        }
        Keys.onReturnPressed: {
            Qt.inputMethod.hide();
            focus = false
            translator_page.focus = true
        }
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
            text: "Add word"
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
                if(user_input_field.text === "") return
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
        width: parent.width * 0.7
        height: parent.height * 0.2 > 30 ? parent.height * 0.2 : 30
        radius: 20

        Slider {
            id: font_size_slider
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            width: slider_frame.width - anchors.leftMargin - anchors.rightMargin -
                   close_font_size_menu_btn.width - close_font_size_menu_btn.anchors.leftMargin
            height: 30
            value: blocks_list_view.text_height
            from: 5
            to: (blocks_list_view.height - blocks_list_view.spacing * 3) / 4 / 3
            stepSize: 1
            onValueChanged: blocks_list_view.text_height = value
            onPressedChanged: pressed ? slider_frame.opacity = 0.1 : slider_frame.opacity = 1
        }
        Image {
            id: close_font_size_menu_btn
            height: 30
            width: 30
            anchors.left: font_size_slider.right
            anchors.leftMargin: 5
            anchors.verticalCenter: font_size_slider.verticalCenter
            source: "qrc:/icons/clear_icon.svg"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    slider_frame.visible = false
                    translator_page.focus = true
                }
            }
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

























