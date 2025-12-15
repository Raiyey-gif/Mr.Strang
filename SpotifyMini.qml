import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: root

    // =========================
    // PREVIEW DETECTION
    // =========================
    property bool previewMode: typeof spotify === "undefined"

    width: previewMode ? 390 : parent.width
    height: previewMode ? 120 : parent.height

    // =========================
    // MOCK DATA FOR PREVIEW
    // =========================
    property string previewTrack: "🎵 Lo-fi Study Beats"
    property bool previewPlaying: true

    // =========================
    // PREVIEW BACKGROUND
    // =========================
    Rectangle {
        anchors.fill: parent
        visible: previewMode
        color: "#0e0e12"
    }

    // =========================
    // GLASS CONTAINER
    // =========================
    Rectangle {
        id: glass
        anchors.fill: parent
        radius: 20
        color: "#ffffff"
        opacity: 0.12
        border.color: "#ffffff"
        border.width: 1

        MultiEffect {
            anchors.fill: glass
            source: glass
            blurEnabled: true
            blur: 1
            saturation: 1.4
        }

        Row {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 14

            // =========================
            // ALBUM ART PLACEHOLDER
            // =========================
            Rectangle {
                width: height
                height: parent.height
                radius: 12
                color: "#ffffff"
                opacity: 0.25
            }

            // =========================
            // TRACK INFO
            // =========================
            Column {
                anchors.verticalCenter: parent.verticalCenter
                spacing: 4
                width: parent.width * 0.5

                Text {
                    text: previewMode ? previewTrack : spotify.currentTrack
                    color: "white"
                    font.pixelSize: 14
                    font.bold: true
                    elide: Text.ElideRight
                }

                Text {
                    text: previewMode ? (previewPlaying ? "Playing" : "Paused") : (spotify.playing ? "Playing" : "Paused")
                    color: "white"
                    opacity: 0.7
                    font.pixelSize: 12
                }
            }

            // =========================
            // FLEX SPACER (CORRECT)
            // =========================
            Item {
                width: parent.width
                height: 1
            }

            // =========================
            // CONTROLS
            // =========================
            Row {
                spacing: 12
                anchors.verticalCenter: parent.verticalCenter

                Button {
                    text: (previewMode ? previewPlaying : spotify.playing) ? "⏸" : "▶"

                    onClicked: {
                        if (previewMode) {
                            previewPlaying = !previewPlaying
                        } else {
                            spotify.playing ? spotify.pause() : spotify.play()
                        }
                    }
                }

                Button {
                    text: "⏭"
                    onClicked: {
                        if (!previewMode)
                            spotify.next()
                    }
                }
            }
        }
    }
}
