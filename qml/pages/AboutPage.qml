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
import "scripts/Vars.js" as Vars

Page {
    SilicaFlickable {
        anchors.fill: parent;
        Image {
            id: img
            anchors.centerIn: parent
            sourceSize.width: 86
            sourceSize.height: 86
            horizontalAlignment: Image.AlignRight
            source: "qrc:/images/images/harbour-docscanner.png"
            smooth: true
            scale: 2

            transform: Translate{y: -Theme.paddingMedium}
        }
        Column {
            id: col
            spacing: 5
            anchors {
                top: img.bottom
                topMargin: Theme.paddingLarge
                horizontalCenter: parent.horizontalCenter
            }
            Label {
                id: label1
                text: qsTr("Doc Scanner")
                horizontalAlignment: Text.AlignHCenter;
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeExtraLarge * 1.5
            }
            Label {
                text: qsTr("Sailfish OS")
                anchors.horizontalCenter: label1.horizontalCenter
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
        Text {
            anchors {
                top: col.bottom
                topMargin: Theme.paddingLarge * 2
            }
            width: parent.width;
            wrapMode: Text.WrapAtWordBoundaryOrAnywhere;
            horizontalAlignment: Text.AlignHCenter;
            textFormat: Text.RichText;
            font.pixelSize: Theme.fontSizeMedium
            color: "white"
            text: "<style>a:link { color: " + Theme.highlightColor + "; }</style>" +
                  qsTr("Version %1").arg(Vars.VERSION) + "<br/>" +
                  qsTr('Created by Mikko Leppänen') + '<br/>' +
                  qsTr('The source code is available at %1').
                  arg('<br/> <a href="https://github.com/MikeL83/Doc-Scanner">%1</a>').arg("Project webpage")

            onLinkActivated: {
                Qt.openUrlExternally(link);
            }
        }
    }
}
