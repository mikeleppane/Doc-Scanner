import QtQuick 2.0
import Sailfish.Silica 1.0

/**
 * @brief Ui element item for showing zoom level
 */
Item {
    id: root
    width: Screen.width

    /**
     * @brief type:root reference to root item
     */
    property alias rootItem: root

    /**
     * @brief type:real Digital zoom factor
     */
    property real factor: 0.0

    /**
     * @brief type:string Is user zooming in or out
     */
    property string zoomDir: ""

    Label {
        id: label
        width: Screen.width
        anchors {
            bottom: rec1.top
            bottomMargin: 10
            horizontalCenter: rec1.horizontalCenter
        }
        horizontalAlignment: Text.AlignHCenter
        text: "zooming " + zoomDir
        font.pixelSize: Theme.fontSizeTiny
        color: "#339900"
    }

    Rectangle {
        id: rec1
        anchors.horizontalCenter: parent.horizontalCenter
        width: Screen.width * 0.75
        height: 3
        color: "#FFB2B2"
    }

    Rectangle {
        id: rec2
        anchors {
            left: rec1.left
        }

        width: Screen.width * 0.75 * factor
        height: 3
        color: "#FF0000"
        z: 2

        Behavior on width { SmoothedAnimation { velocity: 1000 } }
    }

    onFactorChanged: {
        if (factor > 0.99) {
            factor = 1.0;
            label.text = "max zoom"
        } else if (factor < 0.01) {
            factor = 0.0;
            label.text = "min zoom"
        } else {
            label.text = "zooming " + zoomDir
        }
    }
}

