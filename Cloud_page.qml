import QtQuick 2.11
import QtQuick.Controls 2.4
import LocalFilesDataModel_qml 1.0
import RemoteFilesDataModel_qml 1.0
import Client_qml 1.0

Item {
    id:  cloud_page

    Client {
        id: client
        onInternal_server_error: {
            // TODO
        }
        onList_of_files: {
            //Success uploading (or success deleting) need update padding of remote files model
            remote_files_model.receive_list_of_files(list)
            pulsing_anim.stop()
            busy_indicator.visible = false
            info_lbl.visible = false
        }
        onConnected_to_server: {
            pulsing_anim.stop()
            busy_indicator.visible = false
            info_lbl.visible = false
        }
        onServer_refused_connection: {
            pulsing_anim.stop()
            busy_indicator.visible = false
            info_lbl.text = "Connection to server was refused. Try later."
            info_lbl.visible = true
        }
        onSuccess_downloading: {
            pulsing_anim.stop()
            busy_indicator.visible = false
            local_files_model.update_data()
        }
        onUnsuccess_downloading: {
            // TODO
//            busy_indicator.visible = false
//            busy_indicator.running = false
//            info_lbl.text = "unsuccessful loading."
        }
    }

    LocalFilesDataModel {
        id: local_files_model
    }
    RemoteFilesDataModel {
        id: remote_files_model
    }

    BusyIndicator {
        id: busy_indicator
        running: true
        anchors.centerIn: remote_files_rect
        visible: true
        z: 3
    }
    Label {
        id: info_lbl
        text: "Connecting to server..."
        z: 3
        anchors.horizontalCenter: busy_indicator.horizontalCenter
        anchors.top: busy_indicator.bottom
        height: 40
        width: 200
        fontSizeMode: Text.Fit
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        minimumPointSize: 5
        font.pointSize: 12
        SequentialAnimation {
            id: pulsing_anim
            loops: Animation.Infinite
            running: true
            OpacityAnimator {
                target: info_lbl
                from: 1
                to: 0
                duration: 2000
            }
            OpacityAnimator {
                target: info_lbl
                from: 0
                to: 1
                duration: 2000
            }
        }
    }

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
    }
    Label {
        id: local_files_lbl
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        minimumPointSize: 5
        font.pointSize: 10
        text: "Local files"
    }
    Rectangle {
        id: local_files_frame
        anchors.left: back_btn.left
        anchors.top: local_files_lbl.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        height: (parent.height - back_btn.height - back_btn.anchors.topMargin - local_files_lbl.height -
                 local_files_lbl.anchors.topMargin - anchors.topMargin - remote_files_lbl.height -
                 remote_files_lbl.anchors.topMargin - remote_files_rect.anchors.bottomMargin) / 2
        border.width: 1
        border.color: "#000000"
    }
    Label {
        id: remote_files_lbl
        anchors.top: local_files_frame.bottom
        anchors.topMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        minimumPointSize: 5
        font.pointSize: 10
        text: "Remote files"
    }
    Rectangle {
        id: remote_files_rect
        anchors.top: remote_files_lbl.bottom
        anchors.topMargin: 5
        anchors.left: back_btn.left
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        border.width: 1
        border.color: "#000000"
    }

    ScrollView {
        id: local_files_scroll_view
        anchors.fill: local_files_frame
        ListView {
            id: local_files_list_view
            anchors.fill: parent
            clip: true
            spacing: 5
            model: local_files_model
            delegate: Local_file_delegate {
                interface_flag: 3
                file_name: String(model.file_name)
                modified_date: String(model.modified_date)
            }
        }
    }
    ScrollView {
        id: remote_files_scroll_view
        anchors.fill: remote_files_rect
        ListView {
            id: remote_files_list_view
            anchors.fill: parent
            clip: true
            spacing: 5
            model: remote_files_model
            delegate: Remote_file_delegate {
                file_name: String(model.file_name)
                modified_date: String(model.modified_date)
            }
        }
    }

}





























