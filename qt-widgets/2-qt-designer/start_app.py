# -*- coding: utf-8 -*-
# start_app.py
# utilisation de Qt designer

import sys
from PyQt5.QtWidgets import QApplication
from PyQt5.QtCore import QTranslator
from main_window_biblio import MainWindowBiblio

app = QApplication(sys.argv)

translator = QTranslator()
translator.load("biblioapp_en")
app.installTranslator(translator)

mainWindowBiblio = MainWindowBiblio()
mainWindowBiblio.show()

rc = app.exec_()
sys.exit(rc)
