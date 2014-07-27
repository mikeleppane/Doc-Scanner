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
//import Sailfish.Media 1.0
//import com.jolla.camera 1.0
import "content"


Page {
    id: page
    allowedOrientations: Orientation.Portrait

    property real refPoint

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
    Connections {
        target: camera.imageCapture

        onImageSaved: {
            myImageModel.addImage(path);
            onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path});
        }
    }
}


