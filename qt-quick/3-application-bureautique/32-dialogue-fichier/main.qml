import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    width: 80
    height: 50
    visible: true

    FileDialog {
        id: file.
        title: "Fichier à ouvrir"
        onAccepted: accept.open()
    }

    MessageDialog {
        id: accept
        text: "Fichier choisi : " + file.fileUrl
    }

    Button {
        anchors.centerIn: parent
        text: "Cliquez ici"

        onClicked: file.open()
    }
}
