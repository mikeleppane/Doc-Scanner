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
import "scripts/DocScannerDB.js" as DB
//import "../pages/scripts/Vars.js" as Vars

Page {
    id: imagepage
    width: Screen.width
    height: Screen.height

    property var images: []

    /*
    BusyIndicator {
        anchors.centerIn: parent
        running: gridView.model.status === ListModel.Loading
        size: BusyIndicatorSize.Medium
    }
    */

    SilicaGridView {
        id: gridView
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        model: myImageModel //ListModel {id: imageModel}

        header: PageHeader {
            id: pageheader
            title: qsTr("Images")
        }

        cellWidth: imagepage.width / 3
        cellHeight: imagepage.width / 3

        ViewPlaceholder {
            enabled: gridView.model.count === 0
            text: qsTr("No images available")
        }

        delegate: imageDelegate

        VerticalScrollDecorator {}
    }

    Component {
        id: imageDelegate
        BackgroundItem {
            id: bgItem
            width: imagepage.width / 3
            height: imagepage.width / 3

            Image {
                id: img
                source: path
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                height: imagepage.width / 3
                width: imagepage.width / 3
                sourceSize.height: imagepage.width / 3
                sourceSize.width: imagepage.width / 3
                smooth: true
                cache: false
            }

            onClicked: {
                onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path,
                                          "isScannedImage": true});
            }
            onPressAndHold: {
                remorse.execute(bgItem, qsTr("Deleting image..."), function() {
                                var ind = index;
                                DB.removeImage(path);
                                myImageModel.removeImage(path,ind)
                                if (ind > 1) {
                                    gridView.positionViewAtIndex(ind - 1,GridView.SnapPosition)
                                }
                });
            }
            RemorseItem { id: remorse;}
        }
    }
}
