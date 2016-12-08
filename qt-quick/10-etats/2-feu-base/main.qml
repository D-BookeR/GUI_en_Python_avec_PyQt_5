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
        width: 80; height: 80; radius: 40
        color: "red"
        x: 20; y: 20
    }

    Rectangle {
        id: red2
        width: 80; height: 80; radius: 40
        color: "red"

        anchors.top: red1.top
        anchors.left: red1.right
        anchors.leftMargin: 60
    }

    Rectangle {
        id: white
        width: 80; height: 80; radius: 40
        color: "white"

        anchors.top: red1.bottom
        anchors.topMargin: 30
        anchors.left: red1.right
        anchors.leftMargin: -10
    }
}
