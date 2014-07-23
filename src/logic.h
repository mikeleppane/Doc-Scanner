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

#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>

class QString;

/*!
 *  \brief Class to handle application logic
 *
 *  This class is used to provide some application specific logic.
 *  The key idea is to define logic in C++ and use that as a service
 *  for the QML to exploit.
 */

class Logic : public QObject
{
    Q_OBJECT
public:
    explicit Logic(QObject *parent = 0);

    Q_INVOKABLE QString scanImage(int x, int y, int w, int h,
                               const QString &);
    Q_INVOKABLE int getImageWidth(const QString &) const;
    Q_INVOKABLE int getImageHeight(const QString &) const;
    Q_INVOKABLE QString getImageSize(const QString &) const;
    Q_INVOKABLE QString getImageCreateDate(const QString &) const;
    Q_INVOKABLE void sendEmail() const;
    Q_INVOKABLE void convertToPDF(const QString &) const;
    Q_INVOKABLE void rotateImage(const QString &) const;
    Q_INVOKABLE QString getVersion() const;

private slots:
    void checkIfThreadIsDone();

private:

};

#endif // LOGIC_H
