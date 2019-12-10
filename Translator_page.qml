import QtQuick 2.11
import QtQuick.Controls 2.4
import Blocks_data_model_qml 1.0

Item {
    id: translator_page

    Translator_menu_bar {
        id: menu_bar
    }

    Blocks_data_model {
        id: blocks_data_model
    }
    onHeightChanged: {
        console.log("Height = " + height)
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
        width: translator_page.width * 0.75
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
        visible: false
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
            to: 40
            stepSize: 1
            onValueChanged: {
                if(value >= blocks_list_view.height / 4) return
                blocks_list_view.text_height = value
                console.log("VALUE = " + value)
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

























