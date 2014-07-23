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

#include <QHash>
#include <QByteArray>
#include <QString>
#include <QDir>
#include <QDirIterator>
#include <QtAlgorithms>
#include <QFileInfo>
#include <QDateTime>
#include <QImageReader>
#include <QModelIndex>
#include "imagemodel.h"

bool checkIfImageFormatSupported(const QString &path)
{
    QList<QByteArray> formats = QImageReader::supportedImageFormats();
    // std::for_each(formats.begin(), formats.end(), [](QByteArray ba){
    // ba.toUpper(); });
    QByteArray suffix(QFileInfo(path).suffix().toLower().toUtf8());

    return formats.contains(suffix);
}

ImageModel::ImageModel(QObject *parent) : QAbstractListModel(parent) {}

QVariant ImageModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_images.count() || !index.isValid())
        return QVariant();

    auto path = m_images[index.row()];
    if (role == PathRole) {
        return path;
    }

    return QVariant();
}

void ImageModel::addImages(const QString &path)
{
    if (rowCount() > 0) {
        beginRemoveRows(QModelIndex(), 0, rowCount() - 1);
        m_images.clear();
        endRemoveRows();
    }
    QStringList images;
    QDir dir(path);
    dir.setFilter(QDir::Files | QDir::Dirs | QDir::NoDotAndDotDot);
    QDirIterator it(dir, QDirIterator::Subdirectories);
    while (it.hasNext()) {
        QString imagePath = it.next();
        if (!QFileInfo(imagePath).isDir() && !images.contains(imagePath) &&
            checkIfImageFormatSupported(imagePath)) {
            images.append(imagePath);
        }
    }
    // maybe plain sort will suffice
    qStableSort(images.begin(), images.end(),
                [](const QString &path1, const QString &path2)->bool {
        return QFileInfo(path1).created() > QFileInfo(path2).created();
    });
    beginInsertRows(QModelIndex(), 0, images.count() - 1);
    m_images.swap(images);
    endInsertRows();
}

void ImageModel::addImage(const QString &path)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_images.prepend(path);
    endInsertRows();
}

void ImageModel::removeImage(const QString &filePath, int index)
{
    if (index < 0 || index >= m_images.count()) {
        QFile file(filePath);
        if (file.exists()) {
            file.remove();
        }
        return;
    }
    beginRemoveRows(QModelIndex(), index, index);
    QFile file(filePath);
    if (file.exists()) {
        file.remove();
        m_images.removeAt(index);
    }
    endRemoveRows();
}

int ImageModel::rowCount(const QModelIndex &index) const
{

    return index.isValid() ? 0 : m_images.count();
}

QHash<int, QByteArray> ImageModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[PathRole] = "path";
    return roles;
}
