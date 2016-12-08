import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 450
    height: 400
    visible: true
    title: "BiblioApp"

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "Quitter" }
        }
    }

    ListModel {
        id: genreModel
        ListElement { text: "(None)" }
        ListElement { text: "Biography" }
        ListElement { text: "Crime" }
        ListElement { text: "Science-fiction" }
        ListElement { text: "Fantastic" }
        ListElement { text: "Historic" }
        ListElement { text: "Nonfiction" }
        ListElement { text: "Theatre" }

        function findGenreIndexByName(name) {
            for(var i = 0; i < count; i++) {
                if(name === get(i).text) {
                    return i;
                }
            }
            return -1;
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
                onRowCountChanged: {
                    selection.clear();
                    if (rowCount > 0) {
                        selection.select(rowCount - 1);
                    }
                }

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
            Layout.minimumHeight: 360
            Layout.maximumHeight: 680

            GroupBox {
                id: detailsGroup
                title: "Détails"
                width: parent.width * .96
                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    columns: 2

                    Label { text: "Titre" }
                    TextField {
                        id: fieldTitle
                        text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).title; else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Auteur" }
                    TextField {
                        id: fieldAuthor
                        text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).author; else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Genre" }
                    ComboBox {
                        id: fieldGenre
                        model: genreModel
                        currentIndex: if(booksList.currentRow >= 0) genreModel.findGenreIndexByName(bookModel.get(booksList.currentRow).genre); else 0
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Éditeur" }
                    TextField {
                        id: fieldPublisher
                        text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).publisher; else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Année de publication" }
                    SpinBox {
                        id: fieldYear
                        minimumValue: 0
                        maximumValue: new Date().getFullYear()
                        value: if(booksList.currentRow >= 0) parseInt(bookModel.get(booksList.currentRow).year); else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Résumé" }
                    TextField {
                        id: fieldSummary
                        text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).summary; else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                    Label { text: "Prix" }
                    TextField {
                        id: fieldPrice
                        text: if(booksList.currentRow >= 0) bookModel.get(booksList.currentRow).price; else ""
                        Layout.minimumWidth: window.width * 0.6
                    }
                }
            }

            RowLayout {
                spacing: 60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: detailsGroup.bottom
                anchors.topMargin: 20

                Button {
                    text: "Nouveau"
                    onClicked: {
                        booksList.currentRow = -1
                        booksList.selection.deselect()
                    }
                }
                Button {
                    text: "Sauvegarder"
                    onClicked: {
                        var contents = {title: fieldTitle.text, author: fieldAuthor.text,
                            genre: fieldGenre.currentText, publisher: fieldPublisher.text,
                            year: fieldYear.text, summary: fieldSummary.text, price: fieldPrice.text};
                        if (booksList.currentRow >= 0) { // Update current item.
                            bookModel.set(booksList.currentRow, contents);
                        } else { // Create an item.
                            bookModel.append(contents)
                        }
                    }
                }
                Button {
                    text: "Supprimer"
                    enabled: booksList.currentRow >= 0
                    onClicked:
                        if (booksList.currentRow >= 0)
                            bookModel.remove(booksList.currentRow)
                }
            }
        }
    }
}
