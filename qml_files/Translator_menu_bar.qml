import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: translator_menu_bar
    width: translator_page.width
    height: 30

    property alias open_menu_item: open_menu_item
    property alias save_menu_item: save_menu_item
    property alias show_words_item: show_words_item
    property alias file_menu: file_menu
    property alias langs_menu_item: langs_menu_item

    property int menu_item_height: 30
    property int menu_item_width: 100

    Row {
        anchors.fill: parent
        spacing: 5
        Back_btn {
            id: back_btn
        }
        Menu_bar_item {
            img.source: "qrc:/icons/my_files_icon.svg"
            mouse_area.onClicked: file_menu.open()
            Menu {
                id: file_menu
                y: parent.height
                width: menu_item_width
                property int items_count: 3
                height: items_count * menu_item_height
                Menu_item {
                    id: open_menu_item
                    text: "Open file"
                    mouse_area.onClicked: {
                        file_menu.close()
                        stack_view.push(file_dialog_page_comp)
                    }
                }
                Menu_item {
                    id: save_menu_item
                    text: "Save file"
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
                    text: "Show file"
                    enabled: false
                    mouse_area.onClicked: {
                        file_menu.close()
                        stack_view.push(words_page_comp);
                    }
                }
            }
        }
        Menu_bar_item {
            id: settings_menu_bar_item
            img.source: "qrc:/icons/settings_btn_icon.svg"
            mouse_area.onClicked: {
                rotation_anim.start()
                options_menu.open()
            }
            RotationAnimation {
                id: rotation_anim
                target: settings_menu_bar_item.img
                duration: 1000
                from: 0
                to: 360
            }
            Menu {
                id: options_menu
                y: parent.height
                width: menu_item_width
                property int items_count: 3
                height: items_count * menu_item_height
                Menu_item {
                    id: langs_menu_item
                    text: blocks_data_model.get_from_lang() + " - " + blocks_data_model.get_on_lang()
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
                Menu_item {
                    id: search_history_item
                    text: "History"
                    mouse_area.onClicked: {
                        options_menu.close()
                        stack_view.push(search_history_page_comp)
                    }
                }
            }
        }
    }

}











