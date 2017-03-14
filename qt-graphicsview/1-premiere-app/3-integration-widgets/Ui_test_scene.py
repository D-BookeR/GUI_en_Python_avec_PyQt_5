# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'C:\Users\Public\Espace_Eric6\test_scene\test_scene.ui'
#
# Created by: PyQt5 UI code generator 5.5.1
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_MainWindow(object):
    def setupUi(self, MainWindow):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(800, 600)
        self.centralwidget = QtWidgets.QWidget(MainWindow)
        self.centralwidget.setObjectName("centralwidget")
        self.horizontalLayout = QtWidgets.QHBoxLayout(self.centralwidget)
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.vuePrincipale = QtWidgets.QGraphicsView(self.centralwidget)
        self.vuePrincipale.setObjectName("vuePrincipale")
        self.horizontalLayout.addWidget(self.vuePrincipale)
        MainWindow.setCentralWidget(self.centralwidget)
        self.statusbar = QtWidgets.QStatusBar(MainWindow)
        self.statusbar.setObjectName("statusbar")
        MainWindow.setStatusBar(self.statusbar)
        self.dockWidget = QtWidgets.QDockWidget(MainWindow)
        self.dockWidget.setFeatures(QtWidgets.QDockWidget.DockWidgetFloatable|QtWidgets.QDockWidget.DockWidgetMovable)
        self.dockWidget.setAllowedAreas(QtCore.Qt.LeftDockWidgetArea|QtCore.Qt.RightDockWidgetArea)
        self.dockWidget.setObjectName("dockWidget")
        self.dockWidgetContents = QtWidgets.QWidget()
        self.dockWidgetContents.setObjectName("dockWidgetContents")
        self.verticalLayout = QtWidgets.QVBoxLayout(self.dockWidgetContents)
        self.verticalLayout.setObjectName("verticalLayout")
        self.pushButtonCreerDisque = QtWidgets.QPushButton(self.dockWidgetContents)
        self.pushButtonCreerDisque.setObjectName("pushButtonCreerDisque")
        self.verticalLayout.addWidget(self.pushButtonCreerDisque)
        self.pushButtonChangerCouleur = QtWidgets.QPushButton(self.dockWidgetContents)
        self.pushButtonChangerCouleur.setObjectName("pushButtonChangerCouleur")
        self.verticalLayout.addWidget(self.pushButtonChangerCouleur)
        self.lineEditTexte = QtWidgets.QLineEdit(self.dockWidgetContents)
        self.lineEditTexte.setObjectName("lineEditTexte")
        self.verticalLayout.addWidget(self.lineEditTexte)
        spacerItem = QtWidgets.QSpacerItem(20, 40, QtWidgets.QSizePolicy.Minimum, QtWidgets.QSizePolicy.Expanding)
        self.verticalLayout.addItem(spacerItem)
        self.vueGlobale = QtWidgets.QGraphicsView(self.dockWidgetContents)
        self.vueGlobale.setObjectName("vueGlobale")
        self.verticalLayout.addWidget(self.vueGlobale)
        spacerItem1 = QtWidgets.QSpacerItem(20, 40, QtWidgets.QSizePolicy.Minimum, QtWidgets.QSizePolicy.Expanding)
        self.verticalLayout.addItem(spacerItem1)
        self.dialRotation = QtWidgets.QDial(self.dockWidgetContents)
        self.dialRotation.setMinimum(-180)
        self.dialRotation.setMaximum(180)
        self.dialRotation.setTracking(True)
        self.dialRotation.setWrapping(True)
        self.dialRotation.setNotchTarget(30.0)
        self.dialRotation.setNotchesVisible(True)
        self.dialRotation.setObjectName("dialRotation")
        self.verticalLayout.addWidget(self.dialRotation)
        self.horizontalSliderZoom = QtWidgets.QSlider(self.dockWidgetContents)
        self.horizontalSliderZoom.setMinimum(10)
        self.horizontalSliderZoom.setMaximum(1000)
        self.horizontalSliderZoom.setOrientation(QtCore.Qt.Horizontal)
        self.horizontalSliderZoom.setObjectName("horizontalSliderZoom")
        self.verticalLayout.addWidget(self.horizontalSliderZoom)
        self.dockWidget.setWidget(self.dockWidgetContents)
        MainWindow.addDockWidget(QtCore.Qt.DockWidgetArea(1), self.dockWidget)

        self.retranslateUi(MainWindow)
        QtCore.QMetaObject.connectSlotsByName(MainWindow)

    def retranslateUi(self, MainWindow):
        _translate = QtCore.QCoreApplication.translate
        MainWindow.setWindowTitle(_translate("MainWindow", "Fenêtre avec vues"))
        self.dockWidget.setWindowTitle(_translate("MainWindow", "Boîte à outils"))
        self.pushButtonCreerDisque.setText(_translate("MainWindow", "Créer disque"))
        self.pushButtonChangerCouleur.setText(_translate("MainWindow", "Changer couleur..."))


if __name__ == "__main__":
    import sys
    app = QtWidgets.QApplication(sys.argv)
    MainWindow = QtWidgets.QMainWindow()
    ui = Ui_MainWindow()
    ui.setupUi(MainWindow)
    MainWindow.show()
    sys.exit(app.exec_())

