import QtQuick 2.9
import QtQuick.Controls 2.4
import Settings_qml 1.0

Item {

    Settings {
        id: settings
    }

    Column {
        anchors.centerIn: parent
        spacing: 10
        Main_menu_btn {
            id: translator_btn
            text: "Translator"
            mouse_area.onClicked: stack_view.push(translator_page_comp)
            Component {
                id: translator_page_comp
                Translator_page {
                    id: translator_page
                    Component.onDestruction: print("Destroying translator page.")
                }
            }
        }
        Main_menu_btn {
            id: my_acc_btn
            text: "My account"
            mouse_area.onClicked: stack_view.push(my_account_page_comp)
            Component {
                id: my_account_page_comp
                My_account_page {
                    id: my_account_page
                    Component.onDestruction: print("Destroying my account page.")
                }
            }
        }
        Main_menu_btn {
            id: my_files_btn
            text: "My files"
            mouse_area.onClicked: stack_view.push(my_files_comp)
            Component {
                id: my_files_comp
                My_files_page {
                    id: my_files_page
                    Component.onDestruction: print("Destroying my files page.")
                }
            }
        }
        Main_menu_btn {
            id: cloud_btn
            text: "Cloud"
            enabled: settings.is_auth
            mouse_area.onClicked: stack_view.push(cloud_page_comp)
            Component {
                id: cloud_page_comp
                Cloud_page {
                    id: cloud_page
                    Component.onDestruction: print("Destroying cloud page.")
                }
            }
        }
        Main_menu_btn {
            id: exit_btn
            text: "Exit"
            mouse_area.onClicked: Qt.quit()
        }
    }

}
