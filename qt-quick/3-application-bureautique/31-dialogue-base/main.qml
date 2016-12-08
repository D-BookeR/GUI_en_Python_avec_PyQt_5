import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    width: 80
    height: 50
    visible: true
    title: "Question importante"

    MessageDialog {
        id: dialog
        standardButtons: StandardButton.Ok | StandardButton.Yes | StandardButton.No | StandardButton.Abort
        title: "Question importante"
        text: "Cette boîte de dialogue est-elle utile ?"
        icon: StandardIcon.Question

        onYes: console.log("Oui")
        onNo: console.log("Non")
        onAccepted: console.log("OK")
        onRejected: console.log("Annuler")
    }

    Button {
        anchors.centerIn: parent
        text: "Cliquez ici"

        onClicked: dialog.open()
    }
}
