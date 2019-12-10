import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    width: translator_page.width
    height: 30

    Row {
        anchors.fill: parent
        spacing: 5
        Back_btn {
            id: back_btn
        }
        Menu_bar_item {
            img.source: "my_files_icon.svg"
            mouse_area.onClicked: file_menu.open()
            Menu {
                id: file_menu
                y: parent.height
                width: 100
                property int items_count: 2
                height: items_count * 30
                Menu_item {
                    text: "Open"
                    mouse_area.onClicked: {
                        file_menu.close()
                    }
                }
                Menu_item {
                    text: "Save"
                    mouse_area.onClicked: {
                        file_menu.close()
                    }
                }
            }
        }
        Menu_bar_item {
            img.source: "settings_btn_icon.svg"
            mouse_area.onClicked: options_menu.open()
            Menu {
                id: options_menu
                y: parent.height
                width: 100
                property int items_count: 2
                height: items_count * 30
                Menu_item {
                    text: "Langs"
                    mouse_area.onClicked: {
                        options_menu.close()
                    }
                }
                Menu_item {
                    text: "Font size"
                    mouse_area.onClicked: {
                        options_menu.close()
                        slider_frame.visible ? slider_frame.visible = false : slider_frame.visible = true
                    }
                }
            }
        }
    }

}











