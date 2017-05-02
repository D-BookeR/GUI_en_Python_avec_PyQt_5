# -*- coding: utf-8 -*-
# test_scene.py
# vues multiples

from PyQt5.QtCore import Qt
from PyQt5.QtGui import QBrush, QPen, QPainter
from PyQt5.QtWidgets import QApplication, QGraphicsScene, QGraphicsView, \
     QGraphicsItem, QGraphicsRectItem, QGraphicsTextItem, QGraphicsEllipseItem
import sys
from random import random 

app = QApplication(sys.argv)

# definition de la scène
scene = QGraphicsScene()
rectGris = QGraphicsRectItem(0.,0.,200.,150.)
rectGris.setBrush(QBrush(Qt.lightGray))
scene.addItem(rectGris)
# ou (equivalent):
# rectGris = scene.addRect(0.,0.,200.,150.,brush=QBrush(Qt.lightGray))

texte = QGraphicsTextItem("Tous en scène !")
dy = rectGris.rect().height() - texte.sceneBoundingRect().height()
texte.setPos(rectGris.x(), rectGris.y() + dy)
texte.setDefaultTextColor(Qt.blue)
scene.addItem(texte)

d = 48. # diametre smiley
ox = 4. # largeur oeil
oy = 6. # hauteur oeil
smiley = QGraphicsEllipseItem(-d/2,-d/2,d,d)
smiley.setBrush(QBrush(Qt.yellow))
yeux = [QGraphicsEllipseItem(-ox/2.,-oy/2.,ox,oy,parent=smiley) \
        for _ in range(2)]
yeux[0].setPos(-d/6,-d/8)
yeux[1].setPos(+d/6,-d/8)
brush = QBrush(Qt.black)
for oeil in yeux:
    oeil.setBrush(brush)
smiley.setPos(rectGris.mapToScene(rectGris.rect().center()))
scene.addItem(smiley)
smiley.setRotation(20)
smiley.setScale(1.5)
smiley.setFlag(QGraphicsItem.ItemIsMovable)
texte.setZValue(1)

# vue principale
vue = QGraphicsView(scene)
vue.setRenderHints(QPainter.Antialiasing)
vue.resize(800,600)
vue.centerOn(rectGris)
vue.fitInView(rectGris,Qt.KeepAspectRatio)
vue.show()

# vues auxiliaires
vues = []
for _ in range(4):
    vuex = QGraphicsView(scene)
    vues.append(vuex)
    vuex.setRenderHints(QPainter.Antialiasing)
    vuex.resize(400,300)
    vuex.rotate(360.*random())
    vuex.scale(4.*random(),4.*random())
    # pour éviter les déformations, remplacer l'instruction précédente par
    # f = 4. * random()
    # vuex.scale(f,f)
    vuex.show()

sys.exit(app.exec_())
