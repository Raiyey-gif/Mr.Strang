#pragma once

#include <QObject>
#include <QList>
#include "chatmessage.h"
#include "mockai.h"

class ChatManager : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QList<QObject*> messages READ messages NOTIFY messagesChanged)

public:
    explicit ChatManager(QObject *parent = nullptr);

    QList<QObject*> messages() const;

    Q_INVOKABLE void sendMessage(const QString &text);

signals:
    void messagesChanged();

private slots:
    void onAIThinking();
    void onAIResponse(const QString &response);

private:
    QList<QObject*> m_messages;
    MockAI m_ai;

    void removeThinkingBubble();
};

