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

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.25
        spacing: 10
        ComboBox {
            id: from_lang
            model: ["en", "ru", "es", "fr", "de"]
            displayText: blocks_data_model.get_from_lang()
            onActivated: {
                blocks_data_model.change_from_lang(currentText)
                displayText = blocks_data_model.get_from_lang()
                menu_bar.langs_menu_item.text = blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
            }
        }
        ComboBox {
            id: on_lang
            model: ["en", "ru", "es", "fr", "de"]
            displayText: blocks_data_model.get_on_lang()
            onActivated: {
                blocks_data_model.change_on_lang(currentText)
                displayText = blocks_data_model.get_on_lang()
                menu_bar.langs_menu_item.text = blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
            }
        }
    }

}






















