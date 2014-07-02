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
    property int circleLineW: 2

    Canvas {
        id: canvas
        width: 350
        height: 350

        property int radius: 25
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
            cxtLine1.lineWidth = lineW
            cxtLine1.strokeStyle = '#ADFF2F';
            cxtLine1.stroke();

            cxtLine2 = canvas.getContext('2d')
            cxtLine2.beginPath();
            cxtLine2.moveTo(circle2LastX, circle2LastY);
            cxtLine2.lineTo(circle3LastX, circle3LastY);
            cxtLine2.lineWidth = lineW
            cxtLine2.strokeStyle = '#ADFF2F';
            cxtLine2.stroke();

            cxtLine3 = canvas.getContext('2d')
            cxtLine3.beginPath();
            cxtLine3.moveTo(circle3LastX, circle3LastY);
            cxtLine3.lineTo(circle4LastX, circle4LastY);
            cxtLine3.lineWidth = lineW
            cxtLine3.strokeStyle = '#ADFF2F';
            cxtLine3.stroke();


            cxtLine4 = canvas.getContext('2d')
            cxtLine4.beginPath();
            cxtLine4.moveTo(circle4LastX, circle4LastY);
            cxtLine4.lineTo(circle1LastX, circle1LastY);
            cxtLine4.lineWidth = lineW
            cxtLine4.strokeStyle = '#ADFF2F';
            cxtLine4.stroke();

            cxtCircle1 = canvas.getContext('2d')
            cxtCircle1.beginPath();
            cxtCircle1.arc(circle1LastX, circle1LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle1.fillStyle = 'transparent';
            cxtCircle1.fill();
            cxtCircle1.lineWidth = circleLineW;
            cxtCircle1.strokeStyle = '#003399';
            cxtCircle1.stroke();

            cxtCircle2 = canvas.getContext('2d')
            cxtCircle2.beginPath();
            cxtCircle2.arc(circle2LastX, circle2LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle2.fillStyle = 'transparent';
            cxtCircle2.fill();
            cxtCircle2.lineWidth = circleLineW;
            cxtCircle2.strokeStyle = '#003399';
            cxtCircle2.stroke();

            cxtCircle3 = canvas.getContext('2d')
            cxtCircle3.beginPath();
            cxtCircle3.arc(circle3LastX, circle3LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle3.fillStyle = 'transparent';
            cxtCircle3.fill();
            cxtCircle3.lineWidth = circleLineW;
            cxtCircle3.strokeStyle = '#003399';
            cxtCircle3.stroke();

            cxtCircle4 = canvas.getContext('2d')
            cxtCircle4.beginPath();
            cxtCircle4.arc(circle4LastX, circle4LastY, radius, 0, 2 * Math.PI, false);
            cxtCircle4.fillStyle = 'transparent';
            cxtCircle4.fill();
            cxtCircle4.lineWidth = circleLineW;
            cxtCircle4.strokeStyle = '#003399';
            cxtCircle4.stroke();
        }

        opacity: 0.5

        MouseArea {
            id: area
            anchors.fill: parent
            onPressed: {
                switch (findMin(mouseX, mouseY)) {
                    case 1:
                        canvas.circle1LastX = mouseX;
                        canvas.circle1LastY = mouseY;
                        break;

                    case 2:
                        canvas.circle2LastX = mouseX;
                        canvas.circle2LastY = mouseY;
                        break;
                    case 3:
                        canvas.circle3LastX = mouseX;
                        canvas.circle3LastY = mouseY;
                        break;

                    case 4:
                        canvas.circle4LastX = mouseX;
                        canvas.circle4LastY = mouseY;
                        break;
                }
            }
            onMouseXChanged: {
                Vars.CANBACKNAVIGATE = false;
                //changeCircleLineW(6)
                switch (findMin(mouseX, mouseY)) {
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
            }

            onMouseYChanged: {
                Vars.CANBACKNAVIGATE = false;
                //changeCircleLineW(6)
                switch (findMin(mouseX, mouseY)) {
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
                circleLineW = 6;
                canvas.requestPaint();
            }
            onReleased: {
                circleLineW = 2;
                Vars.CANBACKNAVIGATE = true;
            }
        }
    }
    function findMin(x,y) {
        var distances = [
            {itemNum: 1, dist: Math.sqrt(Math.pow(canvas.circle1LastX - x,2) +
                                 Math.pow(canvas.circle1LastY - y,2))},
            {itemNum: 2, dist: Math.sqrt(Math.pow(canvas.circle2LastX - x,2) +
                                 Math.pow(canvas.circle2LastY - y,2))},
            {itemNum: 3, dist: Math.sqrt(Math.pow(canvas.circle3LastX - x,2) +
                                 Math.pow(canvas.circle3LastY - y,2))},
            {itemNum: 4, dist: Math.sqrt(Math.pow(canvas.circle4LastX - x,2) +
                                 Math.pow(canvas.circle4LastY - y,2))}
        ];

        distances.sort(function (a, b) {
            if (a.dist > b.dist)
              return 1;
            if (a.dist < b.dist)
              return -1;
            return 0;
        });

        return distances[0].itemNum
    }

    function resetTouchPoints() {
        canvas.circle1LastX = canvas.radius + canvas.space;
        canvas.circle1LastY = canvas.radius + canvas.space
        canvas.circle2LastX = canvas.width - canvas.radius*5 + canvas.space
        canvas.circle2LastY = canvas.radius + canvas.space
        canvas.circle3LastX = canvas.width - canvas.radius*5 + canvas.space
        canvas.circle3LastY = canvas.height - canvas.radius*5 + canvas.space
        canvas.circle4LastX = canvas.radius + canvas.space
        canvas.circle4LastY = canvas.height - canvas.radius*5 + canvas.space
    }
}
