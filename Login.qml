import QtQuick
import QtQuick.Controls

Item {
    anchors.fill: parent
    property real scale: Math.min(width, height) / 400

    Background1 { }

    Column {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -10 * scale
        spacing: 12 * scale
        width: Math.min(parent.width * 0.8, 360 * scale)

        Text {
            text: "Welcome Back"
            font.pixelSize: 28 * scale
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        Text {
            text: "Login to continue"
            font.pixelSize: 14 * scale
            color: "white"
            opacity: 0.85
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        TextField {
            placeholderText: "Email"
            width: parent.width
        }

        TextField {
            placeholderText: "Password"
            echoMode: TextInput.Password
            width: parent.width
        }

        Button {
            text: "Login"
            width: parent.width
            height: 44 * scale
            onClicked: StackView.view.push(Qt.resolvedUrl("Main.qml"))
        }

        Text {
            text: "No account? Sign up"
            font.pixelSize: 13 * scale
            color: "white"
            opacity: 0.9
            horizontalAlignment: Text.AlignHCenter
            width: parent.width

            MouseArea {
                anchors.fill: parent
                onClicked: StackView.view.push(Qt.resolvedUrl("SignIn.qml"))
            }
        }
    }
}
