# -*- coding: utf-8 -*-
# main_windows_biblio.py
# persistence sur BD SQLite

from PyQt5.QtCore import pyqtSlot, QDate, QItemSelectionModel
from PyQt5.QtWidgets import QMainWindow, QMessageBox 

from Ui_main_window_biblio import Ui_MainWindowBiblio

from modele_biblio import Livre, ModeleTableBiblio

class MainWindowBiblio(QMainWindow, Ui_MainWindowBiblio):

    def __init__(self, parent=None):
        super(MainWindowBiblio,self).__init__(parent)
        self.setupUi(self)
        self.modeleTableBiblio = ModeleTableBiblio()
        self.comboBoxGenre.addItems(self.modeleTableBiblio.genres())
        self.treeViewLivres.setModel(self.modeleTableBiblio)
        self.treeViewLivres.selectionModel().selectionChanged.connect(
                                  self.on_treeViewLivres_selectionChanged)
        self.dateEditAnnee.setMinimumDate(QDate(101,1,1))
        self.dateEditAnnee.setSpecialValueText(" ")
        self.doubleSpinBoxPrix.setMinimum(-0.01)
        self.doubleSpinBoxPrix.setSpecialValueText(" ")
        self.effaceLivre()
        self.pushButtonSupprimer.setEnabled(False)
        self.pushButtonSauvegarder.setEnabled(False)
        for lineEdit in (self.lineEditTitre,
                         self.lineEditAuteur,
                         self.lineEditEditeur):
            lineEdit.textEdited.connect(self.declareSaisieEnCours)
        self.comboBoxGenre.currentIndexChanged.connect(
                                               self.declareSaisieEnCours)
        self.dateEditAnnee.dateChanged.connect(self.declareSaisieEnCours)
        self.plainTextEditResume.textChanged.connect(self.declareSaisieEnCours)
        self.doubleSpinBoxPrix.valueChanged.connect(self.declareSaisieEnCours)
        
    def declareSaisieEnCours(self):
        self.pushButtonNouveau.setEnabled(False)
        saisieValide = len(self.lineEditTitre.text().strip()) > 0
        self.pushButtonSauvegarder.setEnabled(saisieValide)

    def on_treeViewLivres_selectionChanged(self,selected,deselected):
        indexsSelection = selected.indexes()
        if self.pushButtonSauvegarder.isEnabled():
           reponse = QMessageBox.question(self,"Confirmation",
                                          "Abandonner la saisie en cours ?",
                                          QMessageBox.Yes,QMessageBox.No)
           if reponse == QMessageBox.No:
               selectionModel = self.treeViewLivres.selectionModel()             
               selectionModel.selectionChanged.disconnect(
                                self.on_treeViewLivres_selectionChanged)
               selectionModel.select(selected,QItemSelectionModel.Deselect)
               selectionModel.select(deselected,QItemSelectionModel.Select)
               selectionModel.selectionChanged.connect(
                                    self.on_treeViewLivres_selectionChanged)
               return
        if len(indexsSelection) == 0:
            self.effaceLivre()
            self.pushButtonSupprimer.setEnabled(False)
        else:
            indexSelection = indexsSelection[0]
            indiceLivreSelectionne = indexSelection.row()
            self.afficheLivre(self.modeleTableBiblio.livres[
                                                indiceLivreSelectionne])
            self.pushButtonSupprimer.setEnabled(True)
            self.pushButtonNouveau.setEnabled(True)
        self.pushButtonSauvegarder.setEnabled(False)

    def effaceLivre(self):
        for lineEdit in (self.lineEditTitre,
                         self.lineEditAuteur,
                         self.lineEditEditeur):
            lineEdit.setText("")
        self.comboBoxGenre.setCurrentIndex(0)
        self.dateEditAnnee.setDate(self.dateEditAnnee.minimumDate())
        self.plainTextEditResume.setPlainText("")
        self.doubleSpinBoxPrix.setValue(self.doubleSpinBoxPrix.minimum())

    def afficheLivre(self,livre):
        self.lineEditTitre.setText(livre.titre)
        self.lineEditAuteur.setText(livre.auteur)
        self.comboBoxGenre.setCurrentText(livre.genre)
        self.lineEditEditeur.setText(livre.editeur)
        self.dateEditAnnee.setDate(QDate(livre.annee,1,1))
        self.plainTextEditResume.setPlainText(livre.resume)
        self.doubleSpinBoxPrix.setValue(livre.prix)

    @pyqtSlot()
    def on_actionQuitter_triggered(self):
        self.close()
    
    @pyqtSlot()
    def on_pushButtonNouveau_clicked(self):
        self.treeViewLivres.selectionModel().clearSelection()
        self.effaceLivre()
        self.pushButtonSauvegarder.setEnabled(False)

    @pyqtSlot()
    def on_pushButtonSauvegarder_clicked(self):
        livre = Livre( idLivre = None,
                       titre = self.lineEditTitre.text(),
                       auteur = self.lineEditAuteur.text(),
                       editeur = self.lineEditEditeur.text(),
                       genre = self.comboBoxGenre.currentText(),
                       annee = self.dateEditAnnee.date().year(),
                       resume = self.plainTextEditResume.toPlainText(),
                       prix = self.doubleSpinBoxPrix.value() )
        selectionModel = self.treeViewLivres.selectionModel()
        indexsSelectionnes = selectionModel.selectedRows()
        if len(indexsSelectionnes) == 0:
            self.modeleTableBiblio.ajouteLivre(livre)
            self.on_pushButtonNouveau_clicked()
        else:
            indiceLivreSelectionne = indexsSelectionnes[0].row()
            self.modeleTableBiblio.remplaceLivre(indiceLivreSelectionne,livre)

    @pyqtSlot()
    def on_pushButtonSupprimer_clicked(self):
        selectionModel = self.treeViewLivres.selectionModel()
        indexsSelectionnes = selectionModel.selectedRows()
        if len(indexsSelectionnes) > 0:
            indiceLivreSelectionne = indexsSelectionnes[0].row()
            self.modeleTableBiblio.supprimeLivre(indiceLivreSelectionne)
            self.modificationAEnregistrer(True)

    
