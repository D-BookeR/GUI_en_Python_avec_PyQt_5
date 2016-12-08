import QtQuick 2.5
import FileModel 1.0

BiblioApp {
    width: 450
    height: 400
    visible: true
    title: "BiblioApp"

    bookModel: FileDictListModel {
        file: "books.db"
        Component.onCompleted: {
            if (justCreated) {
                for (var i = 0; i < initialBooks.length; ++i) {
                    bookModel.append(JSON.stringify(initialBooks[i]));
                }
            }
        }
    }
    genreModel: FileStringListModel {
        file: "genres.db"
        Component.onCompleted: {
            if (justCreated) {
                for (var i = 0; i < initialGenres.length; ++i) {
                    genreModel.append(initialGenres[i]);
                }
            }
        }
    }
}
