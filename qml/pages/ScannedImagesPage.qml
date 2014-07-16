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
                                logic.removeImage(path);
                                images.splice(index,1);
                                imageModel.remove(index);
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
            if (imageModel.count !== 0) imageModel.clear();
            images = DB.getImages();
            var i = 0, count = images.length;
            for (; count > 0; count--) {
                imageModel.append({"path": images[count - 1].path});
            }
         }
    }
}
