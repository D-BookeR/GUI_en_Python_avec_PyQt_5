import sys

from PyQt5.QtCore import QTranslator, QLocale
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine


if __name__ == "__main__":
    app = QApplication(sys.argv)
    
    translator = QTranslator() 
    translator.load(QLocale(), 'biblioapp', '.') 
    app.installTranslator(translator)
    
    engine = QQmlApplicationEngine("main.qml")
    engine.quit.connect(app.quit)
    sys.exit(app.exec_())
    