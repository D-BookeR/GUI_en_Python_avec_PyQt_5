# -*- coding: utf-8 -*-
# mosaiq.py

'''
===============================================================================
 MosaiQ
 
 application créée pour le livre
   Créer des applications graphiques en Python avec PyQt 5
   par Pierre Denis et Thibault Cuvelier
   D-BookeR 2016
-------------------------------------------------------------------------------

Instructions :

* Pour lancer le programme :
    python mosaiq.py

* Commandes interface :
    clic gauche     : divise en 4 le carré pointé
    clic droit      : fait disparaître le carré pointé
    molette souris  : zoom / de-zoom
    touche A        : zoom continu
    touche Q        : de-zoom continu
    touche Ctrl     : tant qu'enfoncée, divise en 4 les carrés pointés
                      pendant le mouvement du curseur
    touche flèche   : déplacement horizontal ou vertical
    touche F11      : mode plein écran
    touche Esc      : sortie du mode plein écran
===============================================================================
'''

import sys
import struct
from random import randint

from PyQt5.QtCore import Qt
from PyQt5.QtGui import QBrush, QPen, QPainter, QColor, QCursor, QImage
from PyQt5.QtWidgets import QApplication, QGraphicsScene, QGraphicsView,    \
                            QGraphicsRectItem, QFileDialog, QLabel, QFrame, \
                            QVBoxLayout

# paramètres de configuration
FACTEUR_ZOOM_FIN = 1.02
COULEUR_CONTOUR = "black"
COULEUR_FOND = "white"
PLAGE_COULEURS = (50,250)
FACTEUR_ECLAIRCISSSEMENT = 150

class PanneauInfo(QFrame):

    def __init__(self,parent,scene):
        QFrame.__init__(self,parent)
        self.scene = scene
        self.vue = parent
        self.setFrameStyle(QFrame.Box)
        self.resize(280,75)
        self.labelNbCarres = QLabel(self)
        self.labelTailleCarreScene = QLabel(self)
        self.labelTailleCarreVue = QLabel(self)
        self.setStyleSheet("QFrame {background-color:white; color:darkblue}")
        self.vBoxLayout = QVBoxLayout(self)
        self.vBoxLayout.addWidget(self.labelNbCarres)
        self.vBoxLayout.addWidget(self.labelTailleCarreScene)
        self.vBoxLayout.addWidget(self.labelTailleCarreVue)
        scene.changed.connect(self.sceneChanged)

    def sceneChanged(self,regions):
        txtNbCarres = "%5d" % CarreMosaiQ.nbInstances
        if CarreMosaiQ.instanceSurvolee is None:
            txtTailleScene = '---'
            txtTailleVue = '---'
        else:
            tailleCarreScene = CarreMosaiQ.instanceSurvolee.taille()
            txtTailleScene = '%e' % tailleCarreScene
            tailleCarreVue = CarreMosaiQ.instanceSurvolee.tailleDansVue(
                                                          self.vue)
            txtTailleVue = '%4d pixels' % tailleCarreVue
        self.labelNbCarres.setText("# carrés: "+txtNbCarres)
        self.labelTailleCarreScene.setText("taille carré scène: " \
                                           + txtTailleScene)
        self.labelTailleCarreVue.setText("taille carré vue: "+txtTailleVue)


class CarreMosaiQ(QGraphicsRectItem):

    _pen = QPen(QColor(COULEUR_CONTOUR))
    _pen.setCosmetic(True)

    nbInstances = 0
    instanceSurvolee = None

    def __init__(self,x,y,c):
        super(CarreMosaiQ,self).__init__(0,0,c,c)
        QGraphicsRectItem.__init__(self,0,0,c,c)
        self.setPos(x,y)
        self.setPen(CarreMosaiQ._pen)
        couleur = QColor(*(randint(*PLAGE_COULEURS) for _ in 'RGB'))
        self.brush = QBrush(couleur)
        self.setBrush(self.brush)
        self.setAcceptHoverEvents(True)
        self.setCursor(Qt.PointingHandCursor)
        CarreMosaiQ.nbInstances += 1

    def hoverEnterEvent(self,event):
        couleur = self.brush.color().lighter(FACTEUR_ECLAIRCISSSEMENT)
        self.setBrush(QBrush(couleur))
        CarreMosaiQ.instanceSurvolee = self

    def hoverLeaveEvent(self,event):
        self.setBrush(self.brush)
        CarreMosaiQ.instanceSurvolee = None

    def mousePressEvent(self,mouseEvent):
        if mouseEvent.button() == Qt.LeftButton:
            self.fragmente()
        elif mouseEvent.button() == Qt.RightButton:
            QGraphicsRectItem.hoverLeaveEvent(self,None)
            self.scene().removeItem(self)
        else:
            QGraphicsRectItem.mousePressEvent(self,mouseEvent)

    def fragmente(self):
        c = self.rect().width() / 2.
        x = self.x()
        y = self.y()
        scene = self.scene()
        scene.removeItem(self)
        CarreMosaiQ.nbInstances -= 1
        #self.setVisible(False)
        for (dx,dy) in ((0,0),(c,0),(0,c),(c,c)):
            scene.addItem(CarreMosaiQ(x+dx,y+dy,c))

    def taille(self):
        return self.rect().width()

    def tailleDansVue(self,vue):
        return vue.mapFromScene(self.taille(),0).x()-vue.mapFromScene(0,0).x()


