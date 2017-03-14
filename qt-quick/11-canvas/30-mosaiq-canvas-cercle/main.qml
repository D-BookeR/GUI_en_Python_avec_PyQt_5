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

            property double centerX: rx + rsize / 2.
            property double centerY: ry + rsize / 2.

            Canvas {
                width: parent.width
                height: parent.height
                onPaint: {
                    var ctx = getContext("2d");
                    ctx.fillStyle = rcolor;
                    ctx.beginPath();
                    ctx.ellipse(0, 0, width, height);
                    ctx.closePath();
                    ctx.fill();
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (Math.pow(mouse.x - rsize / 2, 2) + Math.pow(mouse.y - rsize / 2, 2) <= Math.pow(rsize / 2, 2)) {
                        var half = rsize / 2;
                        mod.append({ "rx": rx, "ry": ry, "rsize": half, "rcolor": colour() });
                        mod.append({ "rx": rx + half, "ry": ry, "rsize": half, "rcolor": colour() });
                        mod.append({ "rx": rx, "ry": ry + half, "rsize": half, "rcolor": colour() });
                        mod.append({ "rx": rx + half, "ry": ry + half, "rsize": half, "rcolor": colour() });
                        mod.remove(index);
                    }
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
