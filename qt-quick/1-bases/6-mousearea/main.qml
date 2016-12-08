import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 240
    title: qsTr("Hello World")

    Rectangle {
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("User clicked at: " + mouse.x + ", " + mouse.y)
            }
        }
    }
}
