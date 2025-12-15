import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    anchors.fill: parent
    property real scale: Math.min(width, height) / 400

    Background1 {}

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -14 * scale
        spacing: 10 * scale

        Text {
            text: "Mr.Strang"
            font.pixelSize: 36 * scale
            font.bold: true
            color: "white"
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            text: "Focus · Learn · Improve"
            font.pixelSize: 16 * scale
            color: "white"
            opacity: 0.9
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            width: 180 * scale
            height: 48 * scale
            anchors.horizontalCenter: parent.horizontalCenter

            MultiEffect {
                anchors.fill: parent
                source: glass
                blurEnabled: true
                blur: 0.8
                saturation: 1.5
            }

            Rectangle {
                id: glass
                anchors.fill: parent
                radius: height / 2
                color: "#ffffff"
                opacity: 0.18
                border.color: "#ffffff"
                border.width: 1
            }

            Text {
                anchors.centerIn: parent
                text: "Start"
                font.pixelSize: 16 * scale
                font.bold: true
                color: "#ea8080"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: StackView.view.push(Qt.resolvedUrl(
                                                   "KeyboardChoice.qml"))
            }
        }
    }
}
