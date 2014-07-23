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

function createAreaObject(cw,ch) {
    var component = Qt.createComponent(Qt.resolvedUrl("../content/Area.qml"));
    if (component.status === Component.Ready) {
        var object = component.createObject(page, {"cHeight": ch, "cWidth": cw});
        if (object === null) {
            console.log(qsTr("error creating Area object..."));
            console.log(component.errorString());
            return null;
        }
        return object;
    } else if (component.status === Component.Error) {
        console.log(qsTr("error loading Area component"));
        console.log(component.errorString());
    }
}
