# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-docscanner

CONFIG += sailfishapp c++11

SOURCES += src/harbour-docscanner.cpp \
    src/logic.cpp

OTHER_FILES += qml/harbour-docscanner.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-docscanner.changes.in \
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
    qml/pages/ScannedImagesPage.qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-docscanner-de.ts

HEADERS += \
    src/logic.h

RESOURCES += \
    MyResource.qrc

