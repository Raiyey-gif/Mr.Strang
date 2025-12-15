import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    anchors.fill: parent
    property real scale: Math.min(width, height) / 420

    Background1 {}

    Column {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.85, 420 * scale)
        spacing: 18 * scale

        // =========================
        // TITLE
        // =========================
        Text {
            text: "Hey. Take your time."
            font.pixelSize: 26 * scale
            font.bold: true
            color: "white"
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            text: "What do you feel like doing right now?"
            font.pixelSize: 15 * scale
            color: "white"
            opacity: 0.95
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
        }

        // =========================
        // 🔵 FOCUS MODE
        // =========================
        ModeItem {
            glow1: "#a2b8ea"
            glow2: "#709ae2"
            title: "🎯 Focus session"
            subtitle: "Set a timer and I’ll keep you company"
            onClicked: StackView.view.push("PomodoroTimer.qml")
        }

        // =========================
        // 🟣 MUSIC MODE
        // =========================
        ModeItem {
            glow1: "#d1baf5"
            glow2: "#8b67d3"
            title: "🎵 Music time"
            subtitle: "Let’s find the right mood together"
            onClicked: StackView.view.push("SpotifyMini.qml")
        }

        // =========================
        // 🍑 CHAT MODE
        // =========================
        ModeItem {
            glow1: "#ecd3a0"
            glow2: "#d38067"
            title: "💬 Just talk"
            subtitle: "No goals. I’m here."
            onClicked: StackView.view.push("Main.qml")
        }
    }

    // =====================================================
    // BUTTON COMPONENT (LOCAL, SAFE)
    // =====================================================
    component ModeItem: Item {
        width: parent.width
        height: 72 * scale

        property color glow1
        property color glow2
        property string title
        property string subtitle
        property bool pressed: false

        signal clicked

        scale: pressed ? 0.97 : 1.0
        Behavior on scale {
            NumberAnimation {
                duration: 120
            }
        }

        // ---------- GLOW ----------
        MultiEffect {
            anchors.fill: parent
            source: base
            blurEnabled: true
            blur: pressed ? 1.6 : 1.0
            saturation: 2.6
        }

        Rectangle {
            id: base
            anchors.fill: parent
            radius: 25
            color: glow1
            opacity: pressed ? 0.28 : 0.18
        }

        Rectangle {
            anchors.fill: parent
            radius: 25
            color: glow2
            opacity: pressed ? 0.28 : 0.18
        }

        // ---------- CONTENT ----------
        Column {
            anchors.centerIn: parent
            spacing: 4
            width: parent.width

            Text {
                text: title
                font.pixelSize: 16 * scale
                font.bold: true
                color: "white"
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                text: subtitle
                font.pixelSize: 12 * scale
                color: "white"
                opacity: 0.8
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
            }
        }

        // ---------- INTERACTION ----------
        MouseArea {
            anchors.fill: parent
            onPressed: pressed = true
            onReleased: pressed = false
            onClicked: clicked()
        }
    }
}
