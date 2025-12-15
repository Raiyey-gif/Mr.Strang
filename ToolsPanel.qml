import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root
    anchors.fill: parent

    property real scale: Math.min(width, height) / 420

    // =========================
    // BACKGROUND (SAME AS OTHERS)
    // =========================
    Background1 {}

    // =========================
    // GLASS CHAT PANEL
    // =========================
    Rectangle {
        id: glassPanel
        width: Math.min(parent.width * 0.92, 520)
        height: parent.height * 0.78
        anchors.centerIn: parent
        radius: 26
        color: "#ffffff"
        opacity: 0.12
        border.color: "#ffffff"
        border.width: 1

        MultiEffect {
            anchors.fill: parent
            source: glassPanel
            blurEnabled: true
            blur: 1
            saturation: 1.8
        }

        Column {
            anchors.fill: parent
            anchors.margins: 18 * scale
            spacing: 12 * scale

            // =========================
            // HEADER
            // =========================
            Text {
                text: "Mr. Strang"
                font.pixelSize: 20 * scale
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            Text {
                text: "I’m listening. Try not to waste my time."
                font.pixelSize: 13 * scale
                color: "white"
                opacity: 1
                horizontalAlignment: Text.AlignHCenter
                width: parent.width
            }

            // =========================
            // CHAT AREA
            // =========================
            Rectangle {
                id: chatBox
                width: parent.width
                height: parent.height * 0.62
                radius: 18
                color: "#ffffff"
                opacity: 0.9
                border.color: "#ffffff"
                border.width: 1

                Flickable {
                    anchors.fill: parent
                    contentHeight: chatColumn.height
                    clip: true

                    Column {
                        id: chatColumn
                        width: parent.width
                        spacing: 10 * scale
                        anchors.top: parent.top
                        anchors.margins: 12 * scale

                        // AI MESSAGE (STARTER)
                        Rectangle {
                            width: parent.width * 0.9
                            radius: 14
                            color: "#ffffff"
                            opacity: 0.18

                            Text {
                                text: "You showed up. That’s already above average."
                                wrapMode: Text.WordWrap
                                anchors.margins: 10
                                anchors.fill: parent
                                color: "white"
                                font.pixelSize: 13 * scale
                            }
                        }
                    }
                }
            }

            // =========================
            // INPUT ROW
            // =========================
            Row {
                width: parent.width
                spacing: 8 * scale

                TextField {
                    id: inputField
                    width: parent.width * 0.78
                    placeholderText: "Say something…"
                    color: "white"
                    background: Rectangle {
                        radius: 14
                        color: "#ffffff"
                        opacity: 0.15
                        border.color: "#ffffff"
                        border.width: 1
                    }

                    onAccepted: sendMessage()
                }

                Button {
                    width: parent.width * 0.2
                    height: inputField.height
                    text: "Send"

                    background: Rectangle {
                        radius: 14
                        color: "#ffffff"
                        opacity: 0.25
                    }

                    onClicked: sendMessage()
                }
            }
        }
    }

    // =========================
    // SEND MESSAGE LOGIC
    // =========================
    function sendMessage() {
        if (inputField.text.length === 0)
            return

        // USER BUBBLE
        chatColumn.addItem(userBubble(inputField.text))

        // SEND TO C++
        chatManager.sendMessage(inputField.text)
        inputField.text = ""
    }

    // =========================
    // USER MESSAGE COMPONENT
    // =========================
    function userBubble(text) {
        return Qt.createQmlObject(`
                                  import QtQuick
                                  Rectangle {
                                  width: chatColumn.width * 0.85
                                  radius: 14
                                  color: "#ffffff"
                                  opacity: 0.28
                                  anchors.right: parent.right

                                  Text {
                                  text: "${text.replace(/"/g, '\\"')}"
                                  wrapMode: Text.WordWrap
                                  anchors.margins: 10
                                  anchors.fill: parent
                                  color: "white"
                                  font.pixelSize: ${13 * scale}
                                  }
                                  }
                                  `, chatColumn)
    }

    // =========================
    // AI RESPONSE HANDLER
    // =========================
    Connections {
        target: chatManager

        function onAiResponded(text) {
            chatColumn.addItem(Qt.createQmlObject(`
                                                  import QtQuick
                                                  Rectangle {
                                                  width: chatColumn.width * 0.9
                                                  radius: 14
                                                  color: "#ffffff"
                                                  opacity: 0.18

                                                  Text {
                                                  text: "${text.replace(/"/g,
                                                                        '\\"')}"
                                                  wrapMode: Text.WordWrap
                                                  anchors.margins: 10
                                                  anchors.fill: parent
                                                  color: "white"
                                                  font.pixelSize: ${13 * scale}
                                                  }
                                                  }
                                                  `, chatColumn))
        }
    }
}
