import QtQuick 2.5
import QtQuick.Controls 1.4

ApplicationWindow {
    visible: true
    width: 100
    height: 130
    title: qsTr("Cible de saisie")

    ListModel {
        id: model
        ListElement { value: 3 }
        ListElement { value: 2 }
        ListElement { value: 1 }
    }

    ListView {
        anchors.fill: parent
        anchors.topMargin: 15
        anchors.leftMargin: 15

        id: view
        model: model
        delegate: Text {
            text: value
            font.pointSize: 14
        }

        add: Transition {
            NumberAnimation { property: "opacity"; from: 0; to: 1.0; duration: 5000 }
        }
    }

    Component.onCompleted: model.insert(0, {'value': 4})
}