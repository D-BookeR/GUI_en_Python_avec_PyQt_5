import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 480
    height: 320
    visible: true
    title: "BiblioApp"

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "Quitter" }
        }
    }

    ListModel {
        id: bookModel

        ListElement {
            title: "Commentarii de Bello Gallico"
            author: "Caius Iulius Caesar"
            genre: "Nonfiction"
            publisher: "Les Belles Lettres"
            year: "1926"
            summary: "Julius Caesar's firsthand account of the Gallic Wars"
            price: "9.00"
        }
        ListElement {
            title: "Προμηθεὺς δεσμώτης"
            author: "Αἰσχύλος"
            genre: "Theatre"
            publisher: "Les Solitaires Intempestifs"
            year: "2010"
            summary: "Prometheus defied the gods and gave fire to mankind"
            price: "24.34"
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

            ListView {
                id: booksList
                anchors.fill: parent
                spacing: 2

                model: bookModel
                delegate: Item {
                    width: parent.width
                    height: 18

                    Text {
                        text: title + ", " + author
                    }
                    MouseArea {
                        onClicked: booksList.currentIndex = index
                        anchors.fill: parent
                    }
                }

                highlight: Rectangle { color: "lightsteelblue" }
                focus: true
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
                    Text { text: bookModel.get(booksList.currentIndex).title }
                    Label { text: "Auteur" }
                    Text { text: bookModel.get(booksList.currentIndex).author }
                    Label { text: "Genre" }
                    Text { text: bookModel.get(booksList.currentIndex).genre }
                    Label { text: "Éditeur" }
                    Text { text: bookModel.get(booksList.currentIndex).publisher }
                    Label { text: "Année de publication" }
                    Text { text: bookModel.get(booksList.currentIndex).year }
                    Label { text: "Résumé" }
                    Text { text: bookModel.get(booksList.currentIndex).summary }
                    Label { text: "Prix" }
                    Text { text: bookModel.get(booksList.currentIndex).price }
                }
            }
        }
    }
}
