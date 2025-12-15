#pragma once

#include <QObject>
#include <QTimer>
#include <QStringList>

class MockAI : public QObject
{
    Q_OBJECT

public:
    explicit MockAI(QObject *parent = nullptr);

    // Called from QML
    Q_INVOKABLE void ask(const QString &prompt);

signals:
    void thinking();
    void responseReady(const QString &response);

private:
    QTimer m_timer;
    QString m_lastPrompt;

    // ---- Logic ----
    QString generateReply(const QString &prompt);
    int sassLevelFromPrompt(const QString &prompt) const;

    QString gentleReply();
    QString focusedReply();
    QString sassyReply();
};
