import sys
import os
import json

from PyQt5.QtCore import QObject, pyqtSlot, pyqtProperty, pyqtSignal, QAbstractListModel, QModelIndex, Qt
from PyQt5.QtWidgets import QApplication
from PyQt5.QtQml import QQmlApplicationEngine, qmlRegisterType, QQmlListProperty


class QObjectString(QObject): 
    def __init__(self, value): 
        QObject.__init__(self)
        self._value = value


class FileStringListModel(QAbstractListModel): 
    def __init__(self, data, parent=None, *args): 
        QAbstractListModel.__init__(self, parent, *args) 
        self._data = data
        self._file = None
        self._just_created = False
        
    def _file_write(self): 
        if self._file is None: 
            return False
            
        with open(self._file, 'w') as f:
            json.dump(self._data, f)
        return True
 
    def rowCount(self, parent=QModelIndex()): 
        if self._file is None: 
            return 0
        return len(self._data) 
 
    def data(self, index, role): 
        if self._file is None or not index.isValid():
            return None
        return self._data[index.row()]
 
    def setData(self, index, value, role): 
        if self._file is None or not index.isValid():
            return False
            
        self._data[index.row()] = value
        self.dataChanged.emit(index, index, [role])
        self._file_write()
        return True
            
    def insertRows(self, row, count, parent=None):
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginInsertRows(QModelIndex(), row, row + count - 1)
        for i in range(count): 
            self._data.insert(row + i, None)
        super(QAbstractListModel, self).endInsertRows()
        self.countChanged.emit()
        return True
            
    def removeRows(self, row, count, parent=None):
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginRemoveRows(QModelIndex(), row, row + count - 1)
        for i in range(count): 
            del self._data[row]
        self._file_write()
        super(QAbstractListModel, self).endRemoveRows()
        return True
        
    def flags(self, index): 
        return Qt.ItemIsEditable | Qt.ItemIsEnabled | Qt.ItemIsSelectable
        
    def roleNames(self): 
        return {Qt.UserRole + 1: b"text"}
    
    countChanged = pyqtSignal()
    @pyqtProperty(int, notify=countChanged)
    def count(self): 
        return self.rowCount()
    
    @pyqtSlot(int, str, result=bool)
    def insert(self, row, value): 
        return self.insertRows(row, 1) and self.setData(self.createIndex(row, 0), value, Qt.EditRole)
    
    @pyqtSlot(str, result=bool)
    def append(self, value): 
        return self.insert(self.count, value)
        
    @pyqtSlot(int, result=bool)
    def remove(self, index): 
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginRemoveRows(QModelIndex(), index, index)
        del self._data[index]
        super(QAbstractListModel, self).endRemoveRows()
        self._file_write()
        return True
        
    @pyqtSlot(int, result=str)
    def get(self, index): 
        if self._file is None: 
            return None
        return self._data[index]
        
    @pyqtProperty(str)
    def file(self):
        return self._file

    @file.setter
    def file(self, value):
        self._file = value
        if os.path.isfile(self._file) and os.path.getsize(self._file) > 0: 
            with open(self._file, 'r') as f:
                self._data = json.load(f)
        else: 
            self._just_created = True
            self._data = []
        
    @pyqtProperty(bool)
    def justCreated(self):
        return self._just_created
        
    @pyqtSlot(str, result=int)
    def findIndexByName(self, value): 
        return [i for i in range(len(self._data)) if self._data[i] == value][0]


