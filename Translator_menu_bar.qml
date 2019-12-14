import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    width: translator_page.width
    height: 30

    property alias open_menu_item: open_menu_item
    property alias save_menu_item: save_menu_item
    property alias show_words_item: show_words_item
    property alias file_menu: file_menu

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
                property int items_count: 3
                height: items_count * 30
                Menu_item {
                    id: open_menu_item
                    text: "Open"
                    mouse_area.onClicked: {
                        file_menu.close()
                        stack_view.push(file_dialog_page_comp)
                    }
                }
                Menu_item {
                    id: save_menu_item
                    text: "Save"
                    enabled: false
                    mouse_area.onClicked: {
                        if(words_data_model.save_words_and_clear_internal_padding()) {
                            menu_bar.open_menu_item.enabled = true
                            menu_bar.save_menu_item.enabled = false
                            menu_bar.show_words_item.enabled = false

                            show_hide_line_edits_btn.visible = false
                            means_field.visible = false
                            blocks_scroll_view_frame.anchors.top = user_input_field.bottom
                        }
                        file_menu.close()
                    }
                }
                Menu_item {
                    id: show_words_item
                    text: "Show words"
                    enabled: false
                    mouse_area.onClicked: {
                        file_menu.close()
                        stack_view.push(words_page_comp);
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
                        stack_view.push(langs_page_comp)
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











