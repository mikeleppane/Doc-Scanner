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
 *  This class is used to provide application specific logic.
 *  The key idea is to define logic in C++ and use that as a service
 *  for the QML to exploit.
 */

class Logic : public QObject
{
    Q_OBJECT
public:
    /*!
     *  \brief Class constructor
     */
    explicit Logic(QObject *parent = 0);

    /*!
     *  \brief Scan an image and return the path to the image
     *  \param[in] x X-coordinate of the top-left corner
     *  \param[in] y X-coordinate of the top-left corner
     *  \param[in] w Width of the scan
     *  \param[in] h Height of the scan
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE QString scanImage(int x, int y, int w, int h,
                               const QString &pathToImage);
    /*!
     *  \brief Returns the width of an image
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE int getImageWidth(const QString &pathToImage) const;

    /*!
     *  \brief Returns the height of an image
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE int getImageHeight(const QString &pathToImage) const;

    /*!
     *  \brief Returns the size of an image, expressed in KB or MB depending on the size
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE QString getImageSize(const QString &pathToImage) const;

    /*!
     *  \brief Returns the date when the file was created.
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE QString getImageCreateDate(const QString &pathToImage) const;

    /*!
     *  \brief Opens a default email client for sending a message
     */
    Q_INVOKABLE void sendEmail() const;

    /*!
     *  \brief Converts the given image to the PDF format
     *  \param[in] pathToFile Path to image
     */
    Q_INVOKABLE void convertToPDF(const QString &pathToFile) const;

    /*!
     *  \brief Rotates the given image 45 degrees
     *  \param[in] pathToImage Path to image
     */
    Q_INVOKABLE void rotateImage(const QString &pathToImage) const;

    /*!
     *  \brief Parses the rpm files to extract current version number of the application
     */
    Q_INVOKABLE QString getVersion() const;

private slots:
    /*!
     *  \brief Checks if the current thread is finished
     */
    void checkIfThreadIsDone();

private:

};

#endif // LOGIC_H
