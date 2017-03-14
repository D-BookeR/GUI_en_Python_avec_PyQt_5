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

        onPaint: {
            if (mouseArea.pressed) {
                var ctx = getContext('2d');
                if ((mouseArea.pressedButtons & Qt.LeftButton) && ! (mouseArea.pressedButtons & Qt.RightButton)) {
                    ctx.fillStyle = "red";
                } else if (! (mouseArea.pressedButtons & Qt.LeftButton) && (mouseArea.pressedButtons & Qt.RightButton)) {
                    ctx.fillStyle = "green";
                } else {
                    ctx.fillStyle = "blue";
                }
                ctx.fillRect(mouseArea.mouseX - 2, mouseArea.mouseY - 2, 5, 5);
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
