import QtQuick 2.5
import QtQuick.Controls 1.4
import "code.js" as Code

ApplicationWindow {
    visible: true
    width: 640
    height: 210
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

    Button {
        id: increaseButton
        text: qsTr("Increase size")
        anchors.top: colourField.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: colourField.horizontalCenter

        onClicked: Code.increaseSize(textField)
    }

    Button {
        id: decreaseButton
        text: qsTr("Decrease size")
        anchors.top: increaseButton.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: increaseButton.horizontalCenter

        onClicked: Code.decreaseSize(textField)
    }

    Label {
        id: text
        color: colourField.text
        text: textField.text
        anchors.top: decreaseButton.bottom
        anchors.topMargin: 20
        anchors.horizontalCenter: decreaseButton.horizontalCenter
    }
}
