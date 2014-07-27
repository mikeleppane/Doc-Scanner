#  Doc Scanner - application for Sailfish OS smartphones developed using Qt/QML.
#  Copyright (C) 2014 Mikko Leppänen
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program. If not, see <http://www.gnu.org/licenses/>.

TARGET = harbour-docscanner

# Enable c++11 language standard for the compiler
CONFIG += sailfishapp c++11

SOURCES += src/harbour-docscanner.cpp \
    src/logic.cpp \
    src/imagemodel.cpp

OTHER_FILES += qml/harbour-docscanner.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-docscanner.spec \
    rpm/harbour-docscanner.yaml \
    translations/*.ts \
    harbour-docscanner.desktop \
    qml/pages/MainPage.qml \
    qml/pages/ImagePage.qml \
    qml/pages/scripts/Vars.js \
    qml/pages/AboutPage.qml \
    qml/pages/content/Area.qml \
    qml/pages/content/Marker.qml \
    qml/pages/ImagesPage.qml \
    qml/pages/scripts/DocScannerDB.js \
    qml/pages/ScannedImagesPage.qml \
    qml/pages/imagehandler.py \
    qml/pages/scripts/componentCreation.js \
    qml/pages/content/ZoomItem.qml \
    rpm/harbour-docscanner.changes

CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-docscanner-de.ts

HEADERS += \
    src/logic.h \
    src/imagemodel.h

RESOURCES += \
    MyResource.qrc

#include(doc/doc.pro)


