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

import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    id: cover
    property bool active: status === Cover.Active

    Image {
        id: icon
        horizontalAlignment: Image.AlignHCenter
        source: "qrc:/images/images/harbour-docscanner.png"
        scale: 1.5
        smooth: true
        anchors {
            top: parent.top
            topMargin: Theme.paddingLarge * 2
            horizontalCenter: parent.horizontalCenter
        }
        z: 10
    }
    Column {
        spacing: 0
        anchors {
            left: parent.left
            bottom: parent.bottom
        }
        Label {
            id: label1
            text: "Doc"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge * 2.5
            opacity: 0.5
        }
        Label {
            id: label2
            anchors {
                horizontalCenter: label1.horizontalCenter
            }
            text: "Scanner"
            color: Theme.secondaryHighlightColor
            font.pixelSize: Theme.fontSizeLarge * 2.5
            opacity: 0.5
        }
        transform: [
                   Rotation {angle: -50},
                   Translate {y: 75}
        ]
    }
    /*
    onActiveChanged: {
        if (active)) {
        } else {
        }
    }
    */
}


