import QtQuick.Window 2.2
import QtQuick.Controls 2.4

Window {
    visible: true
    width: 640
    height: 480

    StackView {
        id: stack_view
        anchors.fill: parent
        initialItem: Main_menu {}
    }

}
