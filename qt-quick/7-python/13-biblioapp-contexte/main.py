import sys

from PyQt5.QtCore import QObject, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine


initialGenres = ["(None)", "Biography", "Crime", "Science-fiction", "Fantastic", "Historic", "Nonfiction", "Theatre"]
initialBooks = [{'title': "Commentarii de Bello Gallico", 'author': "Caius Iulius Caesar", 'genre': "Historic", 'publisher': "Les Belles Lettres", 'year': "1926", 'summary': "Julius Caesar\'s firsthand account of the Gallic Wars", 'price': "9.00"}, {'title': "Προμηθεὺς δεσμώτης", 'author': "Αἰσχύλος", 'genre': "Nonfiction", 'publisher': "Les Solitaires Intempestifs", 'year': "2010", 'summary': "Prometheus defied the gods and gave fire to mankind", 'price': "24.34"}]

if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.rootContext().setContextProperty("initialGenres", initialGenres)
    engine.rootContext().setContextProperty("initialBooks", initialBooks)
    engine.load("main.qml")
    sys.exit(app.exec_())