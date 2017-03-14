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
        }
        delegate: Item {
            x: rx
            y: ry
            width: rsize
            height: rsize

            Canvas {
                width: parent.width
                height: parent.height
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = rcolor;
                    ctx.fillRect(0, 0, width, height);
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fragment(rx, ry, rsize);
                    mod.remove(index);
                }
            }
        }
    }

    Component.onCompleted: {
        fragment(0, 0, window.width);
    }

    function fragment(_x, _y, _size) {
        var half = _size / 2;
        mod.append({ "rx": _x, "ry": _y, "rsize": half, "rcolor": colour() });
        mod.append({ "rx": _x + half, "ry": _y, "rsize": half, "rcolor": colour() });
        mod.append({ "rx": _x, "ry": _y + half, "rsize": half, "rcolor": colour() });
        mod.append({ "rx": _x + half, "ry": _y + half, "rsize": half, "rcolor": colour() });
    }
}
