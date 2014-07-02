import QtQuick 2.1
import Sailfish.Silica 1.0
import "content"
import "scripts/Vars.js" as Vars
import "scripts/DocScannerDB.js" as DB

Page {
    id: page
    //width: Screen.width
    //height: Screen.height
    allowedOrientations: Orientation.Landscape | Orientation.Portrait
    backNavigation: Vars.CANBACKNAVIGATE
    property string path: null
    property bool isScannedImage: false

    SilicaFlickable {
        id: options
        anchors.fill: parent
        visible: false
        PullDownMenu {
            MenuItem {
                text: qsTr("Convert to PDF")
                onClicked: {
                    area.visible = false;
                    logic.convertToPDF(path);
                }
            }
            MenuItem {
                text: qsTr("Send Email")
                onClicked: {
                    area.visible = false;
                    logic.sendEmail();
                }
            }
        }
        z: 20
    }

    Image {
        id: img
        anchors.fill: parent
        source: path
        asynchronous: true
        sourceSize.width: logic.getImageHeight(path) > logic.getImageWidth(path)
                          ? logic.getImageHeight(path) : logic.getImageWidth(path)
        sourceSize.height: logic.getImageWidth(path) > logic.getImageHeight(path)
                           ? logic.getImageWidth(path): logic.getImageHeight(path)
        smooth: true
        fillMode: Image.PreserveAspectFit
    }

    Area {
        id: area
        cHeight: Screen.height
        cWidth: Screen.width
        z: 10
    }

    IconButton {
        id: scanButton
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        icon.source: "image://theme/icon-camera-shutter-release"

        onClicked: {
            logic.scanImage(area.cx, area.cy, area.cw, area.ch, path);
            img.source = path
            img.sourceSize.width = logic.getImageHeight(path) > logic.getImageWidth(path)
                    ? logic.getImageHeight(path) : logic.getImageWidth(path)
            img.sourceSize.height = logic.getImageWidth(path) > logic.getImageHeight(path)
                    ? logic.getImageWidth(path) : logic.getImageHeight(path)
            area.visible = false;
            options.visible = true;
            visible = false;
            Vars.CANBACKNAVIGATE = true;
            DB.addImage(path);
        }
        z: 20
    }

    onOrientationChanged: {
        area.cHeight = isPortrait ? Screen.width : Screen.height
        area.cWidth = isPortrait ? Screen.height : Screen.width
        area.resetTouchPoints();
        area.circleLineW = 2;
        Vars.CANBACKNAVIGATE = true;
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            Vars.CANBACKNAVIGATE = true;
            if (isScannedImage) {
                area.visible = false;
                options.visible = true;
                scanButton.visible = false;
            }

         }
    }
}
