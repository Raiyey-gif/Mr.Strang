#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "src/spotifycontroller.h"
#include "src/authmanager.h"
#include "src/chatmanager.h"

int main(int argc, char *argv[])
{
    qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    SpotifyController spotify;
    AuthManager auth;
    ChatManager chatManager;

    engine.rootContext()->setContextProperty("spotify", &spotify);
    engine.rootContext()->setContextProperty("auth", &auth);
    engine.rootContext()->setContextProperty("chatManager", &chatManager);

    // ✅ LOAD VIA QML MODULE
    engine.loadFromModule("MrStrang_app", "AppWindow");

    if (engine.rootObjects().isEmpty()) {
        qCritical("❌ Failed to load QML module MrStrang_app.AppWindow");
        return -1;
    }

    return app.exec();
}
