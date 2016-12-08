import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2
import QtQuick.LocalStorage 2.0

ApplicationWindow {
    id: window
    width: 450
    height: 400
    visible: true
    title: "BiblioApp"

    property var db
    function openDB() {
        db = LocalStorage.openDatabaseSync("BiblioApp", "1.0", "BiblioApp SQL database", 1000000,
            function (db) {
                db.transaction(function (tx) {
                    tx.executeSql('CREATE TABLE genres (' +
                                      'genre_id INTEGER PRIMARY KEY,' +
                                      'genre TEXT' +
                                  ');');
                    tx.executeSql('CREATE TABLE books (' +
                                      'book_id INTEGER PRIMARY KEY,' +
                                      'title TEXT,' +
                                      'author TEXT,' +
                                      'genre_id INTEGER, ' +
                                      'publisher TEXT,' +
                                      'year TEXT,' +
                                      'summary TEXT,' +
                                      'price TEXT' +
                                  ');');
                    tx.executeSql('INSERT INTO genres (genre) VALUES ' +
                                  '("(None)"), ("Biography"), ("Crime"), ' +
                                  '("Science-fiction"), ("Fantastic"), ' +
                                  '("Historic"), ("Nonfiction"), ("Theatre")');
                    tx.executeSql('INSERT INTO books (title, author, genre_id, publisher, ' + '
                                                      year, summary, price) ' +
                                  'VALUES ' +
                                  '("Commentarii de Bello Gallico", "Caius Iulius Caesar", 6, ' +
                                   '"Les Belles Lettres", "1926", ' +
                                   '"Julius Caesar\'s firsthand account of the Gallic Wars", "9.00"), ' +
                                  '("Προμηθεὺς δεσμώτης", "Αἰσχύλος", 7, ' +
                                   '"Les Solitaires Intempestifs", "2010", ' +
                                   '"Prometheus defied the gods and gave fire to mankind", "24.34") ');
                });
                db.changeVersion("", "1.0");
            }
        );
    }
    function populateGenres() {
        db.transaction(function(tx) {
            var genres = tx.executeSql("SELECT * FROM genres");
            for (var i = 0; i < genres.rows.length; ++i) {
                var item = genres.rows.item(i);
                genreModel.append({ text: item.genre, id: item.genre_id });
            }
        });
    }
    function populateBooks() {
        db.transaction(function(tx) {
            var books = tx.executeSql("SELECT * FROM books NATURAL JOIN genres");
            for (var i = 0; i < books.rows.length; ++i) {
                var item = books.rows.item(i);
                bookModel.append({
                                     id: item.book_id,
                                     title: item.title,
                                     author: item.author,
                                     genre: item.genre,
                                     publisher: item.publisher,
                                     year: item.year,
                                     summary: item.summary,
                                     price: item.price
                                 });
            }
        });
    }
    function addBook(id) {
        db.transaction(function(tx) {
            var book = bookModel.get(id);
            var gid = genreModel.findGenreDatabaseIndexByName(book.genre);
            tx.executeSql('INSERT INTO books ' +
                          '(title, author, genre_id, publisher, ' +
                            'year, summary, price) ' +
                          'VALUES (?, ?, ?, ?, ?, ?, ?);',
                          [book.title, book.author, gid,
                           book.publisher, book.year,
                           book.summary, book.price]);
        });
    }
    function updateBook(id) {
        db.transaction(function(tx) {
            var book = bookModel.get(id);
            var gid = genreModel.findGenreDatabaseIndexByName(book.genre);
            tx.executeSql('UPDATE books ' +
                          'SET title = ?, author = ?, ' +
                          'genre_id = ?, publisher = ?, year = ?, ' +
                          'summary = ?, price = ? ' +
                          'WHERE book_id = ?;',
                          [book.title, book.author, gid,
                           book.publisher, book.year,
                           book.summary, book.price, book.id]);
        });
    }
    function removeBook(id) {
        db.transaction(function(tx) {
            var book = bookModel.get(id);
            tx.executeSql('DELETE FROM books WHERE book_id = ?;', [book.id]);
        });
    }

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "Quitter"; onTriggered: Qt.quit() }
        }
    }

    ListModel {
        id: genreModel
        function findGenreIndexByName(name) {
            for(var i = 0; i < count; i++) {
                if(name === get(i).text) {
                    return i;
                }
            }
            return -1;
        }
        function findGenreDatabaseIndexByName(name) {
            for(var i = 0; i < count; i++) {
                if(name === get(i).text) {
                    return get(i).id;
                }
            }
            return -1;
        }
    }

    ListModel {
        id: bookModel
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
                   selection.select(rowCount-1);
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
                        textRole: "text"
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
                            updateBook(booksList.currentRow);
                        } else { // Create an item.
                            bookModel.append(contents);
                            addBook(bookModel.count - 1); // Currently not selected!
                        }
                    }
                }
                Button {
                    text: "Supprimer"
                    onClicked:
                        if (booksList.currentRow >= 0) {
                            removeBook(booksList.currentRow);
                            bookModel.remove(booksList.currentRow);
                        }
                }
            }
        }
    }

    Component.onCompleted: {
        openDB();
        populateGenres();
        populateBooks();
    }
}
