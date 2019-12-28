import QtQuick 2.9
import QtQuick.Controls 2.4
import LocalFilesDataModel_qml 1.0
import Test_words_qml 1.0
import Words_data_model_qml 1.0

Item {
    id: test_page

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }
    LocalFilesDataModel {
        id: local_files_data_model
    }
    Test_words {
        id: test_words
    }
    Component {
        id: dictation_page_comp
        Dictation_page {
            id: dictation_page
            Component.onDestruction: print("Destroying dictation page.")
        }
    }
    Words_data_model {
        id: words_data_model
    }
    Component {
        id: words_page_comp
        Words_page {
            id: words_page
            interface_flag: 4
        }
    }
    Rectangle {
        id: local_files_frame
        anchors.left: back_btn.left
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        border.width: 1
        border.color: "black"
        height: parent.height / 2 - back_btn.height - back_btn.anchors.topMargin - anchors.topMargin
        ScrollView {
            anchors.fill: local_files_frame
            ListView {
                id: local_files_list_view
                anchors.fill: parent
                model: local_files_data_model
                spacing: 5
                clip: true
                delegate: Local_file_delegate {
                    interface_flag: 4
                    file_name: String(model.file_name)
                    modified_date: String(model.modified_date)
                }
            }
        }
    }
}

























