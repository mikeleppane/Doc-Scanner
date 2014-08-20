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

import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import QtSensors 5.0
//import Sailfish.Media 1.0
//import com.jolla.camera 1.0
import "content"
import "scripts/Vars.js" as Vars

/**
* @brief Top level page to display video output
*/
Page {
    id: page
    allowedOrientations: Orientation.Portrait

    /**
     * @brief type:real Helper variable to store previous distance
     */
    property real refPoint

    /**
     * @brief type:cameraObj Allowing access to the camera obj from the root level
     */
    property alias cameraObj: camera

    /**
     * @brief Calculates euclidean distance between to points
     * @param type:string levelName Name of the level
     * @param type:object represents first point, x and y are parameters
     * @param type:object represents second point, x and y are parameters
     */
    function calculateTouchPointDistance(p1, p2) {
        return Math.sqrt(Math.pow(p1.x - p2.x,2) + Math.pow(p1.y - p2.y,2))
    }

    SilicaFlickable {
        id: pulldownmenu
        anchors.fill: parent
        anchors.margins: 0
        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"));
            }
            MenuItem {
                text: qsTr("Options")
                onClicked: pageStack.push(Qt.resolvedUrl("OptionsPage.qml"));
            }
            MenuItem {
                text: qsTr("Show Scanned Images")
                onClicked: pageStack.push(Qt.resolvedUrl("ScannedImagesPage.qml"));
            }
            MenuItem {
                text: qsTr("Upload Image")
                onClicked: pageStack.push(Qt.resolvedUrl("ImagesPage.qml"));
            }
        }
        z: 20
    }

    ZoomItem {
        id: zoomItem
        width: Screen.width
        anchors {
            top: cameraOutput.top
            horizontalCenter: cameraOutput.horizontalCenter
        }
        transform: Translate {y: 175}
        visible: false
        z: 30
    }

    Item {
        id: cameraOutput
        x: 0
        y: 0
        anchors.fill: parent
        width: 540
        height: 960

        VideoOutput {
            id: vOut
            anchors.fill: cameraOutput
            source: camera
            focus: visible
            /*
            Does not work.
            Cannot recognize Camera.focus.focusZones
            Repeater {
                  anchors.centerIn: parent
                  model: Camera.focus.focusZones

                  Rectangle {
                      anchors.centerIn: parent
                      width: 125
                      height: 125
                      border {
                          width: 3
                          color: index === 2 ? "green" : "white"
                      }
                      color: "transparent"

                      // Map from the relative, normalized frame coordinates
                      //property variant mappedRect: vOut.mapNormalizedRectToItem(area);

                  }
            }
            */

            MultiPointTouchArea {
                id: touchArea
                anchors.fill: parent
                        touchPoints: [
                            TouchPoint { id: point1 },
                            TouchPoint { id: point2 }
                        ]
                        property var p1: {"x": point1.x,
                                          "y": point1.y}
                        property var p2: {"x": point2.x,
                                          "y": point2.y}


                onPressed: {
                    pulldownmenu.enabled = false;
                    zoomItem.visible = true;
                    marker.enabled = false;
                    refPoint = calculateTouchPointDistance(p1, p2);
                }
                onUpdated: {
                    if (calculateTouchPointDistance(p1, p2) > refPoint + 4) {
                        zoomItem.zoomDir = "in"
                        zoomItem.factor += (camera.maximumDigitalZoom / 12) / (camera.maximumDigitalZoom - 1)
                        camera.digitalZoom += (camera.maximumDigitalZoom / 12)
                        refPoint = calculateTouchPointDistance(p1, p2);
                    } else if (calculateTouchPointDistance(p1, p2) < refPoint - 4) {
                        zoomItem.zoomDir = "out"
                        zoomItem.factor -= (camera.maximumDigitalZoom / 12) / (camera.maximumDigitalZoom - 1)
                        camera.digitalZoom -= (camera.maximumDigitalZoom / 12)
                        refPoint = calculateTouchPointDistance(p1, p2);
                    }
                }

                onReleased: {
                    pulldownmenu.enabled = true;
                    zoomItem.visible = false;
                    marker.enabled = true;
                }
            }
        }

        Camera {
            id: camera

            focus {
                focusMode: Camera.FocusContinuous
                focusPointMode: Camera.FocusPointCenter
            }
            flash.mode: Camera.FlashOff

            imageProcessing {
                sharpeningLevel: 1
            }

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposurePortrait
            }

        }
    }
    Marker {
        id: marker
        anchors.centerIn: page
        anchors.margins: 0
        z: 10
    }

    Row {
        anchors {
            bottom: parent.bottom
            bottomMargin: Theme.paddingMedium
            horizontalCenter: parent.horizontalCenter
        }
        IconButton {
            id: cameraButton
            width: page.width / 3
            icon.source: "image://theme/icon-camera-shutter-release"
            scale: 1.5
            onClicked: {
                camera.imageCapture.capture();
            }
            /*
            SequentialAnimation {
                id: anim
                NumberAnimation { target: cameraButton; property: "opacity"; to: 0.25; duration: 250 }
                NumberAnimation { target: cameraButton; property: "opacity"; to: 1.0; duration: 250 }
            }
            */
        }
        z: 30
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
        }
    }
    RotationSensor {
        id: rotationSensor
        active: false
    }

    Connections {
        target: camera.imageCapture

        onImageSaved: {
            myImageModel.addImage(path);
            onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path});
        }
    }
    onStatusChanged: {
        if (status === PageStatus.Activating) {
            orientationSensor.active = true;
            rotationSensor.active = true;
            if (orientationSensor.reading.orientation === OrientationReading.TopUp ||
                orientationSensor.reading.orientation === OrientationReading.TopDown) {
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
        } else if (status === PageStatus.Deactivating) {
            orientationSensor.active = false;
            rotationSensor.active = false;
        } else if (status === PageStatus.Inactive) {
            orientationSensor.active = false;
            rotationSensor.active = false;
        }
    }
}


