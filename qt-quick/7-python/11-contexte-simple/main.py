import sys

from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.rootContext().setContextProperty("pythonText", "Je suis un rectangle.")
    engine.load("main.qml")
    sys.exit(app.exec_())