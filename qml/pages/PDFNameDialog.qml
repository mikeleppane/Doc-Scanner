import QtQuick 2.0
import Sailfish.Silica 1.0
import "scripts/Vars.js" as Vars

/**
 * @brief Dialog for allowing to give a name for the PDF file produced from
 * scanned image/images.
 */
Dialog {
    id: dialog
    width: Screen.width
    height: Screen.height

    acceptDestinationAction: PageStackAction.Replace
    acceptDestination: Qt.resolvedUrl("ImagePage.qml")
    acceptDestinationProperties: {"path": path, "isScannedImage": true}

    /**
     * @brief type:string Path to the image which was scanned
     */
    property string path

    SilicaFlickable {
        id: view
        anchors.fill: parent
        focus: true

        DialogHeader {
            id: dialogHeader
            width: parent.width
        }
        TextField {
             id: name
             anchors {
                 top: dialogHeader.bottom
                 topMargin: Theme.paddingLarge
             }
             focus: true
             width: parent.width
             font.pixelSize: Theme.fontSizeLarge
             anchors.margins: Theme.paddingSmall
             color: "steelblue"
             text: ""
             placeholderText: qsTr("Add name for the PDF file...")
             validator: RegExpValidator { regExp: /^[0-9\_\#\-A-Za-z]+$/ }
             inputMethodHints: Qt.ImhNoPredictiveText
             label: "New file name"
             errorHighlight: text ? !acceptableInput : false
        }
    }
    onAccepted: {
        if (Vars.ISMULTIPAGEENABLED) {
            logic.convertPagesToPDF(name.text, Vars.ISPORTRAIT);
        } else {
            logic.convertToPDF(path, name.text, Vars.ISPORTRAIT);
        }
    }
    onRejected: {
        pageStack.replace(Qt.resolvedUrl("ImagePage.qml"),
                          {"path": path, "isScannedImage": true});
    }
}
