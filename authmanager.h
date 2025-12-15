#pragma once

#include <QObject>
#include <QString>
#include <QSettings>

class AuthManager : public QObject
{
    Q_OBJECT

public:
    explicit AuthManager(QObject *parent = nullptr);

    Q_INVOKABLE bool login(const QString &email, const QString &password);
    Q_INVOKABLE bool registerUser(const QString &email, const QString &password);
    Q_INVOKABLE bool userExists(const QString &email);
    Q_INVOKABLE bool deleteAccount(const QString &email, const QString &password);

private:
    QSettings m_store;
};
