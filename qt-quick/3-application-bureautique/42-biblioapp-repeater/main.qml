import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 280
    visible: true

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "Quitter" }
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 120
            Layout.maximumHeight: 240

            ColumnLayout {
                Repeater {
                    model: [
                        {
                            "title": "Commentarii de Bello Gallico",
                            "author": "Caius Iulius Caesar",
                            "publisher": "Les Belles Lettres",
                            "year": "1926",
                            "summary": "Julius Caesar's firsthand account of the Gallic Wars",
                            "price": "9.00"
                        },
                        {
                            "title": "Προμηθεὺς δεσμώτης",
                            "author": "Αἰσχύλος",
                            "publisher": "Les Solitaires Intempestifs",
                            "year": "2010",
                            "summary": "Prometheus defied the gods and gave fire to mankind",
                            "price": "24.34"
                        }
                    ]

                    Text {
                        text: modelData['title'] + ", " + modelData['author']
                    }
                }
            }
        }

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 340
            Layout.maximumHeight: 680

            Text {
                anchors.centerIn: parent
                text: "Détails d'un livre"
            }
        }
    }
}
