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
import "../scripts/Vars.js" as Vars

Item {
    property int lineW: 2
    property alias cHeight: canvas.height
    property alias cWidth: canvas.width
    property alias canvasObj: canvas
    property int cx: Math.ceil(canvas.circle1LastX)
    property int cy: Math.ceil(canvas.circle1LastY)
    property int cw: Math.ceil(Math.abs(canvas.circle1LastX - canvas.circle2LastX)) >
                     Math.ceil(Math.abs(canvas.circle3LastX - canvas.circle4LastX)) ?
                     Math.ceil(Math.abs(canvas.circle1LastX - canvas.circle2LastX)) :
                     Math.ceil(Math.abs(canvas.circle3LastX - canvas.circle4LastX))
    property int ch: Math.ceil(Math.abs(canvas.circle1LastY - canvas.circle4LastY)) >
                     Math.ceil(Math.abs(canvas.circle2LastY - canvas.circle3LastY)) ?
                     Math.ceil(Math.abs(canvas.circle1LastY - canvas.circle4LastY)) :
                     Math.ceil(Math.abs(canvas.circle2LastY - canvas.circle3LastY))

    property string circleFillStyleOff: 'transparent'

    property int circle1LineW: 2
    property int circle2LineW: 2
    property int circle3LineW: 2
    property int circle4LineW: 2

    property int line1LineW: 2
    property int line2LineW: 2
    property int line3LineW: 2
    property int line4LineW: 2

    property bool circle1Pressed: false
    property bool circle2Pressed: false
    property bool circle3Pressed: false
    property bool circle4Pressed: false

    property bool line1Pressed: false
    property bool line2Pressed: false
    property bool line3Pressed: false
    property bool line4Pressed: false

    z: 10

    Canvas {
        id: canvas
        width: 350
        height: 350

        property int radius: 40
        property int space: 50
        property real circle1LastX: radius + space
        property real circle1LastY: radius + space
        property real circle2LastX: canvas.width - radius*5 + space
        property real circle2LastY: radius + space
        property real circle3LastX: canvas.width - radius*5 + space
        property real circle3LastY: canvas.height - radius*5 + space
        property real circle4LastX: radius + space
        property real circle4LastY: canvas.height - radius*5 + space

        property var cxtCircle1
        property var cxtLine1
        property var cxtCircle2
        property var cxtLine2
        property var cxtCircle3
        property var cxtLine3
        property var cxtCircle4
        property var cxtLine4

        property var cxtDashLine1
        property var cxtDashLine2
        property var cxtDashLine3
        property var cxtDashLine4
        property var cxtDashLine5
        property var cxtDashLine6

        property var pointsDashLine11: calculateLineCentralPoint(circle1LastX, circle1LastY,
                                                                 circle2LastX, circle2LastY);
        property var pointsDashLine12: calculateLineCentralPoint(circle3LastX, circle3LastY,
                                                                 circle4LastX, circle4LastY);
        property var pointsDashLine31: calculateLineCentralPoint(circle1LastX, circle1LastY,
                                                                 pointsDashLine11[0], pointsDashLine11[1]);
        property var pointsDashLine32: calculateLineCentralPoint(circle4LastX, circle4LastY,
                                                                 pointsDashLine12[0], pointsDashLine12[1]);
        property var pointsDashLine41: calculateLineCentralPoint(pointsDashLine11[0], pointsDashLine11[1],
                                                                 circle2LastX, circle2LastY);
        property var pointsDashLine42: calculateLineCentralPoint(pointsDashLine12[0], pointsDashLine12[1],
                                                                 circle3LastX, circle3LastY);
        property var pointsDashLine21: calculateLineCentralPoint(canvas.circle1LastX, canvas.circle1LastY,
                                                                 canvas.circle4LastX, canvas.circle4LastY);
        property var pointsDashLine22: calculateLineCentralPoint(canvas.circle2LastX, canvas.circle2LastY,
                                                                 canvas.circle3LastX, canvas.circle3LastY);
        property var pointsDashLine51: calculateLineCentralPoint(canvas.circle1LastX, canvas.circle1LastY,
                                                                 pointsDashLine21[0], pointsDashLine21[1]);
        property var pointsDashLine52: calculateLineCentralPoint(canvas.circle2LastX, canvas.circle2LastY,
                                                                 pointsDashLine22[0], pointsDashLine22[1]);
        property var pointsDashLine61: calculateLineCentralPoint(pointsDashLine21[0], pointsDashLine21[1],
                                                                 canvas.circle4LastX, canvas.circle4LastY);
        property var pointsDashLine62: calculateLineCentralPoint(pointsDashLine22[0], pointsDashLine22[1],
                                                                 canvas.circle3LastX, canvas.circle3LastY);
        smooth: true
        onPaint: {
            cxtLine1 = canvas.getContext('2d')
            cxtLine1.beginPath();
            cxtLine1.moveTo(circle1LastX, circle1LastY);
            cxtLine1.lineTo(circle2LastX, circle2LastY);
            cxtLine1.lineWidth = line1LineW
            cxtLine1.strokeStyle = '#ADFF2F';
            cxtLine1.stroke();

            cxtLine2 = canvas.getContext('2d')
            cxtLine2.beginPath();
            cxtLine2.moveTo(circle2LastX, circle2LastY);
            cxtLine2.lineTo(circle3LastX, circle3LastY);
            cxtLine2.lineWidth = line2LineW
            cxtLine2.strokeStyle = '#ADFF2F';
            cxtLine2.stroke();

            cxtLine3 = canvas.getContext('2d')
            cxtLine3.beginPath();
            cxtLine3.moveTo(circle3LastX, circle3LastY);
            cxtLine3.lineTo(circle4LastX, circle4LastY);
            cxtLine3.lineWidth = line3LineW
            cxtLine3.strokeStyle = '#ADFF2F';
            cxtLine3.stroke();


            cxtLine4 = canvas.getContext('2d')
            cxtLine4.beginPath();
            cxtLine4.moveTo(circle4LastX, circle4LastY);
            cxtLine4.lineTo(circle1LastX, circle1LastY);
            cxtLine4.lineWidth = line4LineW
            cxtLine4.strokeStyle = '#ADFF2F';
            cxtLine4.stroke();

            cxtCircle1 = canvas.getContext('2d')
            cxtCircle1.beginPath();
            cxtCircle1.arc(circle1LastX, circle1LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle1.fillStyle = 'transparent';
            cxtCircle1.fill();
            cxtCircle1.lineWidth = circle1LineW;
            cxtCircle1.strokeStyle = '#003399';
            cxtCircle1.stroke();

            cxtCircle2 = canvas.getContext('2d')
            cxtCircle2.beginPath();
            cxtCircle2.arc(circle2LastX, circle2LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle2.fillStyle = 'transparent';
            cxtCircle2.fill();
            cxtCircle2.lineWidth = circle2LineW;
            cxtCircle2.strokeStyle = '#003399';
            cxtCircle2.stroke();

            cxtCircle3 = canvas.getContext('2d')
            cxtCircle3.beginPath();
            cxtCircle3.arc(circle3LastX, circle3LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle3.fillStyle = 'transparent';
            cxtCircle3.fill();
            cxtCircle3.lineWidth = circle3LineW;
            cxtCircle3.strokeStyle = '#003399';
            cxtCircle3.stroke();

            cxtCircle4 = canvas.getContext('2d')
            cxtCircle4.beginPath();
            cxtCircle4.arc(circle4LastX, circle4LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle4.fillStyle = 'transparent';
            cxtCircle4.fill();
            cxtCircle4.lineWidth = circle4LineW;
            cxtCircle4.strokeStyle = '#003399';
            cxtCircle4.stroke();

            cxtDashLine1 = canvas.getContext('2d');
            cxtDashLine2 = canvas.getContext('2d');
            cxtDashLine3 = canvas.getContext('2d');
            cxtDashLine4 = canvas.getContext('2d');
            cxtDashLine5 = canvas.getContext('2d');
            cxtDashLine6 = canvas.getContext('2d');

            createDashedLine(cxtDashLine1, pointsDashLine11[0],
                             pointsDashLine11[1], pointsDashLine12[0],
                             pointsDashLine12[1], 5);

            createDashedLine(canvas.cxtDashLine2, pointsDashLine21[0],
                             pointsDashLine21[1], pointsDashLine22[0],
                             pointsDashLine22[1], 5);

            createDashedLine(canvas.cxtDashLine3, pointsDashLine31[0],
                             pointsDashLine31[1], pointsDashLine32[0],
                             pointsDashLine32[1], 5);

            createDashedLine(canvas.cxtDashLine4, pointsDashLine41[0],
                             pointsDashLine41[1], pointsDashLine42[0],
                             pointsDashLine42[1], 5);

            createDashedLine(canvas.cxtDashLine5, pointsDashLine51[0],
                             pointsDashLine51[1], pointsDashLine52[0],
                             pointsDashLine52[1], 5);

            createDashedLine(canvas.cxtDashLine6, pointsDashLine61[0],
                             pointsDashLine61[1], pointsDashLine62[0],
                             pointsDashLine62[1], 5);

        }

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                switch (findCircle(mouseX, mouseY)) {
                    case 1:
                        circle1LineW *= 4
                        circle1Pressed = true;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        line1Pressed = false;
                        line2Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        break;
                    case 2:
                        circle2LineW *= 4
                        circle2Pressed = true;
                        circle1Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        line1Pressed = false;
                        line2Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        break;
                    case 3:
                        circle3LineW *= 4
                        circle3Pressed = true;
                        circle2Pressed = false;
                        circle1Pressed = false;
                        circle4Pressed = false;
                        line1Pressed = false;
                        line2Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        break;
                    case 4:
                        circle4LineW *= 4
                        circle4Pressed = true;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle1Pressed = false;
                        line1Pressed = false;
                        line2Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        break;
                }
                switch (findLine(mouseX, mouseY)) {
                    case 1:
                        line1LineW *= 4
                        line1Pressed = true;
                        line2Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        circle1Pressed = false;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        break;
                    case 2:
                        line2LineW *= 4
                        line2Pressed = true;
                        line1Pressed = false;
                        line3Pressed = false;
                        line4Pressed = false;
                        circle1Pressed = false;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        break;
                    case 3:
                        line3LineW *= 4
                        line3Pressed = true;
                        line2Pressed = false;
                        line1Pressed = false;
                        line4Pressed = false;
                        circle1Pressed = false;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        break;
                    case 4:
                        line4LineW *= 4
                        line4Pressed = true;
                        line2Pressed = false;
                        line3Pressed = false;
                        line1Pressed = false;
                        circle1Pressed = false;
                        circle2Pressed = false;
                        circle3Pressed = false;
                        circle4Pressed = false;
                        break;
                }

            }
            onMouseXChanged: {
                if (circle1Pressed) {
                    canvas.circle1LastX = mouseX;
                } else if (circle2Pressed) {
                    canvas.circle2LastX = mouseX;
                } else if (circle3Pressed) {
                    canvas.circle3LastX = mouseX;
                } else if (circle4Pressed) {
                    canvas.circle4LastX = mouseX;
                }

                if (line1Pressed) {
                    canvas.circle1LastY = mouseY;
                    canvas.circle2LastY = mouseY;
                } else if (line2Pressed) {
                    canvas.circle2LastX = mouseX;
                    canvas.circle3LastX = mouseX;
                } else if (line3Pressed) {
                    canvas.circle3LastY = mouseY;
                    canvas.circle4LastY = mouseY;
                } else if (line4Pressed) {
                    canvas.circle4LastX = mouseX;
                    canvas.circle1LastX = mouseX;
                }
            }

            onMouseYChanged: {
                if (circle1Pressed) {
                    canvas.circle1LastY = mouseY;
                } else if (circle2Pressed) {
                    canvas.circle2LastY = mouseY;
                } else if (circle3Pressed) {
                    canvas.circle3LastY = mouseY;
                } else if (circle4Pressed) {
                    canvas.circle4LastY = mouseY;
                }

                if (line1Pressed) {
                    canvas.circle1LastY = mouseY;
                    canvas.circle2LastY = mouseY;
                } else if (line2Pressed) {
                    canvas.circle2LastX = mouseX;
                    canvas.circle3LastX = mouseX;
                } else if (line3Pressed) {
                    canvas.circle3LastY = mouseY;
                    canvas.circle4LastY = mouseY;
                } else if (line4Pressed) {
                    canvas.circle4LastX = mouseX;
                    canvas.circle1LastX = mouseX;
                }
            }

            onPositionChanged: {
                canvas.cxtCircle1.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtLine1.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtCircle2.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtLine2.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtCircle3.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtLine3.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtCircle4.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtLine4.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine1.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine2.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine3.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine4.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine5.clearRect(0, 0, canvas.width, canvas.height);
                canvas.cxtDashLine6.clearRect(0, 0, canvas.width, canvas.height);
                canvas.requestPaint();
            }
            onReleased: {
                resetLineW();
                line1Pressed = false;
            }
        }
    }
    function findCircle(x,y) {
        /*
        var distances = [
            {itemNum: 1, touched: Math.sqrt(Math.pow(canvas.circle1LastX - x,2) +
                                 Math.pow(canvas.circle1LastY - y,2)) <= canvas.radius + 5},
            {itemNum: 2, touched: Math.sqrt(Math.pow(canvas.circle2LastX - x,2) +
                                 Math.pow(canvas.circle2LastY - y,2)) <= canvas.radius + 5},
            {itemNum: 3, touched: Math.sqrt(Math.pow(canvas.circle3LastX - x,2) +
                                 Math.pow(canvas.circle3LastY - y,2)) <= canvas.radius + 5},
            {itemNum: 4, touched: Math.sqrt(Math.pow(canvas.circle4LastX - x,2) +
                                 Math.pow(canvas.circle4LastY - y,2)) <= canvas.radius + 5}
        ];

        distances.sort(function (a, b) {
            if (a.dist > b.dist)
              return 1;
            if (a.dist < b.dist)
              return -1;
            return 0;
        });

        */

        var circleArray = [Math.sqrt(Math.pow(canvas.circle1LastX - x,2) +
                           Math.pow(canvas.circle1LastY - y,2)) <= canvas.radius + 5,
                           Math.sqrt(Math.pow(canvas.circle2LastX - x,2) +
                           Math.pow(canvas.circle2LastY - y,2)) <= canvas.radius + 5,
                           Math.sqrt(Math.pow(canvas.circle3LastX - x,2) +
                           Math.pow(canvas.circle3LastY - y,2)) <= canvas.radius + 5,
                           Math.sqrt(Math.pow(canvas.circle4LastX - x,2) +
                           Math.pow(canvas.circle4LastY - y,2)) <= canvas.radius + 5
        ];

        return circleArray.indexOf(true) + 1;
    }

    function findLine(x,y) {

        var lineArray = [Math.sqrt(Math.pow(canvas.circle1LastX - x,2) +
                         Math.pow(canvas.circle1LastY - y,2)) > canvas.radius + 10 &&
                         Math.sqrt(Math.pow(canvas.circle2LastX - x,2) +
                          Math.pow(canvas.circle2LastY - y,2)) > canvas.radius + 10 &&
                         calculatePointLineDistance(x,y,1) < 20,
                         Math.sqrt(Math.pow(canvas.circle2LastX - x,2) +
                         Math.pow(canvas.circle2LastY - y,2)) > canvas.radius + 10 &&
                         Math.sqrt(Math.pow(canvas.circle3LastX - x,2) +
                         Math.pow(canvas.circle3LastY - y,2)) > canvas.radius + 10 &&
                         calculatePointLineDistance(x,y,2) < 20,
                         Math.sqrt(Math.pow(canvas.circle3LastX - x,2) +
                         Math.pow(canvas.circle3LastY - y,2)) > canvas.radius + 10 &&
                         Math.sqrt(Math.pow(canvas.circle4LastX - x,2) +
                         Math.pow(canvas.circle4LastY - y,2)) > canvas.radius + 10 &&
                         calculatePointLineDistance(x,y,3) < 20,
                         Math.sqrt(Math.pow(canvas.circle4LastX - x,2) +
                         Math.pow(canvas.circle4LastY - y,2)) > canvas.radius + 10 &&
                         Math.sqrt(Math.pow(canvas.circle1LastX - x,2) +
                         Math.pow(canvas.circle1LastY - y,2)) > canvas.radius + 10 &&
                         calculatePointLineDistance(x,y,4) < 20
                         ];

        return lineArray.indexOf(true) + 1;
    }

    function resetTouchPoints() {
        canvas.radius = 40;
        canvas.space = 50;
        canvas.circle1LastX = canvas.radius + canvas.space;
        canvas.circle1LastY = canvas.radius + canvas.space;
        canvas.circle2LastX = canvas.width - canvas.radius * 4 + canvas.space;
        canvas.circle2LastY = canvas.radius + canvas.space;
        canvas.circle3LastX = canvas.width - canvas.radius * 4 + canvas.space;
        canvas.circle3LastY = canvas.height - canvas.radius * 4 + canvas.space;
        canvas.circle4LastX = canvas.radius + canvas.space;
        canvas.circle4LastY = canvas.height - canvas.radius * 4 + canvas.space;
    }

    function resetLineW() {
        circle1LineW = 2;
        circle2LineW = 2;
        circle3LineW = 2;
        circle4LineW = 2;

        line1LineW = 2;
        line2LineW = 2;
        line3LineW = 2;
        line4LineW = 2;

        circle1Pressed = false;
        circle2Pressed = false;
        circle3Pressed = false;
        circle4Pressed = false;
        line1Pressed = false;
        line2Pressed = false;
        line3Pressed = false;
        line4Pressed = false;
    }

    function calculatePointLineDistance(x, y, lineNum) {
        // d = abs(det(x2 - x1, x1 - x0)) / norm(x2 - x1)
        switch (lineNum) {
         case 1:
             var d1 = Math.abs((canvas.circle2LastX - canvas.circle1LastX) * (canvas.circle1LastY - y) -
                                (canvas.circle1LastX - x) * (canvas.circle2LastY - canvas.circle1LastY)) /
                     Math.sqrt(Math.pow(canvas.circle2LastX - canvas.circle1LastX,2) +
                                                        Math.pow(canvas.circle2LastY - canvas.circle1LastY,2))
             return d1;
         case 2:
             var d2 = Math.abs((canvas.circle3LastX - canvas.circle2LastX) * (canvas.circle2LastY - y) -
                                (canvas.circle2LastX - x) * (canvas.circle3LastY - canvas.circle2LastY)) /
                      Math.sqrt(Math.pow(canvas.circle3LastX - canvas.circle2LastX,2) +
                                                        Math.pow(canvas.circle3LastY - canvas.circle2LastY,2))
             return d2;
         case 3:
             var d3 = Math.abs((canvas.circle4LastX - canvas.circle3LastX) * (canvas.circle3LastY - y) -
                                (canvas.circle3LastX - x) * (canvas.circle4LastY - canvas.circle3LastY)) /
                      Math.sqrt(Math.pow(canvas.circle4LastX - canvas.circle3LastX,2) +
                                                        Math.pow(canvas.circle4LastY - canvas.circle3LastY,2))
             return d3;
         case 4:
             var d4 = Math.abs((canvas.circle1LastX - canvas.circle4LastX) * (canvas.circle4LastY - y) -
                                (canvas.circle4LastX - x) * (canvas.circle1LastY - canvas.circle4LastY)) /
                      Math.sqrt(Math.pow(canvas.circle1LastX - canvas.circle4LastX,2) +
                                                        Math.pow(canvas.circle1LastY - canvas.circle4LastY,2))
             return d4;
        }
    }

    function createDashedLine(cxt, x1, y1, x2, y2, dashLen) {
        cxt.beginPath();
        cxt.moveTo(x1, y1);

        var dX = x2 - x1;
        var dY = y2 - y1;
        var dashes = Math.floor(Math.sqrt(dX * dX + dY * dY) / dashLen);
        var dashX = dX / dashes;
        var dashY = dY / dashes;

        var q = 0;
        while (q++ < dashes) {
            x1 += dashX;
            y1 += dashY;
            cxt[q % 2 == 0 ? 'moveTo' : 'lineTo'](x1, y1);
        }
        cxt[q % 2 == 0 ? 'moveTo' : 'lineTo'](x2, y2);

        cxt.lineWidth = 2;
        cxt.strokeStyle = '#FFC459';
        cxt.stroke();
        cxt.closePath();
    }

    function calculateLineCentralPoint(x1, y1, x2, y2) {

        var Px = 0;
        var Py = 0;
        var dX = x2 - x1;
        var dY = y2 - y1;

        if (dX < 0) {
             Px = x1 - Math.floor(Math.abs(x2 - x1) / 2)
        } else {
            Px = x1 + Math.floor(Math.abs(x2 - x1) / 2)
        }
        if (dY < 0) {
            Py = y1 - Math.floor(Math.abs(y2 - y1) / 2)
        } else {
            Py = y1 + Math.floor(Math.abs(y2 - y1) / 2)
        }
        return [Px, Py];
    }
}
