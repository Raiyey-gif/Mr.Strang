#include "AuthManager.h"

AuthManager::AuthManager(QObject *parent)
    : QObject(parent),
    m_store("MrStrang", "Auth")
{
}

bool AuthManager::userExists(const QString &email)
{
    return m_store.contains(email + "/password");
}

bool AuthManager::registerUser(const QString &email, const QString &password)
{
    if (email.isEmpty() || password.length() < 4)
        return false;

    if (userExists(email))
        return false;

    m_store.setValue(email + "/password", password);
    return true;
}

bool AuthManager::login(const QString &email, const QString &password)
{
    if (!userExists(email))
        return false;

    return m_store.value(email + "/password").toString() == password;
}

bool AuthManager::deleteAccount(const QString &email, const QString &password)
{
    if (!login(email, password))
        return false;

    m_store.remove(email);
    return true;
}
