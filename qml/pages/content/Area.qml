import QtQuick 2.0
import "../scripts/Vars.js" as Vars

Item {
    property int lineW: 2
    property alias cHeight: canvas.height
    property alias cWidth: canvas.width
    property alias canvasObj: canvas
    property int cx: parseInt(canvas.circle1LastX)
    property int cy: parseInt(canvas.circle1LastY)
    property int cw: parseInt(Math.abs(canvas.circle1LastX - canvas.circle2LastX)) >
                     parseInt(Math.abs(canvas.circle3LastX - canvas.circle4LastX)) ?
                     parseInt(Math.abs(canvas.circle1LastX - canvas.circle2LastX)) :
                     parseInt(Math.abs(canvas.circle3LastX - canvas.circle4LastX))
    property int ch: parseInt(Math.abs(canvas.circle1LastY - canvas.circle4LastY)) >
                     parseInt(Math.abs(canvas.circle2LastY - canvas.circle3LastY)) ?
                     parseInt(Math.abs(canvas.circle1LastY - canvas.circle4LastY)) :
                     parseInt(Math.abs(canvas.circle2LastY - canvas.circle3LastY))

    property string circleFillStyleOff: 'transparent'
    property int circle1LineW: 2
    property int circle2LineW: 2
    property int circle3LineW: 2
    property int circle4LineW: 2

    property int line1LineW: 2
    property int line2LineW: 2
    property int line3LineW: 2
    property int line4LineW: 2

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
        }

        opacity: 0.5

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                switch (findCircle(mouseX, mouseY)) {
                    case 1:
                        circle1LineW *= 4
                        break;
                    case 2:
                        circle2LineW *= 4
                        break;
                    case 3:
                        circle3LineW *= 4
                        break;
                    case 4:
                        circle4LineW *= 4
                        break;
                }
                switch (findLine(mouseX, mouseY)) {
                    case 1:
                        line1LineW *= 4
                        break;
                    case 2:
                        line2LineW *= 4
                        break;
                    case 3:
                        line3LineW *= 4
                        break;
                    case 4:
                        line4LineW *= 4
                        break;
                }

            }
            onMouseXChanged: {
                //Vars.CANBACKNAVIGATE = false;
                switch (findCircle(mouseX, mouseY)) {
                    case 1:
                        canvas.circle1LastX = mouseX;
                        //canvas.circle1LastY = mouseY;
                        break;

                    case 2:
                        canvas.circle2LastX = mouseX;
                        //canvas.circle2LastY = mouseY;
                        break;
                    case 3:
                        canvas.circle3LastX = mouseX;
                        //canvas.circle3LastY = mouseY;
                        break;

                    case 4:
                        canvas.circle4LastX = mouseX;
                        //canvas.circle4LastY = mouseY;
                        break;
                }
                switch (findLine(mouseX, mouseY)) {
                    case 1:
                        canvas.circle1LastY = mouseY;
                        canvas.circle2LastY = mouseY;
                        break;

                    case 2:
                        canvas.circle2LastX = mouseX;
                        canvas.circle3LastX = mouseX;
                        break;
                    case 3:
                        canvas.circle3LastY = mouseY;
                        canvas.circle4LastY = mouseY;
                        break;

                    case 4:
                        canvas.circle4LastX = mouseX;
                        canvas.circle1LastX = mouseX;
                        break;
                }
            }

            onMouseYChanged: {
                //Vars.CANBACKNAVIGATE = false;
                switch (findCircle(mouseX, mouseY)) {
                    case 1:
                        //canvas.circle1LastX = mouseX;
                        canvas.circle1LastY = mouseY;
                        break;

                    case 2:
                        //canvas.circle2LastX = mouseX;
                        canvas.circle2LastY = mouseY;
                        break;
                    case 3:
                        //canvas.circle3LastX = mouseX;
                        canvas.circle3LastY = mouseY;
                        break;

                    case 4:
                        //canvas.circle4LastX = mouseX;
                        canvas.circle4LastY = mouseY;
                        break;
                }
                switch (findLine(mouseX, mouseY)) {
                    case 1:
                        canvas.circle1LastY = mouseY;
                        canvas.circle2LastY = mouseY;
                        break;

                    case 2:
                        canvas.circle2LastX = mouseX;
                        canvas.circle3LastX = mouseX;
                        break;

                    case 3:
                        canvas.circle3LastY = mouseY;
                        canvas.circle4LastY = mouseY;
                        break;

                    case 4:
                        canvas.circle4LastX = mouseX;
                        canvas.circle1LastX = mouseX;
                        break;
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
                canvas.requestPaint();
            }
            onReleased: {
                resetLineW();
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

    function nullifyPoints() {
        canvas.radius = 0;
        canvas.circle1LastX = 0;
        canvas.circle1LastY = 0;
        canvas.circle2LastX = 0;
        canvas.circle2LastY = 0;
        canvas.circle3LastX = 0;
        canvas.circle3LastY = 0;
        canvas.circle4LastX = 0;
        canvas.circle4LastY = 0;
    }

    function resetTouchPoints() {
        canvas.radius = 40;
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
}
