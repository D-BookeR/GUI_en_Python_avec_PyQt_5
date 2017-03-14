import QtQuick 2.5
import QtQuick.Window 2.0
import QtQuick.Controls 1.4

Window {
    id: window
    visible: true
    width: 475
    height: 475
    title: qsTr("Exemple")

    ScrollView {
        anchors.fill: parent

        Rectangle {
            width: window.width - 17
            height: 2 * window.height

            gradient: Gradient {
                GradientStop { position: 0.0; color: "blue" }
                GradientStop { position: 0.5; color: "white" }
                GradientStop { position: 1.0; color: "red" }
            }
        }
    }
}
