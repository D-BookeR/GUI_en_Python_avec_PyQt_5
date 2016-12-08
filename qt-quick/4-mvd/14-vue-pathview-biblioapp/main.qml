import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.2

ApplicationWindow {
    id: window
    width: 440
    height: 800
    visible: true
    title: "BiblioApp"

    menuBar: MenuBar {
        Menu {
            title: "&Fichier"
            MenuItem { text: "Quitter" }
        }
    }

    ListModel {
        id: bookModel

        ListElement {
            title: "Commentarii de Bello Gallico"
            author: "Caius Iulius Caesar"
            genre: "Nonfiction"
            publisher: "Les Belles Lettres"
            year: "1926"
            summary: "Julius Caesar's firsthand account of the Gallic Wars"
            price: "9.00"
            image: "CommentariiDeBelloGallico.jpg"
        }
        ListElement {
            title: "Προμηθεὺς δεσμώτης"
            author: "Αἰσχύλος"
            genre: "Theatre"
            publisher: "Les Solitaires Intempestifs"
            year: "2010"
            summary: "Prometheus defied the gods and gave fire to mankind"
            price: "24.34"
            image: "PrometheusDesmothes.jpg"
        }
    }

    SplitView {
        anchors.fill: parent
        orientation: Qt.Vertical

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 600
            Layout.maximumHeight: 600

            PathView {
                id: booksList
                anchors.fill: parent

                focus: true
                Keys.onLeftPressed: decrementCurrentIndex()
                Keys.onRightPressed: incrementCurrentIndex()

                model: bookModel
                delegate: Item {
                    width: 140
                    height: 260

                    Column {
                        anchors.fill: parent
                        anchors.topMargin: 5

                        Image {
                            source: image

                            fillMode: Image.PreserveAspectFit
                            height: parent.height * .8
                            anchors.horizontalCenter: parent.horizontalCenter
                        }
                        Text {
                            text: title + ", " + author

                            wrapMode: Text.WordWrap
                            width: parent.width

                            anchors.horizontalCenter: parent.horizontalCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }
                    MouseArea {
                        onClicked: booksList.currentIndex = index
                        anchors.fill: parent
                    }
                }

                path: Path {
                    startX: 10; startY: 10
                    PathQuad {
                        x: 10; y: booksList.height - 10
                        controlX: booksList.width
                        controlY: booksList.height / 2
                    }
                }
            }
        }

        Rectangle {
            width: window.width
            Layout.fillHeight: true
            Layout.minimumHeight: 380
            Layout.maximumHeight: 720

            GroupBox {
                title: "Détails"
                width: parent.width * .96
                anchors.horizontalCenter: parent.horizontalCenter

                GridLayout {
                    columns: 2

                    Label { text: "Titre" }
                    Text { text: bookModel.get(booksList.currentIndex).title }
                    Label { text: "Auteur" }
                    Text { text: bookModel.get(booksList.currentIndex).author }
                    Label { text: "Genre" }
                    Text { text: bookModel.get(booksList.currentIndex).genre }
                    Label { text: "Éditeur" }
                    Text { text: bookModel.get(booksList.currentIndex).publisher }
                    Label { text: "Année de publication" }
                    Text { text: bookModel.get(booksList.currentIndex).year }
                    Label { text: "Résumé" }
                    Text { text: bookModel.get(booksList.currentIndex).summary }
                    Label { text: "Prix" }
                    Text { text: bookModel.get(booksList.currentIndex).price }
                }
            }
        }
    }
}
