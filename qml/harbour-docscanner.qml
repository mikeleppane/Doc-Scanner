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

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "pages"
import "pages/scripts/DocScannerDB.js" as DB
import "pages/scripts/Vars.js" as Vars

/**
 * @brief Root object
 */
ApplicationWindow
{
    id: appWindow
    MainPage {id: mainpage }
    initialPage: mainpage
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    Component.onCompleted: {
        DB.openDB();
        myImageModel.addImages(StandardPaths.pictures);
        Vars.VERSION = logic.getVersion();
    }

    onApplicationActiveChanged: {
        if (!applicationActive) {
            mainpage.cameraObj.cameraState = Camera.UnloadedState;
        } else {
            mainpage.cameraObj.cameraState = Camera.ActiveState;
        }
    }
}


