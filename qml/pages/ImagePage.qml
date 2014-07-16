import QtQuick 2.0
import Sailfish.Silica 1.0
import "content"
import "scripts/Vars.js" as Vars
import "scripts/DocScannerDB.js" as DB
import "scripts/componentCreation.js" as Comp
// import io.thp.pyotherside 1.2

Page {
    id: page
    //width: Screen.width
    //height: Screen.height
    allowedOrientations: Orientation.Landscape | Orientation.Portrait
    backNavigation: false
    property string path: null
    property bool isScannedImage: false
    property bool enhance_image: false
    property var areaObj: null

    SilicaFlickable {
        id: options
        anchors.fill: parent
        visible: false
        PullDownMenu {
            MenuItem {
                text: qsTr("Home")
                onClicked: {
                    //pageStack.navigateBack(PageStackAction.Animated)
                    pageStack.clear();
                    pageStack.push(Qt.resolvedUrl("MainPage.qml"));
                }
            }
            MenuItem {
                text: qsTr("Scan Image")
                onClicked: {
                    if (areaObj !== null) {
                        areaObj.destroy();
                        areaObj = null;
                    }
                    var cHeight = page.orientation === Orientation.Portrait ? Screen.width : Screen.height
                    var cWidth = page.orientation === Orientation.Portrait ? Screen.height : Screen.width

                    areaObj = Comp.createAreaObject(cHeight, cWidth);
                    areaObj.resetTouchPoints();
                    options.visible = false;
                    scanButton.visible = true
                    page.backNavigation = false;
                }
            }
            MenuItem {
                text: qsTr("Convert to PDF")
                onClicked: {
                    if (areaObj !== null) {
                        areaObj.destroy();
                        areaObj = null;
                    }
                    logic.convertToPDF(path);
                }
            }
            MenuItem {
                text: qsTr("Send Email")
                onClicked: {
                    if (areaObj !== null) {
                        areaObj.destroy();
                        areaObj = null;
                    }
                    logic.sendEmail();
                }
            }
        }
        z: 20
    }

    /*
    Python {
        id: py

        Component.onCompleted: {
            // Add the directory of this .qml file to the search path
            addImportPath(Qt.resolvedUrl('.'));

            importModule('imagehandler', function () {
                py.call('imagehandler.image_editor', path, function() {})
            });
        }

        onError: console.log('Python error: ' + traceback)
    }
    */

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
    /*
    Area {
        id: area
        cHeight: Screen.height
        cWidth: Screen.width
        z: 10
    }
    */

    IconButton {
        id: scanButton
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        icon.source: "image://theme/icon-camera-shutter-release"

        onClicked: {
            path = logic.scanImage(areaObj.cx, areaObj.cy, areaObj.cw, areaObj.ch, path);
            if (path !== "") {
                DB.addImage(path);
                img.source = path
                img.sourceSize.width = logic.getImageHeight(path) > logic.getImageWidth(path)
                        ? logic.getImageHeight(path) : logic.getImageWidth(path)
                img.sourceSize.height = logic.getImageWidth(path) > logic.getImageHeight(path)
                        ? logic.getImageWidth(path) : logic.getImageHeight(path)
                if (areaObj !== null) {
                    areaObj.destroy();
                    areaObj = null;
                }
                options.visible = true;
                visible = false;
                page.backNavigation = true;
            }
        }
        z: 20
    }

    onOrientationChanged: {
        if (options.visible === false) {
            if (areaObj !== null) {
                areaObj.destroy();
            }

            var cHeight = isPortrait ? Screen.width : Screen.height
            var cWidth = isPortrait ? Screen.height : Screen.width

            areaObj = Comp.createAreaObject(cWidth, cHeight);

            areaObj.resetTouchPoints();
            areaObj.resetLineW();
        }
    }

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            //Vars.CANBACKNAVIGATE = false;
            if (isScannedImage) {
                options.visible = true;
                scanButton.visible = false;
                page.backNavigation = true;
            } else {

                if (areaObj !== null) {
                    areaObj.destroy();
                    areaObj = null;
                }
                areaObj = Comp.createAreaObject(Screen.width, Screen.height);
                areaObj.resetTouchPoints();
            }
         }
    }
}
