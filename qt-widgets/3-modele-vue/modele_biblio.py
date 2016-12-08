# -*- coding: utf-8 -*-
# modele_biblio.py
# programmation MVD

from PyQt5.QtCore import Qt, QAbstractTableModel, QModelIndex, QVariant

from collections import namedtuple
import json

Livre = namedtuple('Livre', ('titre', 'auteur', 'editeur', 'genre',
                             'annee', 'resume', 'prix') )

class ModeleTableBiblio(QAbstractTableModel):
    
    def __init__(self,livres):
        super(ModeleTableBiblio,self).__init__()
        self.titresColonnes = ("Titre", "Auteur", "Editeur")
        self.livres = livres

    def headerData(self,section,orientation,role):
        if role == Qt.DisplayRole and orientation == Qt.Horizontal:
            return self.titresColonnes[section]
        return QVariant()  
         
    def columnCount(self,parent):
        return len(self.titresColonnes)
   
    def rowCount(self,parent):
        return len(self.livres)

    def data(self,index,role):
        if role == Qt.DisplayRole and index.isValid():
            return self.livres[index.row()][index.column()]
        return QVariant()

    def enregistreDansFichier(self,nomFichierBiblio):
        with open(nomFichierBiblio,'w') as f:
            f.write(json.dumps(self.livres))

    @staticmethod
    def creeDepuisFichier(nomFichierBiblio):
        with open(nomFichierBiblio,'r') as f:
            contenuFichier = f.read()
        attributsLivres = json.loads(contenuFichier)
        livres = [Livre(*attrLivre) for attrLivre in attributsLivres]
        return ModeleTableBiblio(livres)
        
    def ajouteLivre(self,livre):
        indiceLivre = len(self.livres)
        self.beginInsertRows(QModelIndex(),indiceLivre,indiceLivre)
        self.livres.append(livre)
        self.endInsertRows()
    
    def supprimeLivre(self,indiceLivre):
        self.beginRemoveRows(QModelIndex(),indiceLivre,indiceLivre)
        del self.livres[indiceLivre]
        self.endRemoveRows()       

    def remplaceLivre(self,indiceLivre,livre):
        self.livres[indiceLivre] = livre
        self.dataChanged.emit(self.createIndex(indiceLivre,0),
                              self.createIndex(indiceLivre,2))
