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
import QtSensors 5.0
import "content"
import "scripts/Vars.js" as Vars
import "scripts/DocScannerDB.js" as DB
import "scripts/componentCreation.js" as Comp
// import io.thp.pyotherside 1.2

/**
* @brief Page to display an image
*/
Page {
    id: page
    //width: Screen.width
    //height: Screen.height
    allowedOrientations: Orientation.Landscape
    backNavigation: false

    /**
     * @brief type:string Path to the Image
     */
    property string path: null
    /**
     * @brief type:bool Is current image already scanned
     */
    property bool isScannedImage: false
    /**
     * @brief type:var A variable to store Area.qml object
     */
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
                    areaObj = Comp.createAreaObject(Screen.height, Screen.width);
                    areaObj.resetTouchPoints();
                    options.visible = false;
                    scanButton.visible = true
                    page.backNavigation = false;
                    img.fillMode = Image.Stretch
                }
            }
            MenuItem {
                text: qsTr("Convert to PDF")
                onClicked: {
                    if (areaObj !== null) {
                        areaObj.destroy();
                        areaObj = null;
                    }
                    pageStack.replace(Qt.resolvedUrl("PDFNameDialog.qml"), {"path": path});
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
        sourceSize.width: logic.getImageWidth(path)
        sourceSize.height: logic.getImageHeight(path)
        smooth: true

        Component.onCompleted:  {
            if (logic.getImageHeight(path) < 540 || logic.getImageWidth(path) < 960) {
                fillMode = Image.Stretch
            } else {
                fillMode = Image.PreserveAspectFit
            }
        }
    }

    IconButton {
        id: scanButton
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        scale: 1.5
        icon.source: "image://theme/icon-camera-shutter-release"

        onClicked: {
            path = logic.scanImage(areaObj.cx, areaObj.cy, areaObj.cw, areaObj.ch, path);
            orientationSensor.active = false;
            rotationSensor.active = false;
            if (path !== "") {
                if (Vars.ISMULTIPAGEENABLED) {
                    logic.setNewPage(path, Vars.ISPORTRAIT);
                }
                DB.addImage(path);
                myImageModel.addImage(path);
                img.source = path
                img.sourceSize.width = logic.getImageWidth(path)
                img.sourceSize.height = logic.getImageHeight(path)
                img.fillMode = Image.PreserveAspectFit
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
    OrientationSensor {
        id: orientationSensor
        active: false

        onReadingChanged: {
            if (reading.orientation === OrientationReading.TopUp ||
                reading.orientation === OrientationReading.TopDown) {
                Vars.ISPORTRAIT = true;
            } else if (Vars.ISPORTRAIT && Math.abs(rotationSensor.reading.x) <= 20 &&
                       Math.abs(rotationSensor.reading.y) <= 5) {
                Vars.ISPORTRAIT = true;
            } else if (!Vars.ISPORTRAIT && Math.abs(rotationSensor.reading.x) <= 5 &&
                       Math.abs(rotationSensor.reading.y) <= 20) {
                Vars.ISPORTRAIT = false;
            } else {
                Vars.ISPORTRAIT = false;
            }

            console.log(Vars.ISPORTRAIT)
        }
    }
    RotationSensor {
        id: rotationSensor
        active: false
    }
    /*
    onOrientationChanged: {
        if (options.visible === false) {
            if (areaObj !== null) {
                areaObj.destroy();
            }

            var cHeight = page.orientation === Orientation.Portrait ? Screen.width : Screen.height
            var cWidth = page.orientation === Orientation.Portrait ? Screen.height : Screen.width

            areaObj = Comp.createAreaObject(cHeight, cWidth);

            areaObj.resetTouchPoints();
            areaObj.resetLineW();
        }
    }
    */

    onStatusChanged: {
        if (status === PageStatus.Activating) {
            if (areaObj !== null) {
                areaObj.destroy();
                areaObj = null;
            }
            if (isScannedImage) {
                orientationSensor.active = true;
                rotationSensor.active = true;
                options.visible = true;
                scanButton.visible = false;
                page.backNavigation = true;
                img.fillMode = Image.PreserveAspectFit
            } else {
                orientationSensor.active = false;
                areaObj = Comp.createAreaObject(Screen.height, Screen.width);
                areaObj.resetTouchPoints();
            }
        } else if (status === PageStatus.Deactivating) {
            orientationSensor.active = false;
            rotationSensor.active = false;
        }
    }
}
