/*!
 *  Doc Scanner - application for Sailfish OS smartphones developed using
 *  Qt/QML.
 *  Copyright (C) 2014 Mikko Leppänen
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QGuiApplication>
#include <QQuickView>
#include <QtQml/QQmlContext>
#include <QVariant>
#include <QStandardPaths>
#include "logic.h"
#include "imagemodel.h"


int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    Logic logic{};
    ImageModel imageModel{};

    QScopedPointer<QQuickView> view(SailfishApp::createView());

    view->rootContext()->setContextProperty("logic", &logic);
    QQmlContext *ctxt = view->rootContext();
    ctxt->setContextProperty("myImageModel", &imageModel);

    view->setSource(SailfishApp::pathTo("qml/harbour-docscanner.qml"));

    view->show();

    return app->exec();
}

