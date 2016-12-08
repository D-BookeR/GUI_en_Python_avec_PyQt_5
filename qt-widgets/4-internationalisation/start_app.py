# -*- coding: utf-8 -*-
# start_app.py
# version internationale, incluant les boutons standards

import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QTranslator, QLocale
from main_window_biblio import MainWindowBiblio

app = QApplication(sys.argv)

enLangueNative = len(sys.argv) == 1
if enLangueNative:
    locale = QLocale()
else:
    languePays = sys.argv[1]
translators = []
for prefixeQm in ("biblioapp.","qt_","qtbase_"):
    translator = QTranslator()
    translators.append(translator)
    if enLangueNative:
        translator.load(locale,prefixeQm)
    else:
        translator.load(prefixeQm+languePays)
    app.installTranslator(translator)

mainWindowBiblio = MainWindowBiblio()
mainWindowBiblio.show()

rc = app.exec_()
sys.exit(rc)
