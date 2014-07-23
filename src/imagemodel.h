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

#ifndef IMAGEMODEL_H
#define IMAGEMODEL_H

#include <QAbstractListModel>
#include <QStringList>

class QModelIndex;
class QString;

/*!
 *  \brief Custom model for storing images
 *
 *  This class is a repository for images and handles a few different
 *  operating on them like. This model is being used on QML side for
 *  representing images in a view. To get best possible performance the class
 *  has been subclassed from QAbstractItemModel.
 */

class ImageModel : public QAbstractListModel
{
    Q_OBJECT
public:
    /*!
     *  \brief A class constructor
     */
    explicit ImageModel(QObject *parent = 0);

    /*!
     *  \brief An Enum type
     *         Role name for the model
     */
    enum ImageRoles { PathRole = Qt::UserRole + 1 };

    /*!
     *  \brief Reimplementation of QAbstractItemModel's data pure virtual function
     */
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;

    /*!
     *  \brief Get images all from a given directory and its subs
     *  \param[in] path Path to directory where to find images
     */
    Q_INVOKABLE void addImages(const QString &path);

    /*!
     *  \brief Add a new image to the model
     *  \param[in] path Absolute path name of a image file
     */
    Q_INVOKABLE void addImage(const QString &path);

    /*!
     *  \brief Remove an image from the model
     *  \param[in] path Absolute path name of a image file
     *  \param[in] row Which row (number) need to be removed from the model
     */
    Q_INVOKABLE void removeImage(const QString &path, int row);

    /*!
     *  \brief Reimplementation of QAbstractItemModel's rowCount pure virtual function
     */
    int rowCount(const QModelIndex &index = QModelIndex()) const;

protected:
    /*!
     *  \brief Reimplementation of QAbstractItemModel's roleNames virtual function
     */
    QHash<int, QByteArray> roleNames() const;

private:
    QStringList m_images;
};

#endif // IMAGEMODEL_H
