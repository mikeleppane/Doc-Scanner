#include <QString>
#include <QFile>
#include <QFileInfo>
#include <QImage>
#include <QPdfWriter>
#include <QPainter>
#include <QRect>
#include <QtGlobal>
#include <QDesktopServices>
#include <QUrl>
#include <QMatrix>
#include <QDir>
#include <QDirIterator>
#include <QDateTime>
#include <QtAlgorithms>
#include <QPoint>
#include <QList>
#include <QImageReader>
#include <QByteArray>
#include <algorithm>
#include "logic.h"

bool checkIfImageFormatSupported(const QString &path)
{
    QList<QByteArray> formats = QImageReader::supportedImageFormats();
    // std::for_each(formats.begin(), formats.end(), [](QByteArray ba){
    // ba.toUpper(); });
    QByteArray suffix(QFileInfo(path).suffix().toLower().toUtf8());

    return formats.contains(suffix);
}

Logic::Logic(QObject *parent) : QObject(parent) {}

void Logic::scanImage(int x, int y, int w, int h, const QString &pathToImage)
    const
{
    QFile file(pathToImage);
    if (file.exists()) {
        QImage img;
        img.load(pathToImage);
        qreal w_factor = img.width() / 960.0;
        qreal h_factor = img.height() / 540.0;

        // leave some margin around rect
        int x_new = x >= 30 ? qRound(static_cast<qreal>(x * w_factor)) - 25
                            : qRound(static_cast<qreal>(x * w_factor));
        int y_new = y >= 30 ? qRound(static_cast<qreal>(y * h_factor)) - 25
                            : qRound(static_cast<qreal>(y * h_factor));
        int w_new = w < 930 ? qRound(static_cast<qreal>(w * w_factor)) + 25
                            : qRound(static_cast<qreal>(w * w_factor));
        int h_new = h < 510 ? qRound(static_cast<qreal>(h * h_factor)) + 25
                            : qRound(static_cast<qreal>(h * h_factor));

        QRect rect(x_new, y_new, w_new, h_new);
        img = img.copy(rect);
        file.remove();
        img.save(pathToImage);
    }
}

int Logic::getImageHeight(const QString &pathToImage) const
{
    QFile file(pathToImage);
    if (file.exists()) {
        QImage img;
        img.load(pathToImage);
        file.close();
        return img.height();
    }
    return 0;
}

void Logic::sendEmail() const { QDesktopServices::openUrl(QUrl("mailto:")); }

void Logic::convertToPDF(const QString &pathToFile) const
{
    QString pdfFileName(pathToFile);
    pdfFileName =
        pdfFileName.replace(pdfFileName.lastIndexOf(".") + 1,
                            QFileInfo(pathToFile).suffix().length(), "pdf");
    QPdfWriter writer(pdfFileName);
    QPainter painter(&writer);
    writer.setPageSize(QPagedPaintDevice::A4);
    painter.drawPixmap(
        QRect(0, 0, writer.logicalDpiX() * 8, writer.logicalDpiY() * 10),
        QPixmap(pathToFile));
    painter.end();
}

void Logic::rotateImage(const QString &pathToImage) const
{
    QFile file(pathToImage);
    if (file.exists()) {
        QImage img;
        img.load(pathToImage);
        QMatrix matrix;
        img.transformed(matrix.rotate(45.0),
                        Qt::TransformationMode::SmoothTransformation);
        file.remove();
        img.save(pathToImage);
    }
}

QStringList Logic::getImages(const QString &path) const
{

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
    qStableSort(images.begin(), images.end(),
                [](const QString &path1, const QString &path2)->bool {
        return QFileInfo(path1).created() > QFileInfo(path2).created();
    });

    return images;
}

void Logic::removeImage(const QString &filePath) const
{
    QFile file(filePath);
    if (file.exists()) {
        file.remove();
    }
}

int Logic::getImageWidth(const QString &pathToImage) const
{
    QFile file(pathToImage);
    if (file.exists()) {
        QImage img;
        img.load(pathToImage);
        file.close();
        return img.width();
    }
    return 0;
}
