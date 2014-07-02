import QtQuick 2.1

Item {
    property alias canvasObj: canvas
    property alias canvasRotation: canvas.rotation
    property int lineW: 8
    Canvas {
        id: canvas
        smooth: true
        width: 125
        height: 125
        onPaint: {

            var cxt1 = canvas.getContext('2d')
            cxt1.beginPath();
            cxt1.moveTo(0,0);
            cxt1.lineTo(canvas.width,0);
            cxt1.lineWidth = lineW
            var gradient1 = cxt1.createLinearGradient(0,0,
                                                     canvas.width,0)
            gradient1.addColorStop(0, "#339900")
            gradient1.addColorStop(0.25, "#33FF00")
            gradient1.addColorStop(0.5, 'transparent')
            gradient1.addColorStop(0.75, "#33FF00")
            gradient1.addColorStop(1.0, "#339900")
            cxt1.strokeStyle = gradient1;
            cxt1.stroke();

            var cxt2 = canvas.getContext('2d')
            cxt2.beginPath();
            cxt2.moveTo(canvas.width,0);
            cxt2.lineTo(canvas.width, canvas.height);
            cxt2.lineWidth = lineW
            var gradient2 = cxt2.createLinearGradient(canvas.width, 0,
                                                     canvas.width,canvas.height)
            gradient2.addColorStop(0, "#339900")
            gradient2.addColorStop(0.25, "#33FF00")
            gradient2.addColorStop(0.5, 'transparent')
            gradient2.addColorStop(0.75, "#33FF00")
            gradient2.addColorStop(1.0, "#339900")
            cxt2.strokeStyle = gradient2;
            cxt2.stroke();

            var cxt3 = canvas.getContext('2d')
            cxt3.beginPath();
            cxt3.moveTo(canvas.width, canvas.height);
            cxt3.lineTo(0, canvas.height);
            cxt3.lineWidth = lineW
            var gradient3 = cxt3.createLinearGradient(canvas.width,canvas.height,
                                                      0,canvas.height)
            gradient3.addColorStop(0, "#339900")
            gradient3.addColorStop(0.25, "#33FF00")
            gradient3.addColorStop(0.5, 'transparent')
            gradient3.addColorStop(0.75, "#33FF00")
            gradient3.addColorStop(1.0, "#339900")
            cxt3.strokeStyle = gradient3;
            cxt3.stroke();

            var cxt4 = canvas.getContext('2d')
            cxt4.beginPath();
            cxt4.moveTo(0, canvas.height);
            cxt4.lineTo(0, 0);
            cxt4.lineWidth = lineW
            var gradient4 = cxt4.createLinearGradient(0,canvas.height,
                                                      0,0)
            gradient4.addColorStop(0, "#339900")
            gradient4.addColorStop(0.25, "#33FF00")
            gradient4.addColorStop(0.5, 'transparent')
            gradient4.addColorStop(0.75, "#33FF00")
            gradient4.addColorStop(1.0, "#339900")
            cxt4.strokeStyle = gradient4;
            cxt4.stroke();
        }
        opacity: 0.75

    }
    transform: Translate{x: -canvas.width / 2;
                         y: -canvas.height / 2}
}
