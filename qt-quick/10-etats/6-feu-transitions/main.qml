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
                name: "blinkingOn"
                PropertyChanges { target: red1; color: "red" }
                PropertyChanges {
                    target: timer
                    interval: 500
                    running: true
                    onTriggered: red1.state = "blinkingOff"
                }
            },
            State {
                name: "blinkingOff"
                PropertyChanges { target: red1; color: "black" }
                PropertyChanges {
                    target: timer
                    interval: 500
                    running: true
                    onTriggered: red1.state = "blinkingOn"
                }
            },
            State {
                name: "off"
                PropertyChanges { target: red1; color: "black" }
            }
        ]
        transitions: [
            Transition {
                from: "off"; to: "blinkingOn"
                ColorAnimation { target: red1; properties: "color"; duration: 300 }
            },
            Transition {
                from: "blinkingOn"; to: "blinkingOff"
                ColorAnimation { target: red1; properties: "color"; duration: 200 }
            },
            Transition {
                from: "blinkingOff"; to: "blinkingOn"
                ColorAnimation { target: red1; properties: "color"; duration: 100 }
            },
            Transition {
                from: "blinkingOff"; to: "off"
                ColorAnimation { target: red1; properties: "color"; duration: 150 }
            }
        ]
    }

    Rectangle {
        id: red2
        width: 80
        height: 80
        radius: 40
        color: "red"

        anchors.top: red1.top
        anchors.left: red1.right
        anchors.leftMargin: 60

        states: [
            State {
                name: "blinkingOn"
                PropertyChanges { target: red2; color: "red" }
                PropertyChanges {
                    target: timerB
                    interval: 500
                    running: true
                    onTriggered: red2.state = "blinkingOff"
                }
            },
            State {
                name: "blinkingOff"
                PropertyChanges { target: red2; color: "black" }
                PropertyChanges {
                    target: timerB
                    interval: 500
                    running: true
                    onTriggered: red2.state = "blinkingOn"
                }
            },
            State {
                name: "off"
                PropertyChanges { target: red2; color: "black" }
            }
        ]
        transitions: [
            Transition {
                from: "off"; to: "blinkingOn"
                ColorAnimation { target: red2; properties: "color"; duration: 300 }
            },
            Transition {
                from: "blinkingOn"; to: "blinkingOff"
                ColorAnimation { target: red2; properties: "color"; duration: 200 }
            },
            Transition {
                from: "blinkingOff"; to: "blinkingOn"
                ColorAnimation { target: red2; properties: "color"; duration: 100 }
            },
            Transition {
                from: "blinkingOff"; to: "off"
                ColorAnimation { target: red2; properties: "color"; duration: 150 }
            }
        ]
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
                name: "blinkingOn"
                PropertyChanges { target: white; color: "white" }
                PropertyChanges {
                    target: timer
                    interval: 800
                    running: true
                    onTriggered: white.state = "blinkingOff"
                }
            },
            State {
                name: "blinkingOff"
                PropertyChanges { target: white; color: "black" }
                PropertyChanges {
                    target: timer
                    interval: 800
                    running: true
                    onTriggered: white.state = "blinkingOn"
                }
            },
            State {
                name: "off"
                PropertyChanges { target: white; color: "black" }
            }
        ]
        transitions: [
            Transition {
                from: "off"; to: "blinkingOn"
                ColorAnimation { target: white; properties: "color"; duration: 300 }
            },
            Transition {
                from: "blinkingOn"; to: "blinkingOff"
                ColorAnimation { target: white; properties: "color"; duration: 200 }
            },
            Transition {
                from: "blinkingOff"; to: "blinkingOn"
                ColorAnimation { target: white; properties: "color"; duration: 100 }
            },
            Transition {
                from: "blinkingOff"; to: "off"
                ColorAnimation { target: white; properties: "color"; duration: 150 }
            }
        ]
    }

    Timer {
        id: timer
        running: false
        repeat: true
    }

    Timer {
        id: timerB
        running: false
        repeat: true
    }

    MouseArea {
        id: click
        anchors.fill: parent
        onClicked: {
            switch (state) {
                case "allowed": state = "disallowed"; break
                case "disallowed": state = "allowed"; break
            }
        }

        states: [
            State {
                name: "allowed"
                PropertyChanges { target: red1; state: "off" }
                PropertyChanges { target: red2; state: "off" }
                PropertyChanges { target: white; state: "blinkingOn" }
            },
            State {
                name: "disallowed"
                PropertyChanges { target: white; state: "off" }
                PropertyChanges { target: red1; state: "blinkingOn" }
                PropertyChanges { target: red2; state: "blinkingOff" }
            }
        ]
    }

    Component.onCompleted: click.state = "allowed"
}
