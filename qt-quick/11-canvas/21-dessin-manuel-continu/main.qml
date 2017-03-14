import QtQuick 2.5
import QtQuick.Window 2.0

Window {
    id: window
    visible: true
    width: 400
    height: 400
    title: qsTr("Exemple")

    Canvas {
        anchors.fill: parent

        property var points: []

        onPaint: {
            if (mouseArea.pressed) {
                // Add the new point to the list.
                var colour;
                if ((mouseArea.pressedButtons & Qt.LeftButton) && ! (mouseArea.pressedButtons & Qt.RightButton)) {
                    colour = "red";
                } else if (! (mouseArea.pressedButtons & Qt.LeftButton) && (mouseArea.pressedButtons & Qt.RightButton)) {
                    colour = "green";
                } else {
                    colour = "blue";
                }
                points.push([mouseArea.mouseX, mouseArea.mouseY, colour]);

                // Redraw everything from scratch.
                var ctx = getContext('2d');
                for (var i = 1; i < points.length; ++i) {
                    ctx.beginPath();
                    ctx.strokeStyle = points[i - 1][2];
                    ctx.moveTo(points[i - 1][0], points[i - 1][1]);
                    ctx.lineTo(points[i][0], points[i][1]);
                    ctx.stroke();
                }
            }
        }

        MouseArea{
            id: mouseArea
            anchors.fill: parent
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onPressed: parent.requestPaint()
            onPositionChanged: parent.requestPaint()
        }
    }
}
