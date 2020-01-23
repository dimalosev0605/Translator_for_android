import QtQuick 2.11
import QtQuick.Controls 2.4

Item {
    id: root
    Back_btn {
        id: back_btn
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
    }
    Text {
        id: header_text
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 5
        height: back_btn.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        fontSizeMode: Text.Fit
        minimumPointSize: 3
        font.pointSize: 12
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
        text: "Searh history"
    }

    Rectangle {
        id: scroll_frame
        anchors.top: back_btn.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
//        border.width: 1
//        border.color: "black"
        ScrollView {
            anchors.fill: parent
            ListView {
                id: search_history_words_list_view
                anchors.fill: parent
                spacing: 10
                clip: true
                model: search_history_words_data_model
//                delegate: History_word_delegate {
//                    word_and_transcription: String(model.word) + '\n' + String(model.transcription)
//                    most_popular_syn: String(model.most_popular_syn)
//                    date: String(model.date)
//                }

                delegate: SwipeDelegate {
                    id: swipe_delegate
                    width: search_history_words_list_view.width
                    height: (search_history_words_list_view.height - 9 * search_history_words_list_view.spacing) / 10
                    leftPadding: 0
                    rightPadding: 0
                    topPadding: 0
                    bottomPadding: 0
                    property int text_width: swipe_delegate.width / 3
                    property int text_height: swipe_delegate.height
                    contentItem: Rectangle {
                        border.width: 1
                        border.color: "black"
                        color: swipe_delegate.pressed ? "#cfcfcf" : "white"
                        Row {
                            anchors.fill: parent
                            Text {
                                id: word_and_transcription
                                width: swipe_delegate.text_width
                                height: swipe_delegate.text_height
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                fontSizeMode: Text.Fit
                                minimumPointSize: 3
                                font.pointSize: 12
                                elide: Text.ElideRight
                                wrapMode: Text.WordWrap
                                text: String(model.word) + '\n' + String(model.transcription)
                            }
                            Text {
                                id: most_popular_syn
                                width: swipe_delegate.text_width
                                height: swipe_delegate.text_height
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                fontSizeMode: Text.Fit
                                minimumPointSize: 3
                                font.pointSize: 12
                                elide: Text.ElideRight
                                wrapMode: Text.WordWrap
                                text: String(model.most_popular_syn)
                            }
                            Text {
                                id: date
                                width: swipe_delegate.text_width
                                height: swipe_delegate.text_height
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                fontSizeMode: Text.Fit
                                minimumPointSize: 3
                                font.pointSize: 12
                                elide: Text.ElideRight
                                wrapMode: Text.WordWrap
                                text: String(model.date)
                            }
                        }
                    }
                    ListView.onRemove: SequentialAnimation {
                        PropertyAction {
                            target: swipe_delegate
                            property: "ListView.delayRemove"
                            value: true
                        }
                        NumberAnimation {
                            target: swipe_delegate
                            property: "height"
                            to: 0
                            easing.type: Easing.InOutQuad
                        }
                        PropertyAction {
                            target: swipe_delegate
                            property: "ListView.delayRemove"
                            value: false
                        }
                    }

                    swipe.right: Rectangle {
                        anchors.right: parent.right
                        height: parent.height
                        width: parent.width * 0.3
                        border.width: 1
                        border.color: "black"
                        color: delete_btn_m_area.pressed ? Qt.darker("tomato", 1.1) : "tomato"
                        MouseArea {
                            id: delete_btn_m_area
                            anchors.fill: parent
                            z: 1
                            onClicked: search_history_words_data_model.remove(index)
                        }
                        Text {
                            id: delete_lbl
                            text: qsTr("Delete")
                            color: "black"

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            fontSizeMode: Text.Fit
                            minimumPointSize: 3
                            font.pointSize: 10
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                            height: parent.height
                            width: parent.width
                        }
                    }
                    swipe.left: Rectangle {
                        anchors.left: parent.left
                        height: parent.height
                        width: parent.width * 0.2
                        border.width: 1
                        border.color: "black"
                        color: translate_btn_m_area.pressed ? Qt.darker("#00ff00", 1.1) : "#00ff00"
                        MouseArea {
                            id: translate_btn_m_area
                            anchors.fill: parent
                            z: 1
                            onClicked: {
                                user_input_field.text = search_history_words_data_model.get_word_from_history(index)
                                stack_view.pop()
                            }
                        }
                        Text {
                            id: translate_lbl
                            text: "Translate"
                            color: "black"

                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            fontSizeMode: Text.Fit
                            minimumPointSize: 3
                            font.pointSize: 10
                            elide: Text.ElideRight
                            wrapMode: Text.WordWrap
                            height: parent.height
                            width: parent.width
                        }
                    }
                }
            }
        }
    }
}
