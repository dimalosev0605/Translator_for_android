import QtQuick 2.11
import QtQuick.Controls 2.4
import LocalFilesDataModel_qml 1.0
import Words_data_model_qml 1.0

Item {
    id: root

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
    Words_data_model {
        id: words_data_model
        is_save: false
    }
    Component {
        id: words_page_comp
        Words_page {
            id: words_page
            interface_flag: 2
            Component.onDestruction: print("Destroying words_page.")
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
                    interface_flag: 2
                    file_name: String(model.file_name)
                    modified_date: String(model.modified_date)
                }
            }
        }
    }

    TextField {
        id: file_name_field
        anchors.left: local_files_frame.left
        anchors.top: local_files_frame.bottom
        anchors.topMargin: 5
        width: parent.width / 2
        height: 30
        placeholderText: "File name"
        inputMethodHints: Qt.ImhNoPredictiveText
    }

    Rectangle {
        id: create_btn
        anchors.left: file_name_field.right
        anchors.leftMargin: 10
        anchors.top: file_name_field.top
        width: 70
        height: file_name_field.height
        color: m_area.pressed ? "#00ff00" : "#cfcfcf"
        border.color: "black"
        border.width: 1
        Text {
            text: "Create"
            anchors.centerIn: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
            height: parent.height
            fontSizeMode: Text.Fit
            minimumPointSize: 5
            font.pointSize: 10
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
        }
        MouseArea {
            id: m_area
            anchors.fill: parent
            onClicked: {
                if(file_name_field.text === "") return
                if(local_files_data_model.create_file(file_name_field.text)) {
                    file_name_field.text = ""
                }
            }
        }
    }

}
























