import QtQuick 2.5

Rectangle {
    width: 200
    height: 100
    color: "lightblue"
    
    Text {
        anchors.centerIn: parent
        text: "Hello World"
        color: "darkblue"
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }
}