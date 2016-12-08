import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 480
    height: 300
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

            TableView {
                id: booksList
                anchors.fill: parent

                model: bookModel

                TableViewColumn {
                    role: "title"
                    title: "Titre"
                    width: 130
                }
                TableViewColumn {
                    role: "author"
                    title: "Auteur"
                    width: 110
                }
                TableViewColumn {
                    role: "publisher"
                    title: "Éditeur"
                    width: 80
                }
                TableViewColumn {
                    role: "year"
                    title: "Publication"
                    width: 70
                }
                TableViewColumn {
                    role: "price"
                    title: "Prix"
                    width: 50
                }
            }
        }

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 340
            Layout.maximumHeight: 680

            GroupBox {
                title: "Détails"
                width: parent.width * .96
                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    columns: 2

                    Label { text: "Titre" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).title; else "" }
                    Label { text: "Auteur" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).author; else "" }
                    Label { text: "Genre" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).genre; else "" }
                    Label { text: "Éditeur" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).publisher; else "" }
                    Label { text: "Année de publication" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).year; else "" }
                    Label { text: "Résumé" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).summary; else "" }
                    Label { text: "Prix" }
                    Text { text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).price; else "" }
                }
            }
        }
    }
}
