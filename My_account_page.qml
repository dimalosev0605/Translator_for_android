import QtQuick 2.11
import QtQuick.Controls 2.4
import Client_qml 1.0

Item {
    id: my_account_page

    function wait_info_lbl () {
        info_lbl.text = "Please wait..."
        pulsing_anim.start()
    }

    Client {
        id: client
        onConnected_to_server: {
            info_lbl.visible = false
            pulsing_anim.stop()
            opacity_anim.stop()
        }
        onServer_refused_connection: {
            pulsing_anim.stop()
            opacity_anim.stop()
            info_lbl.text = "Connection to server was refused. Try later."
            info_lbl.visible = true
        }
        onSuccess_sing_in: {
            settings.save_user_settings(user_name.text, user_password.text)
            info_lbl.text = "Success sing in!"
            info_lbl.visible = true
            pulsing_anim.stop()
            opacity_anim.start()
        }
        onUnsuccess_sing_in: {
            info_lbl.text = "Incorrect user name or password."
            info_lbl.visible = true
            pulsing_anim.stop()
            opacity_anim.start()
        }
        onSuccess_sing_up: {
            settings.save_user_settings(user_name.text, user_password.text)
            info_lbl.text = "Success sing up!"
            info_lbl.visible = true
            pulsing_anim.stop()
            opacity_anim.start()
        }
        onUnsuccess_sing_up: {
            info_lbl.text = "Such user already exist. Please change user name."
            info_lbl.visible = true
            pulsing_anim.stop()
            opacity_anim.start()
        }
        onInternal_server_error: {
            pulsing_anim.stop()
            opacity_anim.stop()
            info_lbl.text = "Internal server error. Try later."
            info_lbl.visible = true
        }
    }

    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 5
        anchors.topMargin: 5
    }

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.25
        spacing: 5
        Label {
            id: info_lbl
            height: 30
            width: 200
            fontSizeMode: Text.Fit
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            minimumPointSize: 2
            font.pointSize: 10
            text: "Connecting to server..."
            OpacityAnimator {
                id: opacity_anim
                target: info_lbl
                from: 1
                to: 0
                duration: 1500
                running: false
            }
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
        TextField {
            id: user_name
            height: info_lbl.height
            width: info_lbl.width
            placeholderText: "User name"
            text: settings.get_user_name()
            enabled: sing_up.enabled
            inputMethodHints: Qt.ImhNoPredictiveText
        }
        TextField {
            id: user_password
            height: info_lbl.height
            width: info_lbl.width
            placeholderText: "Password"
            text: settings.get_user_password()
            enabled: sing_up.enabled
            inputMethodHints: Qt.ImhNoPredictiveText
        }
        Row {
            id: row
            spacing: 5
            Account_page_btn {
                id: sing_up
                width: (info_lbl.width - 2 * row.spacing) / 3
                height: info_lbl.height
                text: "Sing up"
                enabled: !settings.is_auth
                mouse_area.onClicked: {
                    if(user_name.text === "" || user_password.text === "") return
                    if(client.sing_up(user_name.text, user_password.text)) {
                        wait_info_lbl()
                    }
                }
            }
            Account_page_btn {
                id: sing_in
                width: sing_up.width
                height: sing_up.height
                text: "Sing in"
                enabled: !settings.is_auth
                mouse_area.onClicked: {
                    if(user_name.text === "" || user_password.text === "") return
                    if(client.sing_in(user_name.text, user_password.text)) {
                        wait_info_lbl()
                    }
                }
            }
            Account_page_btn {
                id: exit
                width: sing_up.width
                height: sing_up.height
                text: "Exit"
                enabled: settings.is_auth
                mouse_area.onClicked: {
                    settings.delete_user_settings_and_files()
                    user_name.text = ""
                    user_password.text = ""
                }
            }
        }
    }

}
























