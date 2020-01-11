import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    width: local_files_list_view.width
    height: 30

    property alias file_name: file_name_text.text
    property alias modified_date: modified_date_text.text

    // 1 - interface in translator_page -> file_dialog
    // 2 - interface in my_files_page
    // 3 - interface in cloud_page
    // 4 - interface in test_page
    property int interface_flag: 1

    Row {
        id: row
        anchors.fill: parent
        Rectangle {
            id: idx_frame
            border.width: 1
            border.color: "black"
            height: root.height
            width: 30
            Text {
                id: idx
                text: index + 1
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
        }
        Rectangle {
            id: file_name_frame
            border.width: 1
            border.color: "black"
            height: root.height
            width: (root.width - idx_frame.width - open_btn.width - delete_btn.width) / 2
            Text {
                id: file_name_text
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
        }
        Rectangle {
            id: modified_date_rect
            border.width: 1
            border.color: "black"
            height: root.height
            width: file_name_frame.width
            Text {
                id: modified_date_text
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
        }
        Rectangle {
            id: open_btn
            border.width: 1
            border.color: "black"
            height: root.height
            width: 45
            color: open_btn_m_area.pressed ? "#00ff00" : "white"
            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 10
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: interface_flag === 3 ? "Upload" : "Open"
            }
            MouseArea {
                id: open_btn_m_area
                anchors.fill: parent
                onClicked: {
                    if(interface_flag === 1) {
                        show_hide_line_edits_btn.visible = true
                        menu_bar.open_menu_item.enabled = false
                        menu_bar.save_menu_item.enabled = true
                        menu_bar.show_words_item.enabled = true
                        words_data_model.set_file_name(local_files_data_model.get_file_name(index))
                        words_data_model.open_file()
                        stack_view.pop()
                    }
                    if(interface_flag === 2) {
                        words_data_model.set_file_name(local_files_data_model.get_file_name(index))
                        words_data_model.open_file()
                        stack_view.push(words_page_comp)
                    }
                    if(interface_flag === 3) {
                        if(busy_indicator.visible) return
                        if(client.upload_file(local_files_model.get_file_name(index))) {
                            info_lbl.text = "Uploading..."
                            info_lbl.visible = true
                            busy_indicator.visible = true
                            pulsing_anim.start()
                        }
                    }
                    if(interface_flag === 4) {
                        if(test_words.open_file(local_files_data_model.get_file_name(index))) {
                            words_data_model.set_file_name(local_files_data_model.get_file_name(index))
                            words_data_model.open_file()
                            stack_view.push(words_page_comp)
                        }
                    }
                }
            }
        }
        Rectangle {
            id: delete_btn
            border.width: 1
            border.color: "black"
            height: root.height
            width: open_btn.width
            color: enabled ? delete_btn_m_area.pressed ? "#ff0000" : "white" : "#cfcfcf"
            enabled: interface_flag === 2 ? true : false
            Text {
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
                height: parent.height
                fontSizeMode: Text.Fit
                minimumPointSize: 3
                font.pointSize: 10
                elide: Text.ElideRight
                wrapMode: Text.WordWrap
                text: "Delete"
            }
            MouseArea {
                id: delete_btn_m_area
                anchors.fill: parent
                onClicked: {
                    if(interface_flag !== 2) return
                    // delete only if interface_flag == 2.
                    local_files_data_model.delete_file(index)
                }
            }
        }
    }

}
















