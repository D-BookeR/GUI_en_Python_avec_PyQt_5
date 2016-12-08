# -*- coding: utf-8 -*-
# main_windows_biblio.py
# utilisation de Qt designer

from PyQt5.QtWidgets import QMainWindow, QFileDialog, QMessageBox
from PyQt5.QtCore import pyqtSlot
from Ui_main_window_biblio import Ui_MainWindowBiblio

class MainWindowBiblio(QMainWindow, Ui_MainWindowBiblio):
    
    def __init__(self, parent=None):
        super(MainWindowBiblio,self).__init__(parent)
        self.setupUi(self)

    @pyqtSlot()
    def on_actionOuvrir_triggered(self):
        (nomFichierBiblio,filtre) = QFileDialog.getOpenFileName(
                                  self,"Ouvrir fichier bibliothèque",
                                  filter="Bibliothèque (*.bib);; Tout (*.*)")
        if nomFichierBiblio:
            # TODO: trace temporaire à remplacer par la lecture du fichier
            QMessageBox.information(self,"TRACE",
                                  "Fichier à ouvrir:\n\n%s"%nomFichierBiblio)
        
    @pyqtSlot()
    def on_actionQuitter_triggered(self):
        self.close()
        
    def closeEvent(self,event):
        messageConfirmation = "Êtes-vous sûr de vouloir quitter BibliApp ?"
        reponse = QMessageBox.question(self,"Confirmation",
                          messageConfirmation,QMessageBox.Yes,QMessageBox.No)
        if reponse == QMessageBox.Yes:
            event.accept()
        else:
            event.ignore()
