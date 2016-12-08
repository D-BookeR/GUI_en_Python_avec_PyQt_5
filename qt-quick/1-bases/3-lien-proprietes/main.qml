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
        x: parent.width / 2 - width / 2
        y: parent.y + 10
        placeholderText: "Entrez du texte"
    }

    TextField {
        id: colourField
        width: 250
        x: parent.width / 2 - width / 2
        y: textField.y + 30
        placeholderText: "Saisissez une couleur"
    }

    Label {
        color: colourField.text
        text: textField.text
        x: parent.width / 2 - width / 2
        y: colourField.y + 50
    }
}
