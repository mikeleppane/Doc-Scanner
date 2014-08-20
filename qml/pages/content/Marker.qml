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

/**
 * @brief Ui element item for video output marker
 */
Item {

    /**
     * @brief type:canvas Reference to canvas object
     */
    property alias canvasObj: canvas

    /**
     * @brief type:canvas.rotation Reference to canvas object's rotation
     */
    property alias canvasRotation: canvas.rotation

    /**
     * @brief type:int Line width of the marker
     */
    property int lineW: 10

    Canvas {
        id: canvas
        smooth: true
        width: 125
        height: 125
        onPaint: {

            var cxt1 = canvas.getContext('2d')
            cxt1.beginPath();
            cxt1.moveTo(0,0);
            cxt1.lineTo(canvas.width - 1,0);
            cxt1.lineWidth = lineW
            var gradient1 = cxt1.createLinearGradient(0,0,
                                                     canvas.width - 1,0)
            gradient1.addColorStop(0, "#339900")
            gradient1.addColorStop(0.25, "#33FF00")
            gradient1.addColorStop(0.5, 'transparent')
            gradient1.addColorStop(0.75, "#33FF00")
            gradient1.addColorStop(1.0, "#339900")
            cxt1.strokeStyle = gradient1;
            cxt1.stroke();

            //cxt1_out.globalCompositeOperation = 'destination-out'

            var cxt2 = canvas.getContext('2d')
            cxt2.beginPath();
            cxt2.moveTo(canvas.width - 1,0);
            cxt2.lineTo(canvas.width - 1, canvas.height - 1);
            cxt2.lineWidth = lineW
            var gradient2 = cxt2.createLinearGradient(canvas.width - 1, 0,
                                                     canvas.width - 1,canvas.height - 1)
            gradient2.addColorStop(0, "#339900")
            gradient2.addColorStop(0.25, "#33FF00")
            gradient2.addColorStop(0.5, 'transparent')
            gradient2.addColorStop(0.75, "#33FF00")
            gradient2.addColorStop(1.0, "#339900")
            cxt2.strokeStyle = gradient2;
            cxt2.stroke();

            var cxt3 = canvas.getContext('2d')
            cxt3.beginPath();
            cxt3.moveTo(canvas.width - 1, canvas.height - 1);
            cxt3.lineTo(0, canvas.height - 1);
            cxt3.lineWidth = lineW
            var gradient3 = cxt3.createLinearGradient(canvas.width - 1,canvas.height - 1,
                                                      0,canvas.height - 1)
            gradient3.addColorStop(0, "#339900")
            gradient3.addColorStop(0.25, "#33FF00")
            gradient3.addColorStop(0.5, 'transparent')
            gradient3.addColorStop(0.75, "#33FF00")
            gradient3.addColorStop(1.0, "#339900")
            cxt3.strokeStyle = gradient3;
            cxt3.stroke();

            var cxt4 = canvas.getContext('2d')
            cxt4.beginPath();
            cxt4.moveTo(0, canvas.height - 1);
            cxt4.lineTo(0, 0);
            cxt4.lineWidth = lineW
            var gradient4 = cxt4.createLinearGradient(0,canvas.height - 1,
                                                      0,0)
            gradient4.addColorStop(0, "#339900")
            gradient4.addColorStop(0.25, "#33FF00")
            gradient4.addColorStop(0.5, 'transparent')
            gradient4.addColorStop(0.75, "#33FF00")
            gradient4.addColorStop(1.0, "#339900")
            cxt4.strokeStyle = gradient4;
            cxt4.stroke();

            /*
            var outerRect = canvas.getContext('2d')
            outerRect.beginPath();
            outerRect.rect(1, 1, canvas.width - 3, canvas.height - 3);
            //context.fillStyle = 'transparent';
            //context.fill();
            outerRect.lineWidth = 1;
            outerRect.strokeStyle = '#0000B2';
            outerRect.stroke();

            var innerRect = canvas.getContext('2d')
            innerRect.beginPath();
            innerRect.rect(9, 9, canvas.width - lineW - 2, canvas.height - lineW - 2);
            //context.fillStyle = 'transparent';
            //context.fill();
            innerRect.lineWidth = 1;
            innerRect.strokeStyle = '#0000B2';
            innerRect.stroke();
            */

        }
        opacity: 0.75

    }
    transform: Translate{x: -canvas.width / 2;
                         y: -canvas.height / 2}
}
