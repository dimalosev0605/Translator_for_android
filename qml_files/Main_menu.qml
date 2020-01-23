import QtQuick 2.9
import QtQuick.Controls 2.4
import Settings_qml 1.0

Item {

    Settings {
        id: settings
    }

    Column {
        id: column
        anchors.centerIn: parent
        spacing: 10
        property int button_width: parent.width / 3
        property int button_height: parent.height / 10
        Main_menu_btn {
            id: translator_btn
            text: "Translator"
            width: column.button_width
            height: column.button_height
            mouse_area.onClicked: stack_view.push(translator_page_comp)
            Component {
                id: translator_page_comp
                Translator_page {
                    id: translator_page
                }
            }
        }
        Main_menu_btn {
            id: my_acc_btn
            text: "My account"
            width: column.button_width
            height: column.button_height
            mouse_area.onClicked: stack_view.push(my_account_page_comp)
            Component {
                id: my_account_page_comp
                My_account_page {
                    id: my_account_page
                }
            }
        }
        Main_menu_btn {
            id: my_files_btn
            text: "My files"
            width: column.button_width
            height: column.button_height
            mouse_area.onClicked: stack_view.push(my_files_comp)
            Component {
                id: my_files_comp
                My_files_page {
                    id: my_files_page
                }
            }
        }
        Main_menu_btn {
            id: test_page_btn
            text: "Testing"
            width: column.button_width
            height: column.button_height
            mouse_area.onClicked: stack_view.push(test_page_comp)
            Component {
                id: test_page_comp
                Test_page {
                    id: test_page
                }
            }
        }
        Main_menu_btn {
            id: cloud_btn
            text: "Cloud"
            width: column.button_width
            height: column.button_height
            enabled: settings.is_auth
            mouse_area.onClicked: stack_view.push(cloud_page_comp)
            Component {
                id: cloud_page_comp
                Cloud_page {
                    id: cloud_page
                }
            }
        }
        Main_menu_btn {
            id: exit_btn
            text: "Exit"
            width: column.button_width
            height: column.button_height
            mouse_area.onClicked: Qt.quit()
        }
    }
}
