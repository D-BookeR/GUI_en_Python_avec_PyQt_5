# -*- coding: utf-8 -*-
# start_app.py
# première application - connexion signal-slot par décorateur

import sys
from PyQt5.QtWidgets import QApplication
from main_window_biblio import MainWindowBiblio

app = QApplication(sys.argv)
mainWindowBiblio = MainWindowBiblio()
mainWindowBiblio.show()

rc = app.exec_()
sys.exit(rc)
