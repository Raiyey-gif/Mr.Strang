import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    anchors.fill: parent
    property real scale: Math.min(width, height) / 420

    // =========================
    // TIMER STATE
    // =========================
    property int totalMinutes: 25
    property int remainingSeconds: totalMinutes * 60
    property bool running: false

    // =========================
    // AI STATE
    // =========================
    property string aiText: "So… how brave are you feeling today?"
    property int sassLevel: Math.floor(totalMinutes / 10)

    Background1 {}

    Column {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 420)
        spacing: 18 * scale

        // =========================
        // TITLE
        // =========================
        Text {
            text: "Focus Session"
            font.pixelSize: 26 * scale
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        // =========================
        // TIME DISPLAY
        // =========================
        Text {
            text: {
                var m = Math.floor(remainingSeconds / 60)
                var s = remainingSeconds % 60
                return (m < 10 ? "0" : "") + m + ":" + (s < 10 ? "0" : "") + s
            }
            font.pixelSize: 42 * scale
            font.bold: true
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            width: parent.width
        }

        // =========================
        // TIME SETTER
        // =========================
        Slider {
            id: timeSlider
            width: parent.width
            from: 5
            to: 90
            stepSize: 1
            value: totalMinutes
            enabled: !running

            implicitHeight: 32

            background: Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                x: 0
                width: parent.width
                height: 6
                radius: 3
                color: "white"
                opacity: 0.25
            }

            handle: Rectangle {
                width: 22
                height: 22
                radius: 11
                y: (parent.height - height) / 2

                x: (timeSlider.visualPosition * (parent.width - width))

                color: "white"
                opacity: timeSlider.pressed ? 1.0 : 0.85
                border.color: "white"
                border.width: 1
            }

            onValueChanged: {
                totalMinutes = value
                remainingSeconds = totalMinutes * 60
                sassLevel = Math.floor(totalMinutes / 10)
            }
        }

        // =========================
        // START / STOP BUTTON
        // =========================
        Button {
            text: running ? "Stop (I give up 😬)" : "Start focusing"
            width: parent.width
            height: 46 * scale

            MultiEffect {
                anchors.fill: parent
                source: glass
                blurEnabled: true
                blur: 1.3
                saturation: 1.5
            }

            Rectangle {
                id: glass
                anchors.fill: parent
                radius: 16
                color: "#ffffff"
                opacity: 0.16
                border.width: 0
            }

            onClicked: {
                if (!running) {
                    running = true
                    remainingSeconds = totalMinutes * 60

                    if (sassLevel <= 0)
                        aiText = "Alright, just testing the waters. I respect that."
                    else if (sassLevel === 1)
                        aiText = "Cute choice. Let’s warm up 🧸"
                    else if (sassLevel === 2)
                        aiText = "Okay… this is real focus now. Don’t drift."
                    else if (sassLevel === 3)
                        aiText = "Serious mode engaged. I expect effort."
                    else if (sassLevel === 4)
                        aiText = "Hmm. Ambitious. Let’s see if you can keep up."
                    else if (sassLevel === 5)
                        aiText = "Bold. Very bold. I hope you’re not bluffing."
                    else if (sassLevel === 6)
                        aiText = "That’s a long session. No snacks. No excuses."
                    else if (sassLevel === 7)
                        aiText = "Interesting choice. This is where people usually quit."
                    else if (sassLevel === 8)
                        aiText = "You sure about this? I’ll remember if you stop."
                    else
                        aiText = "Alright. Legendary focus or legendary failure. Choose wisely."

                    timer.start()
                } else {
                    running = false
                    timer.stop()
                    aiText = "Wow. Quitting already? I expected more 😔"
                }
            }
        }

        // =========================
        // AI COMMENT (GLASS)
        // =========================
        Item {
            width: parent.width
            height: 50 * scale

            Rectangle {
                id: glass1
                anchors.fill: parent
                radius: 10
                color: "transparent"
                opacity: 0.16
                border.color: "#ffffff"
                border.width: 0
            }

            Item {
                anchors.fill: parent
                anchors.margins: 14

                Text {
                    anchors.fill: parent
                    text: aiText
                    font.bold: true
                    wrapMode: Text.WordWrap
                    color: "#494949"
                    font.pixelSize: 14 * scale
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }

    // =========================
    // TIMER LOGIC
    // =========================
    Timer {
        id: timer
        interval: 1000
        repeat: true

        onTriggered: {
            remainingSeconds--

            if (remainingSeconds === totalMinutes * 60 - 1)
                aiText = "Timer started. No distractions. I’m watching 👀"
            else if (remainingSeconds === remainingSeconds / 2)
                aiText = sassLevel >= 3 ? "Halfway. You better not slack now." : "Halfway there. Still doing okay?"
            else if (remainingSeconds === 60)
                aiText = "One minute left. Finish strong."
            else if (remainingSeconds === 10)
                aiText = "Ten seconds. Don’t you dare stop now."

            if (remainingSeconds <= 0) {
                running = false
                stop()
                aiText = sassLevel >= 3 ? "You survived. I’m impressed. Seriously." : "Nice work. That was solid 💛"
            }
        }
    }
}
