import QtQuick
import QtQuick.Controls
import QtQuick.VirtualKeyboard

ApplicationWindow {
    id: app
    width: 390
    height: 844
    visible: true
    title: "Mr.Strang"

    property bool useVirtualKeyboard: false

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: Qt.resolvedUrl("Landing.qml")
    }

    InputPanel {
        id: inputPanel
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        visible: app.useVirtualKeyboard && Qt.inputMethod.visible
    }
}
