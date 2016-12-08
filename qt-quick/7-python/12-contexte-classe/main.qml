import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    title: "Exemple"
    visible: true
    width: 200; height: 100

    Rectangle {
        anchors.fill: parent
        color: "lightblue"
        
        Text {
            anchors.centerIn: parent
            text: textProvider.provide()
            color: "darkblue"
        }
    }
}