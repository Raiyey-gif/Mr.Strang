#pragma once

#include <QObject>
#include <QString>

class SpotifyController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString vibe READ vibe WRITE setVibe NOTIFY vibeChanged)

public:
    explicit SpotifyController(QObject *parent = nullptr);

    QString vibe() const;
    void setVibe(const QString &v);

    Q_INVOKABLE void openSpotify();
    Q_INVOKABLE void openYouTubeMusic();

signals:
    void vibeChanged();

private:
    QString m_vibe;
};
