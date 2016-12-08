# -*- coding: utf-8 -*-
# main_windows_biblio.py
# version internationale, incluant les boutons standards

from PyQt5.QtCore import pyqtSlot, QDate, QItemSelectionModel
from PyQt5.QtWidgets import QMainWindow, QMessageBox, QFileDialog

from Ui_main_window_biblio import Ui_MainWindowBiblio

from modele_biblio import Livre, ModeleTableBiblio

class MainWindowBiblio(QMainWindow, Ui_MainWindowBiblio):

    def __init__(self, parent=None):
        super(MainWindowBiblio,self).__init__(parent)
        self.setupUi(self)
        self.nomFichierBiblio = None
        self.modeleTableBiblio = ModeleTableBiblio([])
        self.treeViewLivres.setModel(self.modeleTableBiblio)
        self.treeViewLivres.selectionModel().selectionChanged.connect(
                                  self.on_treeViewLivres_selectionChanged)
        self.modificationAEnregistrer(False)
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

    def modificationAEnregistrer(self,fichierNonEnregistre):
        self.fichierNonEnregistre = fichierNonEnregistre
        titre = "BiblioApp"
        if self.nomFichierBiblio is not None:
            titre += " - " + self.nomFichierBiblio
        if self.fichierNonEnregistre:
            titre += " *"
        self.setWindowTitle(titre)
        self.actionEnregistrer.setEnabled(fichierNonEnregistre)
        self.pushButtonNouveau.setEnabled(True)
        self.pushButtonSauvegarder.setEnabled(False)

    def on_treeViewLivres_selectionChanged(self,selected,deselected):
        indexsSelection = selected.indexes()
        if self.pushButtonSauvegarder.isEnabled():
           reponse = QMessageBox.question(self,
                                 self.tr('Confirmation'),
                                 self.tr('Abandonner la saisie en cours ?'),
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

    def closeEvent(self,event):
        if not self.fichierNonEnregistre:
            event.accept()
        else:
            messageConfirmation = self.tr("Etes-vous sur de vouloir quitter" \
                                   " BiblioApp sans enregistrer le fichier ?")
            reponse = QMessageBox.question(self,self.tr("Confirmation"), 
                                           messageConfirmation,
                                           QMessageBox.Yes,QMessageBox.No)
            if reponse == QMessageBox.Yes:
                event.accept()
            else:
                event.ignore()

    @pyqtSlot()
    def on_actionQuitter_triggered(self):
        self.close()

    @pyqtSlot()
    def on_actionOuvrir_triggered(self):
        if self.fichierNonEnregistre:
            messageConfirmation = self.tr("Modifications en cours.\n\n"   \
                                     "Etes-vous sur de vouloir continuer" \
                                     " sans enregistrer le fichier ?")
            reponse = QMessageBox.question(self,"Confirmation",
                          messageConfirmation,QMessageBox.Yes,QMessageBox.No)
            if reponse == QMessageBox.No:
                return
        (nomFichierBiblio,filtre) = QFileDialog.getOpenFileName(
                          self,self.tr("Ouvrir fichier bibliotheque"),
                          filter=self.tr("Bibliotheque (*.bib);; Tout (*.*)"))
        if nomFichierBiblio:
            self.modeleTableBiblio = ModeleTableBiblio.creeDepuisFichier(
                                                            nomFichierBiblio)
            self.treeViewLivres.setModel(self.modeleTableBiblio)
            self.treeViewLivres.selectionModel().selectionChanged.connect(
                                      self.on_treeViewLivres_selectionChanged)
            self.nomFichierBiblio = nomFichierBiblio
            self.modificationAEnregistrer(False)
  
    @pyqtSlot()
    def on_actionEnregistrer_triggered(self):
        if self.nomFichierBiblio is None:
            (nomFichierBiblio,filtre) = QFileDialog.getSaveFileName(self,
                                   "Enregistrer fichier",
                                   filter="Bibliotheque (*.bib);; Tout (*.*)")
            if nomFichierBiblio:
                self.nomFichierBiblio = nomFichierBiblio
        if self.nomFichierBiblio is not None:
            self.modeleTableBiblio.enregistreDansFichier(self.nomFichierBiblio)
            self.modificationAEnregistrer(False)
    
    @pyqtSlot()
    def on_pushButtonNouveau_clicked(self):
        self.treeViewLivres.selectionModel().clearSelection()
        self.effaceLivre()
        self.pushButtonSauvegarder.setEnabled(False)
        
    @pyqtSlot()
    def on_pushButtonSauvegarder_clicked(self):
        livre = Livre( titre = self.lineEditTitre.text(),
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
        self.modificationAEnregistrer(True)

    @pyqtSlot()
    def on_pushButtonSupprimer_clicked(self):
        selectionModel = self.treeViewLivres.selectionModel()
        indexsSelectionnes = selectionModel.selectedRows()
        if len(indexsSelectionnes) > 0:
            indiceLivreSelectionne = indexsSelectionnes[0].row()
            self.modeleTableBiblio.supprimeLivre(indiceLivreSelectionne)
            self.modificationAEnregistrer(True)

    
