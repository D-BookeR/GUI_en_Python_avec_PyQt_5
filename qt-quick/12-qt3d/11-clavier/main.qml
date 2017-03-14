import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Scene3D 2.0
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Input 2.0
import Qt3D.Extras 2.0

ApplicationWindow {
    id: window
    width: 500
    height: 500
    visible: true
    title: "Test Qt 3D"

    Text {
        id: text
        text: "Du texte !"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    Rectangle {
        id: scene
        anchors.fill: parent
        anchors.margins: 50
        color: "darkRed"

        Scene3D {
            id: scene3d
            anchors.fill: parent
            anchors.margins: 10
            focus: true
            aspects: ["input", "logic"]

            Entity {
                components: [
                    RenderSettings {
                        activeFrameGraph: ForwardRenderer {
                            camera: Camera {
                                id: camera
                                position: Qt.vector3d(0.0, 0.0, -40.0)
                                viewCenter: Qt.vector3d(0.0, 0.0, 0.0)
                                fieldOfView: 45
                            }
                        }
                    },
                    InputSettings {
                        eventSource: window
                    }
                ]

                KeyboardDevice {
                    id: keyboard
                }

                Entity {
                    components: [
                        TorusMesh {
                            radius: 5.5
                            rings: 100
                            slices: 20
                        },
                        PhongMaterial {
                            ambient: Qt.darker("maroon", 1.5)
                        },
                        Transform {
                            scale3D: Qt.vector3d(1.5, 1.5, 0.5)
                            rotation: fromAxisAndAngle(Qt.vector3d(1, 0, 0), 45)

                            scale: torusKeyboard.focus ? 1 : 2
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 250
                                }
                            }
                        },
                        KeyboardHandler {
                            id: torusKeyboard
                            sourceDevice: keyboard
                            onTabPressed: sphereKeyboard.focus = true
                        }
                    ]
                }

                Entity {
                    components: [
                        SphereMesh {
                            radius: 2
                        },
                        PhongMaterial {
                            ambient: Qt.darker("lightblue", 2)
                        },
                        Transform {
                            id: sphereTransform

                            property real scale: sphereKeyboard.focus ? 1 : 2
                            Behavior on scale {
                                NumberAnimation {
                                    duration: 250
                                }
                            }

                            property real angle: 0.0
                            matrix: {
                                var m = Qt.matrix4x4();
                                m.rotate(angle, Qt.vector3d(0, 1, 0));
                                m.translate(Qt.vector3d(20, 0, 0));
                                m.scale(scale);
                                return m;
                            }
                        },
                        KeyboardHandler {
                            id: sphereKeyboard
                            sourceDevice: keyboard
                            onTabPressed: torusKeyboard.focus = true
                            focus: true
                        }
                    ]

                    NumberAnimation {
                        target: sphereTransform
                        property: "angle"
                        duration: 5000
                        from: 0
                        to: 360

                        loops: Animation.Infinite
                        running: true
                    }
                }
            }
        }
    }
}
