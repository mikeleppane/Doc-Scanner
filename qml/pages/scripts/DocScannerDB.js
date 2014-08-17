/*!
 *  Doc Scanner - application for Sailfish OS smartphones developed using
 *  Qt/QML.
 *  Copyright (C) 2014 Mikko Leppänen
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

// global variable to hold database instance
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
