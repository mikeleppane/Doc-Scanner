#ifndef LOGIC_H
#define LOGIC_H

#include <QObject>
#include <QVariantList>
#include <QStringList>

class QString;

class Logic : public QObject
{
    Q_OBJECT
public:
    explicit Logic(QObject *parent = 0);

    Q_INVOKABLE QString scanImage(int x, int y, int w, int h,
                               const QString &) const;
    Q_INVOKABLE int getImageWidth(const QString &) const;
    Q_INVOKABLE int getImageHeight(const QString &) const;
    Q_INVOKABLE QString getImageSize(const QString &) const;
    Q_INVOKABLE QString getImageCreateDate(const QString &) const;
    Q_INVOKABLE void sendEmail() const;
    Q_INVOKABLE void convertToPDF(const QString &) const;
    Q_INVOKABLE void rotateImage(const QString &) const;
    Q_INVOKABLE QStringList getImages(const QString &) const;
    Q_INVOKABLE void removeImage(const QString &) const;

signals:

public slots:
};

#endif // LOGIC_H
