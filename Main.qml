import QtQuick
import QtQuick.Controls

Item {
    id: root
    anchors.fill: parent

    // Mode passed from ModeChoice.qml
    // "chat" | "focus" | "music"
    property string mode: "chat"

    // =========================
    // BACKGROUND (GLOBAL STYLE)
    // =========================
    Background1 {
        anchors.fill: parent
    }

    // =========================
    // TOP BAR (OPTIONAL)
    // =========================
    Rectangle {
        id: topBar
        width: parent.width
        height: 52
        color: "transparent"

        Text {
            anchors.centerIn: parent
            text: mode === "chat" ? "Mr. Strang" : mode === "focus" ? "Focus Session" : "Music Mode"
            color: "white"
            font.pixelSize: 18
            font.bold: true
        }
    }

    // =========================
    // MAIN CONTENT AREA
    // =========================
    Loader {
        id: contentLoader
        anchors {
            top: topBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        sourceComponent: mode === "chat" ? chatPage : mode === "focus" ? pomodoroPage : musicPage
    }

    // =========================
    // CHAT (AI COMPANION)
    // =========================
    Component {
        id: chatPage
        ToolsPanel {
            anchors.fill: parent
        }
    }

    // =========================
    // POMODORO
    // =========================
    Component {
        id: pomodoroPage
        PomodoroTimer {
            anchors.fill: parent
        }
    }

    // =========================
    // MUSIC
    // =========================
    Component {
        id: musicPage
        SpotifyMini {
            anchors.fill: parent
        }
    }
}
