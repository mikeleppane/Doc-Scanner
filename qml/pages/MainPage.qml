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

    //allowedOrientations: Orientation.Landscape

    SilicaFlickable {
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
    Item {
        id: cameraOutput   
        width: Screen.width
        height: Screen.height

        VideoOutput {
            id: vOut
            anchors.fill: parent
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

            //orientation: page.orientation === Orientation.Portrait ? 0 : 90 GStreamer
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
        anchors.centerIn: cameraOutput
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
            id: zoomOut
            width: page.width / 3
            icon.source: "image://theme/icon-camera-zoom-out"
            scale: 1.5
            onClicked: {
                camera.digitalZoom -= 0.5
            }
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
        IconButton {
            id: zoomIn
            width: page.width / 3
            icon.source: "image://theme/icon-camera-zoom-in"
            scale: 1.5
            onClicked: {
                camera.digitalZoom += 0.5
            }
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


