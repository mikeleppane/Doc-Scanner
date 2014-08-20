import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages/scripts/Vars.js" as Vars

/**
 * @brief Options page to control multipage switch
 */
Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height

    SilicaFlickable {
        id: view
        anchors.fill: parent
        clip: true
        focus: true

        DialogHeader {
            id: dialogHeader
            width: parent.width
        }
        Column {
            id: col
            anchors {
                top: dialogHeader.bottom
                topMargin: Theme.paddingMedium
                horizontalCenter: parent.horizontalCenter
            }
            width: dialog.width
            spacing: Theme.paddingMedium

            TextArea {
                id: textarea
                focus: true
                font.family: "Verdana"
                width: parent.width
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: TextEdit.WordWrap
                text: "Multipage mode allows you to produce multipage PDFs. In this mode scanned images are " +
                      "added to a queue and afterwards when you are ready to produce PDF document all the items " +
                      "in the current queue will used in that document. " +
                      "After creating a pdf, the queue will be cleaned up."
                readOnly: true

            }
            TextSwitch {
                id: activationSwitch
                text: "Enable multipage scan"
                description: "Activates multipage mode"
                onCheckedChanged: {
                    Vars.ISMULTIPAGEENABLED = checked;
                }
            }
        }
    }
    onOpened: {
        activationSwitch.checked = Vars.ISMULTIPAGEENABLED;
    }
    /*
    onAccepted: {
    }
    */

}
