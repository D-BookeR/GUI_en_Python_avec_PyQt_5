import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 640
    height: 120
    title: qsTr("Hello World")

    TextField {
        id: textField
        width: 250
        anchors.horizontalCenter: parent.horizontalCenter
        y: 10
        placeholderText: qsTr("Enter text")
    }

    TextField {
        id: colourField
        width: 250
        anchors.top: textField.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: textField.horizontalCenter
        placeholderText: qsTr("Enter colour")
    }

    Label {
        color: colourField.text
        text: textField.text
        anchors.top: colourField.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: colourField.horizontalCenter
    }
}
