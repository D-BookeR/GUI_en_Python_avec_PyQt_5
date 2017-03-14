import QtQuick 2.5
import QtQuick.Window 2.0

Window {
    id: window
    visible: true
    width: 400
    height: 400
    title: qsTr("Exemple")

    Canvas {
        width: 400
        height: 400

        onPaint: {
            var ctx = getContext("2d"); 

            ctx.lineWidth = 10; 
            ctx.strokeStyle = "darkgreen"; 
            ctx.fillStyle = "darkseagreen"; 

            ctx.beginPath(); 
            ctx.moveTo(50, 50); 
            ctx.lineTo(350, 50); 
            ctx.lineTo(350, 350); 
            ctx.lineTo(50, 350); 
            ctx.closePath(); 
            ctx.fill(); 
            ctx.stroke(); 
        }
    }
}
