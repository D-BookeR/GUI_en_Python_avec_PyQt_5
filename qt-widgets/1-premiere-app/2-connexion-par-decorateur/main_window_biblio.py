# -*- coding: utf-8 -*-
# main_window_biblio.py
# première application - connexion signal-slot par décorateur

from PyQt5.QtWidgets import QMainWindow, QWidget, QLabel, QLineEdit, \
                            QPushButton, QHBoxLayout, QVBoxLayout,   \
                            QMessageBox
from PyQt5.QtCore import QMetaObject, pyqtSlot

class MainWindowBiblio(QMainWindow):
    
    def __init__(self):
        super(MainWindowBiblio,self).__init__()
        self.resize(300,150)
        self.setWindowTitle("BiblioApp")
        self.centralWidget = QWidget(self)
        self.setCentralWidget(self.centralWidget)
        self.label = QLabel("Titre",self.centralWidget)
        self.lineEditTitre = QLineEdit(self.centralWidget)
        self.pushButtonOK = QPushButton("OK",self.centralWidget)
        self.hBoxLayout = QHBoxLayout()
        self.hBoxLayout.addWidget(self.label)
        self.hBoxLayout.addWidget(self.lineEditTitre)
        self.vBoxLayout = QVBoxLayout(self.centralWidget)
        self.vBoxLayout.addLayout(self.hBoxLayout)
        # ceci permet de garder le bouton OK toujours le plus bas possible dans la fenêtre
        self.vBoxLayout.addStretch()        
        # ceci permet de garder le bouton OK toujours centré verticalament
        self.hBoxLayout2 = QHBoxLayout()
        self.hBoxLayout2.addStretch()
        self.hBoxLayout2.addWidget(self.pushButtonOK)        
        self.hBoxLayout2.addStretch()
        self.vBoxLayout.addLayout(self.hBoxLayout2)
        # approche par nom / décorateur
        self.pushButtonOK.setObjectName("pushButtonOK")
        QMetaObject.connectSlotsByName(self)

    # approche par nom / décorateur
    # attention si le décorateur est omis, la méthode est appelée DEUX fois !
    @pyqtSlot()
    def on_pushButtonOK_clicked(self):
        QMessageBox.information(self, "Info", "Titre: " + self.lineEditTitre.text())
