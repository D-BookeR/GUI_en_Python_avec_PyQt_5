import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    title: "BiblioApp"

    GridLayout {
        anchors.fill: parent
        anchors.margins: 10

        columns: 3

        Rectangle { width: 20; height: 20; Text { text: "1" } }
        Rectangle { width: 20; height: 20; Text { text: "2" } }
        Rectangle { width: 20; height: 20; Text { text: "3" } }
        Rectangle { width: 20; height: 20; Text { text: "4" } }
        Rectangle { width: 20; height: 20; Text { text: "5" } }
        Rectangle { width: 20; height: 20; Text { text: "6" } }
        Rectangle { width: 20; height: 20; Text { text: "7" } }
        Rectangle { width: 20; height: 20; Text { text: "8" } }
        Rectangle { width: 20; height: 20; Text { text: "9" } }
        Rectangle { width: 20; height: 20; Text { text: "10" } }
        Rectangle { width: 20; height: 20; Text { text: "11" } }
        Rectangle { width: 20; height: 20; Text { text: "12" } }
        Rectangle {
            width: 20; height: 20; Text { text: "13" }
            Layout.columnSpan: 3
        }
        Rectangle { width: 20; height: 20; Text { text: "14" } }
        Rectangle { width: 20; height: 20; Text { text: "15" } }
        Rectangle { width: 20; height: 20; Text { text: "16" } }
        Rectangle { width: 20; height: 20; Text { text: "17" } }
        Rectangle { width: 20; height: 20; Text { text: "18" } }
        Rectangle { width: 20; height: 20; Text { text: "19" } }
    }
}
