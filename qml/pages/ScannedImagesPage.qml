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

/**
 * @brief Shows all the scanned images from the database
 */
Page {
    id: imagepage
    width: Screen.width
    height: Screen.height

    /**
     * @brief type:list List to hold the images
     */
    property var images: []

    BusyIndicator {
        id: indicator
        anchors.centerIn: parent
        running: imageModel.status === ListModel.Loading
        size: BusyIndicatorSize.Large
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        clip: true
        model: ListModel {id: imageModel}
        header: PageHeader {
            id: pageheader
            title: qsTr("Scanned Images")
        }
        ViewPlaceholder {
            enabled: imageModel.count === 0 || indicator.running
            text: indicator.running ? qsTr("Loading images") : qsTr("No scanned images available")
        }

        PullDownMenu {
            MenuItem {
                text: qsTr("Delete All")
                onClicked: {
                    if (images.length > 0) {
                        var i = 0, count = imageModel.count
                        for (; i < count; i++) {
                            DB.removeImage(imageModel.get(i).path)
                            myImageModel.removeImage(imageModel.get(i).path, i)
                        }
                        imageModel.clear();
                        images = [];
                    }
                }
            }
        }

        delegate: imageDelegate

        VerticalScrollDecorator {}
    }

    Component {
        id: imageDelegate
        BackgroundItem {
            id: bgItem
            width: ListView.view.width
            height: img.height + col.childrenRect.height + dLabel.height + Theme.itemSizeSmall
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                right: parent.right
                rightMargin: Theme.paddingLarge
            }
            Image {
                id: img
                source: path
                fillMode: Image.PreserveAspectCrop
                asynchronous: true
                height: 300
                width: 300
                sourceSize.height: 300
                sourceSize.width: 300
                smooth: true
                cache: false
            }
            Column {
                id: col
                spacing: 0
                anchors {
                    top: img.bottom
                    topMargin: Theme.paddingSmall
                    left: img.left
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                Row {
                    spacing: img.width - (l1.width + l2.width)
                    width: imagepage.width / 2
                    Label {
                        id: l1
                        text: logic.getImageWidth(path) + " x " + logic.getImageHeight(path) + " px"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                    }
                    Label {
                        id: l2
                        text: logic.getImageSize(path)
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.secondaryColor
                    }
                }
                Label {
                    width: imagepage.width
                    text: logic.getImageCreateDate(path)
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.secondaryColor
                }
            }
            Label {
                id: dLabel
                anchors {
                    top: col.bottom
                    left: img.left
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                opacity: 0.5
                width: imagepage.width
                text: path
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor
                //elide: Text.ElideRight
                wrapMode: Text.WrapAnywhere
            }
            onClicked: {
                onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path,
                                          "isScannedImage": true});
            }
            onPressAndHold: {
                remorse.execute(bgItem, qsTr("Deleting image..."), function() {
                                var ind = index;
                                DB.removeImage(path)
                                myImageModel.removeImage(path, ind)
                                images.splice(ind,1);
                                imageModel.remove(ind);
                                if (ind > 1) {
                                    listView.positionViewAtIndex(ind - 1,ListView.SnapPosition)
                                }
                });
            }
            RemorseItem { id: remorse;}
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            //indicator.running = true;
        } else if (status === PageStatus.Active) {
            if (imageModel.count !== 0) imageModel.clear();
            images = DB.getImages();
            var i = 0, count = images.length;
            for (; count > 0; count--) {
                if (logic.checkIfImageExists(images[count - 1].path)) {
                    imageModel.append({"path": images[count - 1].path});
                } else {
                    DB.removeImage(images[count - 1].path);
                }
            }
            indicator.running = false;
        }
    }
}
