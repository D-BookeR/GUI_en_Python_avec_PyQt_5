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
            ctx = getContext("2d");
        }
    }
}
