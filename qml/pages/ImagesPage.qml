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

        model: ListModel {id: imageModel}

        header: PageHeader {
            id: pageheader
            title: qsTr("Images")
        }

        cellWidth: imagepage.width / 3
        cellHeight: imagepage.width / 3

        ViewPlaceholder {
            enabled: imageModel.count === 0
            text: "No images available"
        }

        delegate: imageDelegate

        VerticalScrollDecorator {}
    }

    Component {
        id: imageDelegate
        BackgroundItem {
            id: bgItem
            width: imagepage.width / 3 //GridView.view.width / 2
            height: imagepage.width / 3 //+ Theme.itemSizeMedium

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
                                logic.removeImage(path);
                                images.splice(index,1);
                                imageModel.remove(index);
                                if (ind > 1) {
                                     gridView.positionViewAtIndex(ind - 1,GridView.SnapPosition)
                                }
                });
            }
            RemorseItem { id: remorse;}
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            if (imageModel.count !== 0) imageModel.clear();
            images = logic.getImages(StandardPaths.pictures);
            var i = 0, count = images.length;
            for (i; i < count; i++) {
                imageModel.append({"path": images[i]});
            }
         }
    }
}
