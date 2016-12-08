import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 480
    height: 340
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
            Layout.minimumHeight: 140
            Layout.maximumHeight: 260

            ColumnLayout {
                Repeater {
                    id: r
                    model: [
                        {
                            "title": "Commentarii de Bello Gallico",
                            "author": "Caius Iulius Caesar",
                            "genre": "Nonfiction",
                            "publisher": "Les Belles Lettres",
                            "year": "1926",
                            "summary": "Julius Caesar's firsthand account of the Gallic Wars",
                            "price": "9.00"
                        },
                        {
                            "title": "Προμηθεὺς δεσμώτης",
                            "author": "Αἰσχύλος",
                            "genre": "Theatre",
                            "publisher": "Les Solitaires Intempestifs",
                            "year": "2010",
                            "summary": "Prometheus defied the gods and gave fire to mankind",
                            "price": "24.34"
                        }
                    ]

                    Button {
                        text: modelData['title'] + ", " + modelData['author']
                        onClicked: {
                            dTitle.text = modelData['title']
                            dAuthor.text = modelData['author']
                            dGenre.text = modelData['genre']
                            dPublisher.text = modelData['publisher']
                            dYear.text = modelData['year']
                            dSummary.text = modelData['summary']
                            dPrice.text = modelData['price']
                        }
                    }
                }
            }
        }

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 380
            Layout.maximumHeight: 720

            GroupBox {
                title: "Détails"
                width: parent.width * .96
                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    columns: 2

                    Label { text: "Titre" }
                    Text { id: dTitle; }
                    Label { text: "Auteur" }
                    Text { id: dAuthor; }
                    Label { text: "Genre" }
                    Text { id: dGenre; }
                    Label { text: "Éditeur" }
                    Text { id: dPublisher; }
                    Label { text: "Année de publication" }
                    Text { id: dYear; }
                    Label { text: "Résumé" }
                    Text { id: dSummary; }
                    Label { text: "Prix" }
                    Text { id: dPrice; }
                }
            }
        }
    }
}
