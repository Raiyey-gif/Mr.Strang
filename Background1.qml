import QtQuick
import QtQuick.Effects

Item {
    anchors.fill: parent

    // =========================
    // RAW BACKGROUND CONTENT
    // =========================
    Item {
        id: bgSource
        anchors.fill: parent

        // BASE GRADIENT
        Rectangle {
            color: "#e2bea8"
            anchors.fill: parent
            gradient: Gradient {
                GradientStop {
                    position: 0.00
                    color: "#5173ad"
                }
                GradientStop {
                    position: 0.50
                    color: "#f5b09c"
                }
                GradientStop {
                    position: 0.85
                    color: "#fdcfa5"
                }
                GradientStop {
                    position: 1.00
                    color: "#b797e2"
                }
            }
        }

        // CLOUD (bottom-left)
        Rectangle {
            width: parent.width * 1.4
            height: width
            radius: width / 2

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: -width * 0.25
            anchors.bottomMargin: -width * 0.35

            gradient: Gradient {
                GradientStop {
                    position: 0.00
                    color: "#5173ad"
                }
                GradientStop {
                    position: 0.31
                    color: "#aab9e4"
                }
                GradientStop {
                    position: 0.68
                    color: "#e09070"
                }
            }
            opacity: 0.85
        }

        // TOP HAZE
        Rectangle {
            width: parent.width * 1.2
            height: width
            radius: width / 2

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -width * 0.35
            anchors.topMargin: -width * 0.4

            gradient: Gradient {
                GradientStop {
                    position: 0.28
                    color: "#9f8edd"
                }
                GradientStop {
                    position: 1.00
                    color: "#f1e093"
                }
            }
            opacity: 0.85
        }
    }

    // =========================
    // GLOBAL BLUR EFFECT
    // =========================
    MultiEffect {
        anchors.fill: parent
        source: bgSource

        blurEnabled: true
        blur: 1.2 // softness (0.6–1.2 sweet spot)
        saturation: 1.15 // keeps colors alive
    }
}
