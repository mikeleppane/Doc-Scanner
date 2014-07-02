import QtQuick 2.0
import Sailfish.Silica 1.0

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
                  "Version 1.0 <br/>" +
                  qsTr('Created by Mikko Leppänen') + '<br/>' +
                  qsTr('The source code is available at %1').
                  arg('<br/> <a href="https://github.com/MikeL83/Measure-Tool">%1</a>').arg("Project webpage")

            onLinkActivated: {
                Qt.openUrlExternally(link);
            }
        }
    }
}
