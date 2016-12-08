import sys

from PyQt5.QtCore import QUrl
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtQuickWidgets import QQuickWidget


if __name__ == "__main__":
    app = QApplication(sys.argv)
    w = QQuickWidget()
    w.setSource(QUrl.fromLocalFile("main.qml"))
    w.show()
    sys.exit(app.exec_())