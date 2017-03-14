import QtQuick 2.7
import Qt3D.Core 2.0
import Qt3D.Render 2.0
import Qt3D.Extras 2.0

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
        }
    ]

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
                property real angle: 0.0
                matrix: {
                    var m = Qt.matrix4x4();
                    m.rotate(angle, Qt.vector3d(0, 1, 0));
                    m.translate(Qt.vector3d(20, 0, 0));
                    return m;
                }
            }
        ]

        NumberAnimation {
            target: sphereTransform
            property: "angle"
            duration: 5000
            from: 0; to: 360

            loops: Animation.Infinite
            running: true
        }
    }
}
