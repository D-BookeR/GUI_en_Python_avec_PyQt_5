import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    visible: true
    width: 260
    height: 240
    title: qsTr("Level crossing")
    style: ApplicationWindowStyle {
            background: Rectangle {
                color: "black"
            }
        }

    Rectangle {
        id: red1
        width: 80
        height: 80
        radius: 40
        color: "red"

        x: 20
        y: 20

        states: [
            State {
                name: "blinking"
                PropertyChanges { target: red1; color: "red" }
                PropertyChanges {
                    target: timer
                    interval: 500
                    repeat: true
                    running: true
                    onTriggered: red1.color = Qt.colorEqual(red1.color, "red") ? "black" : "red"
                }
            },
            State {
                name: "off"
                PropertyChanges { target: red1; color: "black" }
                // Don't disable timer! Would interact with the other changes.
            }
        ]
    }

    Rectangle {
        id: red2
        width: 80
        height: 80
        radius: 40
        color: (red1.state == "off") ? "black" : Qt.colorEqual(red1.color, "red") ? "black" : "red"

        anchors.top: red1.top
        anchors.left: red1.right
        anchors.leftMargin: 60
    }

    Rectangle {
        id: white
        width: 80
        height: 80
        radius: 40
        color: "white"

        anchors.top: red1.bottom
        anchors.topMargin: 30
        anchors.left: red1.right
        anchors.leftMargin: -10

        states: [
            State {
                name: "blinking"
                PropertyChanges { target: white; color: "white" }
                PropertyChanges {
                    target: timer
                    interval: 800
                    repeat: true
                    running: true
                    onTriggered: white.color = Qt.colorEqual(white.color, "white") ? "black" : "white"
                }
            },
            State {
                name: "off"
                PropertyChanges { target: white; color: "black" }
                // Don't disable timer! Would interact with the other changes.
            }
        ]
    }

    Timer {
        id: timer
        running: false
        repeat: true
    }

    MouseArea {
        id: click
        anchors.fill: parent
        onClicked: {
            switch (state) {
                case "allowed": state = "disallowed"; break; 
                case "disallowed": state = "allowed"; break; 
            }
        }

        states: [
            State {
                name: "allowed"
                PropertyChanges { target: red1; state: "off" }
                PropertyChanges { target: white; state: "blinking" }
            },
            State {
                name: "disallowed"
                PropertyChanges { target: white; state: "off" }
                PropertyChanges { target: red1; state: "blinking" }
            }
        ]
        
        state: "allowed"
    }
}
