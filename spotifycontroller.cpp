#include "spotifycontroller.h"
#include <QDesktopServices>
#include <QUrl>

SpotifyController::SpotifyController(QObject *parent)
    : QObject(parent),
    m_vibe("Lo-fi focus")
{
}

QString SpotifyController::vibe() const
{
    return m_vibe;
}

void SpotifyController::setVibe(const QString &v)
{
    if (m_vibe == v)
        return;

    m_vibe = v;
    emit vibeChanged();
}

void SpotifyController::openSpotify()
{
    QDesktopServices::openUrl(QUrl("https://open.spotify.com"));
}

void SpotifyController::openYouTubeMusic()
{
    QDesktopServices::openUrl(QUrl("https://music.youtube.com"));
}
