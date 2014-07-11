import QtQuick 2.0
import Sailfish.Silica 1.0
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
            title: qsTr("Images")
        }
        spacing: Theme.paddingSmall
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
            width: ListView.view.width
            height: img.height + Theme.itemSizeMedium
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
            Label {
                id: dLabel
                anchors {
                    top: img.bottom
                    topMargin: Theme.paddingSmall
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
                onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path});
            }
            onPressAndHold: {
                remorse.execute(bgItem, qsTr("Deleting image..."), function() {
                                var ind = index;
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
            images = logic.getImages(StandardPaths.pictures);
            var i = 0, count = images.length;
            for (i; i < count; i++) {
                imageModel.append({"path": images[i]});
            }
         }
    }
}
