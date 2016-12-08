var db;

function openDB(initialGenres, initialBooks) {
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
                              initialGenres.map(function(val, idx, arr) {
                                  return "(\"" + val + "\")";
                              }).join(", ") + ";");
                tx.executeSql('INSERT INTO books (title, author, genre_id, publisher, ' +
                                                 'year, summary, price) ' +
                              'VALUES ' +
                              initialBooks.map(function(val, idx, arr) {
                                  var genreId = -1; 
                                  for(var i = 0; i < initialGenres.length; i++) {
                                      if(val['genre'] === initialGenres[i]) {
                                          genreId = i;
                                          break; 
                                      }
                                  }
                                  var list = [val['title'], val['author'], genreId, val['publisher'], val['year'], val['summary'], val['price']]
                                  return "(" + 
                                         list.map(function(lval, lidx, larr) {
                                             return "\"" + lval + "\"";
                                         }).join(", ") + 
                                         ")";
                              }).join(", ") + ";");
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
