import QtQuick 2.5

ListModel {
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
