/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Sailfish.Media 1.0
import com.jolla.camera 1.0
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
                focusPointMode: Camera.FocusPointAuto
            }
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
            onClicked: {
                camera.digitalZoom -= 0.5
            }
        }
        IconButton {
            id: cameraButton
            width: page.width / 3
            icon.source: "image://theme/icon-camera-shutter-release"
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
            onClicked: {
                camera.digitalZoom += 0.5
            }
        }
        z: 30
    }

    Connections {
        target: camera.imageCapture

        onImageSaved: {
            onClicked: pageStack.push(Qt.resolvedUrl("ImagePage.qml"),{"path": path});
        }
    }
}


