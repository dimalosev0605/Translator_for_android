import QtQuick 2.9
import QtQuick.Controls 2.4

Item {

    Column {
        anchors.centerIn: parent
        spacing: 10
        Main_menu_btn {
            id: translator_btn
            text: "Translator"
            Component {
                id: translator_page_comp
                Translator_page {
                    id: translator_page
                    Component.onDestruction: print("Destroying translator page.")
                }
            }
            mouse_area.onClicked: stack_view.push(translator_page_comp)
        }
        Main_menu_btn {
            id: my_acc_btn
            text: "My account"
        }
        Main_menu_btn {
            id: my_files_btn
            text: "My files"
        }
        Main_menu_btn {
            id: cloud_btn
            text: "Cloud"
        }
        Main_menu_btn {
            id: exit_btn
            text: "Exit"
            mouse_area.onClicked: Qt.quit()
        }
    }

}
