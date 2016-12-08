import sys

from PyQt5.QtCore import QObject, pyqtSlot
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine


class TextProvider(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    @pyqtSlot(result=str)
    def provide(self): 
        return "Je viens d'une méthode Python."


if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.rootContext().setContextProperty("textProvider", TextProvider())
    engine.load("main.qml")
    sys.exit(app.exec_())