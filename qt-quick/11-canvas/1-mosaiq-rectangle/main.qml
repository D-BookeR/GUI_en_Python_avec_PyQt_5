import QtQuick 2.5
import QtQuick.Window 2.0

Window {
    id: window
    visible: true
    width: 400
    height: 400
    title: qsTr("MosaiQ")

    function colour() {
        return Qt.rgba(Math.random(), Math.random(), Math.random(), 1).toString();
    }

    Repeater {
        model: ListModel {
            id: mod
            // No ListElement here: https://bugreports.qt.io/browse/QTBUG-20631, https://bugreports.qt.io/browse/QTBUG-16289
        }
        delegate: Item {
            x: rx
            y: ry
            width: rsize
            height: rsize

            Rectangle {
                color: rcolor
                anchors.fill: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    var half = rsize / 2
                    mod.append({ "rx": rx, "ry": ry, "rsize": half, "rcolor": colour() })
                    mod.append({ "rx": rx + half, "ry": ry, "rsize": half, "rcolor": colour() })
                    mod.append({ "rx": rx, "ry": ry + half, "rsize": half, "rcolor": colour() })
                    mod.append({ "rx": rx + half, "ry": ry + half, "rsize": half, "rcolor": colour() })
                    mod.remove(index)
                }
            }
        }
    }

    Component.onCompleted: {
        mod.append({ "rx": 0, "ry": 0, "rsize": window.width / 2, "rcolor": colour() })
        mod.append({ "rx": window.width / 2, "ry": 0, "rsize": window.width / 2, "rcolor": colour() })
        mod.append({ "rx": 0, "ry": window.width / 2, "rsize": window.width / 2, "rcolor": colour() })
        mod.append({ "rx": window.width / 2, "ry": window.width / 2, "rsize": window.width / 2, "rcolor": colour() })
    }
}
