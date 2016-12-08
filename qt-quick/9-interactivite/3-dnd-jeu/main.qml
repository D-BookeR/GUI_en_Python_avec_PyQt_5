import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ApplicationWindow {
    visible: true
    width: 460
    height: 360
    title: qsTr("Drag and drop game")
    style: ApplicationWindowStyle {
            background: Rectangle {
                color: "lightgrey"
            }
        }

    Rectangle {
        id: rectangle
        x: 40 + Math.random() * (parent.width - 2 * 40)
        y: 40 + Math.random() * (parent.height - 2 * 40)
        width: 40; height: 40
        color: (drop.containsDrag) ? "darkgreen" : "lightgrey"

        DropArea {
            id: drop
            anchors.fill: parent
        }
    }

    Rectangle {
        id: drag
        x: 20; y: 20
        width: 20; height: 20
        color: "black"

        Drag.active: true
        Drag.hotSpot: { x: 10; y: 10 }
        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
        }
    }
}
