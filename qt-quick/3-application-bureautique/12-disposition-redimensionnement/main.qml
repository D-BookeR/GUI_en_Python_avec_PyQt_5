import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    title: "BiblioApp"

    RowLayout {
        anchors.fill: parent
        anchors.margins: 10

        Rectangle {
            width: 50; height: 150

            Text {
                anchors.centerIn: parent
                text: parent.width + 'x' + parent.height
            }
        }
        Rectangle {
            height: 150
            Layout.fillWidth: true
            Layout.minimumWidth: 50
            Layout.preferredWidth: 50
            Layout.maximumWidth: 150

            Text {
                anchors.centerIn: parent
                text: parent.width + 'x' + parent.height
            }
        }
        Rectangle {
            height: 150
            Layout.fillWidth: true
            Layout.minimumWidth: 75
            Layout.preferredWidth: 100
            Layout.maximumWidth: 250

            Text {
                anchors.centerIn: parent
                text: parent.width + 'x' + parent.height
            }
        }
    }
}
