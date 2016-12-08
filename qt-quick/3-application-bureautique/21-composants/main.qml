import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    visible: true
    width: 600
    height: 398
    title: "Composants de base"

    GroupBox {
        title: "Groupe de composants"
        width: parent.width * .96
        height: parent.height * .96
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        GridLayout {
            columns: 3
            anchors.fill: parent
            anchors.leftMargin: 20
            anchors.rightMargin: 20

            Label { text: "Un bouton" }
            Button { text: "Bouton"; onClicked: btnLbl.text = "Cliqué !" }
            Label { id: btnLbl; text: "Pas cliqué" }

            Label { text: "Une case à cocher" }
            CheckBox { id: check; text: "Description pour la case" }
            Label { text: check.checked ? "coché" : "décoché" }

            Label { text: "Interrupteur (sans description)" }
            Switch { id: sw; }
            Label { text: sw.checked ? "activé" : "désactivé" }

            Label { text: "Un bouton radio" }
            RowLayout {
                ExclusiveGroup { id: grp }
                RadioButton { id: radioA; text: "a"; exclusiveGroup: grp }
                RadioButton { text: "b"; exclusiveGroup: grp; checked: true }
            }
            Label { text: radioA.checked ? "a !" : "b !" }

            Label { text: "Une liste déroulante" }
            ComboBox { id: combo; model: ["a", "b", "c"] }
            Label { text: combo.currentText + " (" + combo.currentIndex + ")" }

            Label { text: "Un curseur" }
            Slider {
                id: slider
                minimumValue: 0
                maximumValue: 25
                stepSize: 1
            }
            Label { text: slider.value }

            Label { text: "Un bouton fléché" }
            SpinBox {
                id: spin
                minimumValue: 0
                maximumValue: 25
                stepSize: .50
                decimals: 2
                suffix: " €"
            }
            Label { text: spin.value }

            Label { text: "Un champ de texte" }
            TextField { id: field; placeholderText: "Nom" }
            Label { text: field.text }

            Label { text: "Une zone de texte" }
            TextArea { id: area }
            Label { text: area.text }
        }
    }
}