class SceneMosaiQ(QGraphicsScene):

    def __init__(self):
        QGraphicsScene.__init__(self)
        size = 2.0**32
        #self.setSceneRect(0,0,size,size)
        #self.setItemIndexMethod(QGraphicsScene.NoIndex)
        self.carreMosaiQUnivers = CarreMosaiQ(0,0,size)
        self.addItem(self.carreMosaiQUnivers)


class VueMosaiQ(QGraphicsView):

    def __init__(self,scene):
        QGraphicsView.__init__(self,scene)
        self.setHorizontalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)
        self.hScrollBar = self.horizontalScrollBar()
        self.vScrollBar = self.verticalScrollBar()
        self.setBackgroundBrush(QColor(COULEUR_FOND))
        self.setWindowTitle("MosaiQ")
        self.resize(800,600)
        # attention : la technique de zoom recommandée avec AnchorUnderMouse
        # ne donne pas un bon résultat (voir méthode zoom ci-après)
        # self.setTransformationAnchor(QGraphicsView.AnchorUnderMouse)
        self.setTransformationAnchor(QGraphicsView.NoAnchor)
        self.fitInView(scene.carreMosaiQUnivers,Qt.KeepAspectRatio)
        self.panneauInfo = PanneauInfo(self,scene)
        self.panneauInfo.move(20,20)
        self.panneauInfo.setVisible(False)

    '''
    # attention : la technique de zoom recommandée avec AnchorUnderMouse
    # ne donne pas un bon résultat (voir méthode zoom ci-après)
    def zoom(self,facteur):
        if facteur < 0.0:
            facteur = -1.0 / facteur
        self.scale(facteur,facteur)
    '''

    INT_MAX = 2 ** (struct.Struct('i').size * 8 - 1) - 1
    def zoom(self,facteur):
        if facteur < 0.0:
            facteur = -1.0 / facteur
        else:
            coordMax = self.scene().carreMosaiQUnivers.tailleDansVue(self)
            if coordMax*facteur >= VueMosaiQ.INT_MAX:
                QApplication.beep()
                return
        # normalement, en utilisant AnchorUnderMouse, l'instruction 'scale'
        # seule devrait suffire... mais le résultat obtenu est notablement
        # imprécis, surtout pour les petit facteurs de zooms ;
        # pour pallier le manque de précision de AnchorUnderMouse, on
        # implémente une technique alternative, de plus bas niveau : on prend
        # les coordonnées courantes du pointeur dans la vue (posVue1), on les
        # transforme en coordonnées de la scène (posScene), après l'opération
        # de zoom, on transfome les coordonnées de la scène en coordonnées de
        # la vue transformée (posVue2) ; comme on veut que le curseur reste
        # sur la position de la scène, on fait une translation de la vue
        # selon le vecteur (posVue2 - posVue1)
        posVue1 = self.mapFromGlobal(QCursor.pos())
        posScene = self.mapToScene(posVue1)
        self.scale(facteur,facteur)
        posVue2 = self.mapFromScene(posScene)
        dxVue = posVue2.x()-posVue1.x()
        dyVue = posVue2.y()-posVue1.y()
        # self.translate(dxVue,dyVue)    # ne fonctionne pas !
        self.hScrollBar.setValue(self.hScrollBar.value()+dxVue)
        self.vScrollBar.setValue(self.vScrollBar.value()+dyVue)
        self.scene().changed.emit(None)

    def wheelEvent(self,event):
        self.zoom(event.angleDelta().y()/100.)

    def keyPressEvent(self,keyEvent):
        key = keyEvent.key()
        if key == Qt.Key_Escape:
            self.showNormal()
        elif key == Qt.Key_F11:
            self.showFullScreen()
        elif key == Qt.Key_A:
            self.zoom(FACTEUR_ZOOM_FIN)
        elif key == Qt.Key_Q:
            self.zoom(-FACTEUR_ZOOM_FIN)
        elif key == Qt.Key_F1:
            self.panneauInfo.setVisible(not self.panneauInfo.isVisible())
            if self.panneauInfo.isVisible():
                self.scene().changed.connect(self.panneauInfo.sceneChanged)
            else:
                self.scene().changed.disconnect(self.panneauInfo.sceneChanged)
        elif keyEvent.modifiers() == Qt.ControlModifier \
             and key == Qt.Key_P:
            (nomFichier,filtre) = QFileDialog.getSaveFileName(self,
                            "Sauvegarder image",
                            filter="PNG (*.png);;JPEG (*.jpg);;BMP (*.bmp)")
            if nomFichier:
                pixmap = self.grab()
                pixmap.save(nomFichier)
        else:
            QGraphicsView.keyPressEvent(self,keyEvent)

    def mouseMoveEvent(self,mouseEvent):
        QGraphicsView.mouseMoveEvent(self,mouseEvent)
        if QApplication.keyboardModifiers() == Qt.ControlModifier:
            item = self.itemAt(mouseEvent.pos())
            if item is not None and isinstance(item,CarreMosaiQ):
                item.fragmente()

if __name__ == "__main__":
    app = QApplication(sys.argv)
    sceneMosaiQ = SceneMosaiQ()
    vueMosaiQ = VueMosaiQ(sceneMosaiQ)
    vueMosaiQ.show()
    sys.exit(app.exec_())
