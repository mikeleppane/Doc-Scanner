.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db;

function openDB() {
    db = Sql.LocalStorage.openDatabaseSync("DocScannerDB","1.0","Doc Scanner Database",1e5);
    createTable();
}

function createTable() {
    db.transaction( function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS\
           Images (path TEXT)");
    });
}

function addImage(path) {
    db.transaction( function(tx) {
        tx.executeSql("INSERT INTO Images(path) VALUES(?)", [path]
        );
    });
}

function removeImage(path) {
    db.transaction( function(tx) {
        tx.executeSql("DELETE FROM Images WHERE path=?",[path]);
    });
}


function getImages() {
    var data = [];
    db.readTransaction( function(tx) {
       var rs = tx.executeSql("SELECT path FROM Images");
       var i = 0, count = rs.rows.length;
       for (; i < count; i++) {
           data[i] = rs.rows.item(i);
        }
    });
    return data;
}