class FileDictListModel(QAbstractListModel): 
    def __init__(self, data, parent=None, *args): 
        QAbstractListModel.__init__(self, parent, *args) 
        self._data = data
        self._roles = None
        self._file = None
        self._just_created = False
        
    def _file_write(self): 
        if self._file is None: 
            return False
            
        with open(self._file, 'w') as f:
            decoded_roles = {k: v.decode('utf-8') for k, v in self._roles.items()}
            json.dump([self._data, decoded_roles], f)
        return True
        
    def _file_read(self): 
        if self._file is None: 
            return False
            
        with open(self._file, 'r') as f:
            content = json.load(f)
            self._data = content[0]
            self._roles = {int(k): v.encode('utf-8') for k, v in content[1].items()}
        return True
 
    def rowCount(self, parent=QModelIndex()): 
        if self._file is None: 
            return 0
        return len(self._data) 
 
    def data(self, index, role): 
        if self._file is None or not index.isValid():
            return None
        return self._data[index.row()][self._roles[role].decode('utf-8')]
        
    def setData(self, index, value, role): 
        if self._file is None or not index.isValid():
            return False
            
        decoded_value = json.loads(value)
        self._data[index.row()] = decoded_value
        
        if self._roles is None: 
            self._roles = dict(zip(range(Qt.UserRole + 1, Qt.UserRole + 1 + len(decoded_value)), [v.encode('utf-8') for v in decoded_value.keys()]))
        
        self.dataChanged.emit(index, index, self._roles.keys())
        self._file_write()
        return True
            
    def insertRows(self, row, count, parent=None):
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginInsertRows(QModelIndex(), row, row + count - 1)
        for i in range(count): 
            self._data.insert(row + i, None)
        super(QAbstractListModel, self).endInsertRows()
        self.countChanged.emit()
        return True
            
    def removeRows(self, row, count, parent=None):
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginRemoveRows(QModelIndex(), row, row + count - 1)
        for i in range(count): 
            del self._data[row]
        self._file_write()
        super(QAbstractListModel, self).endRemoveRows()
        return True
        
    def flags(self, index): 
        return Qt.ItemIsEditable | Qt.ItemIsEnabled | Qt.ItemIsSelectable
        
    def roleNames(self): 
        return self._roles
    
    countChanged = pyqtSignal()
    @pyqtProperty(int, notify=countChanged)
    def count(self): 
        return self.rowCount()
    
    @pyqtSlot(int, str, result=bool)
    def insert(self, row, value): 
        index = self.createIndex(row, 0)
        return self.insertRows(row, 1) and self.setData(index, value, Qt.EditRole)
    
    @pyqtSlot(str, result=bool)
    def append(self, value): 
        return self.insert(self.count, value)
        
    @pyqtSlot(int, result=bool)
    def remove(self, index): 
        if self._file is None: 
            return False
            
        super(QAbstractListModel, self).beginRemoveRows(QModelIndex(), index, index)
        del self._data[index]
        super(QAbstractListModel, self).endRemoveRows()
        self._file_write()
        return True
        
    @pyqtSlot(int, str, result=str)
    def get(self, index, role_name): 
        if self._file is None: 
            return None
        return self._data[index][role_name]
        
    @pyqtProperty(str)
    def file(self):
        return self._file

    @file.setter
    def file(self, value):
        self._file = value
        if os.path.isfile(self._file) and os.path.getsize(self._file) > 0: 
            self._file_read()
        else: 
            self._just_created = True
            self._data = []
        
    @pyqtProperty(bool)
    def justCreated(self):
        return self._just_created


initialGenres = ["(None)", "Biography", "Crime", "Science-fiction", "Fantastic", "Historic", "Nonfiction", "Theatre"]
initialBooks = [{'title': "Commentarii de Bello Gallico", 'author': "Caius Iulius Caesar", 'genre': "Historic", 'publisher': "Les Belles Lettres", 'year': "1926", 'summary': "Julius Caesar\'s firsthand account of the Gallic Wars", 'price': "9.00"}, {'title': "Προμηθεὺς δεσμώτης", 'author': "Αἰσχύλος", 'genre': "Nonfiction", 'publisher': "Les Solitaires Intempestifs", 'year': "2010", 'summary': "Prometheus defied the gods and gave fire to mankind", 'price': "24.34"}]

if __name__ == "__main__":
    app = QApplication(sys.argv)
    qmlRegisterType(FileStringListModel, "FileModel", 1, 0, "FileStringListModel")
    qmlRegisterType(FileDictListModel, "FileModel", 1, 0, "FileDictListModel")
    engine = QQmlApplicationEngine()
    engine.quit.connect(app.quit)
    engine.rootContext().setContextProperty("initialGenres", initialGenres)
    engine.rootContext().setContextProperty("initialBooks", initialBooks)
    engine.load("main.qml")
    sys.exit(app.exec_())