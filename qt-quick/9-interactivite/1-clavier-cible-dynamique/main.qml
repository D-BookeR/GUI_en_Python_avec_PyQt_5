import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 90
    height: 100
    title: qsTr("Cible de saisie")

    Column {
        Repeater {
            model: 3

            Text {
                text: modelData + " : " + (activeFocus ? "actif" : "inactif")
                color: activeFocus ? "green" : "red"
                font.pointSize: 20

                Keys.onPressed: {
                    console.log("[" + modelData + "] Touche : " + event.key); 
                    event.accepted = true; 
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: parent.focus = true
                }
            }
        }
    }
}