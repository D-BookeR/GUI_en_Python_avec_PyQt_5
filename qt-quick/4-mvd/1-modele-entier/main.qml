import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 40
    height: 150
    visible: true

    ColumnLayout {
        Repeater {
            model: 5
            Text { text: modelData + " = " + index }
        }
    }
}
