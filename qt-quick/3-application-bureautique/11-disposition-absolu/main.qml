import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    width: 250
    height: 150
    title: "BiblioApp"

    RowLayout {
        x: 10; y: 10

        Button { text: "Nouveau" }
        Button { text: "Sauvegarder" }
        Button { text: "Supprimer" }
    }

    ColumnLayout {
        x: 10; y: 60

        Button { text: "Nouveau" }
        Button { text: "Sauvegarder" }
        Button { text: "Supprimer" }
    }
}
