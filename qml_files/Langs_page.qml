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
        id: info_lbl
        text: "Choose direction of translation"
        anchors.bottom: row.top
        anchors.bottomMargin: 5
        anchors.left: row.left
        anchors.right: row.right
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        width: row.width
        height: 30
        fontSizeMode: Text.Fit
        minimumPointSize: 3
        font.pointSize: 10
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
    }
    Row {
        id: row
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.25
        spacing: 2
        ComboBox {
            id: from_lang
            model: ["en", "ru", "es", "fr", "de"]
            displayText: blocks_data_model.get_from_lang()
            currentIndex: -1
            height: 35
            onActivated: {
                displayText = currentText
                blocks_data_model.change_from_lang(displayText)
                menu_bar.langs_menu_item.text = blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
            }
        }
        Rectangle {
            color: m_area.pressed ? "#cfcfcf" : "white"
            width: 35
            height: 35
            Image {
                id: bidirectional_arr
                anchors.fill: parent
                source: "qrc:/icons/bidirectional_arrow.svg"
                property string swap_str;
                MouseArea {
                    id: m_area
                    anchors.fill: parent
                    onClicked: {
                        bidirectional_arr.swap_str = from_lang.displayText
                        from_lang.displayText = on_lang.displayText
                        on_lang.displayText = bidirectional_arr.swap_str
                        blocks_data_model.change_from_lang(from_lang.displayText)
                        blocks_data_model.change_on_lang(on_lang.displayText)
                        menu_bar.langs_menu_item.text = blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
                    }
                }
            }
        }
        ComboBox {
            id: on_lang
            model: ["en", "ru", "es", "fr", "de"]
            displayText: blocks_data_model.get_on_lang()
            currentIndex: -1
            height: 35
            width: from_lang.width
            onActivated: {
                displayText = currentText
                blocks_data_model.change_on_lang(displayText)
                menu_bar.langs_menu_item.text = blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
            }
        }
    }

}






















