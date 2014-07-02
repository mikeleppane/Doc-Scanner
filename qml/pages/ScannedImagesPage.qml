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
        running: listView.model.status === ListModel.Loading
        size: BusyIndicatorSize.Medium
    }
    */

    SilicaListView {
        id: listView
        anchors.fill: parent
        clip: true
        model: ListModel {id: imageModel}
        header: PageHeader {
            id: pageheader
            title: qsTr("Scanned Images")
        }
        spacing: Theme.paddingMedium
        ViewPlaceholder {
            enabled: imageModel.count === 0
            text: "No scanned images available"
        }

        delegate: imageDelegate

        VerticalScrollDecorator {}
    }

    Component {
        id: imageDelegate
        BackgroundItem {
            id: bgItem
            width: ListView.view.width
            height: img.height + Theme.itemSizeSmall
            anchors {
                left: parent.left
                leftMargin: Theme.paddingLarge
                right: parent.right
                rightMargin: Theme.paddingLarge
            }

            Image {
                id: img
                source: path
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                height: 300
                width: 300
                sourceSize.height: 300
                sourceSize.width: 300
                smooth: true
                cache: false
            }
            Label {
                id: dLabel
                anchors {
                    top: img.bottom
                    left: img.left
                    right: parent.right
                    rightMargin: Theme.paddingLarge
                }
                width: imagepage.width
                text: path
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.highlightColor
                font.underline: true
                elide: Text.ElideRight
            }
            onClicked: {
                onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path,
                                          "isScannedImage": true});
            }
            onPressAndHold: {
                remorse.execute(bgItem, qsTr("Deleting image..."), function() {
                                DB.removeImage(path)
                                images.splice(index,1);
                                imageModel.remove(index);
                                listView.positionViewAtBeginning();
                });
            }
            RemorseItem { id: remorse;}
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            if (imageModel.count !== 0) imageModel.clear();
            images = DB.getImages();
            var i = 0, count = images.length;
            for (i; i < count; i++) {
                imageModel.append({"path": images[i].path});
            }
         }
    }
}
