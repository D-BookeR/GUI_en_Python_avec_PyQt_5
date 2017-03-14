import QtQuick 2.7
import QtQuick.Controls 1.4

ApplicationWindow {
    id: window
    width: 300
    height: 300
    visible: true
    title: "Test"

    Rectangle {
        id: rect
        color: "red"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        width: 30
        height: 10

        Behavior on width {
            NumberAnimation {
                duration: 2500
            }
        }
    }

    Timer {
        id: timer
        running: true
        interval: 3000
        onTriggered: {
            rect.width = 300;
            rect.height = 300;
        }
    }
}
