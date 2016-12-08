import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    width: 396
    height: 398
    title: "BiblioApp"

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "&Ouvrir…" }
            MenuItem { text: "&Enregistrer" }
            MenuItem {
                text: "&Quitter"
                shortcut: "Ctrl+Q" // StandardKey.Quit
                onTriggered: Qt.quit()
            }
        }
    }

    toolBar: ToolBar {
        RowLayout {
            anchors.fill: parent
            ToolButton { text: "Nouveau" }
            ToolButton { text: "Sauvegarder" }
            ToolButton { text: "Supprimer" }
            ToolButton {
                text: "&Quitter"
                onClicked: Qt.quit()
            }
        }
    }

    statusBar: StatusBar {
        Label { text: "Votre gestionnaire de bibliothèques depuis 2016 !" }
    }

    RowLayout {
        x: 25
        y: 150
        spacing: 60

        Button { text: "Nouveau" }
        Button { text: "Sauvegarder" }
        Button { text: "Supprimer" }
    }
}
