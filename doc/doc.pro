system(doxygen doxyfile_docscanner)

TEMPLATE = subdirs
QT -= gui

QMAKE_EXTRA_TARGETS += doc

htmldocs.files = html/*
htmldocs.path = html/
INSTALLS += htmldocs






