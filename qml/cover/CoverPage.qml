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

/**
 * @brief Application's cover page
 */
CoverBackground {
    id: cover

    //property bool active: status === Cover.Active

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


