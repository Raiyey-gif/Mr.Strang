import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent
    property real scale: Math.min(width, height) / 400

    Background1 {}

    Column {
        anchors.centerIn: parent
        spacing: 14 * scale
        width: parent.width * 0.8

        Text {
            text: "Input Preference"
            font.pixelSize: 26 * scale
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: "Do you want to use the on-screen keyboard?"
            font.pixelSize: 14 * scale
            color: "white"
            opacity: 0.85
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Button {
            text: "Yes, use keyboard"
            width: parent.width
            onClicked: {
                app.useVirtualKeyboard = true
                StackView.view.push(Qt.resolvedUrl("Login.qml"))
            }
        }

        Button {
            text: "No, I use physical keyboard"
            width: parent.width
            onClicked: {
                app.useVirtualKeyboard = false
                StackView.view.push(Qt.resolvedUrl("Login.qml"))
            }
        }
    }
}
