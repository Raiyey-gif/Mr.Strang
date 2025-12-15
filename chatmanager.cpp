#include "chatmanager.h"

ChatManager::ChatManager(QObject *parent)
    : QObject(parent)
{
    connect(&m_ai, &MockAI::thinking,
            this, &ChatManager::onAIThinking);

    connect(&m_ai, &MockAI::responseReady,
            this, &ChatManager::onAIResponse);
}

QList<QObject*> ChatManager::messages() const
{
    return m_messages;
}

void ChatManager::sendMessage(const QString &text)
{
    if (text.trimmed().isEmpty())
        return;

    // User message
    m_messages.append(
        new ChatMessage(ChatMessage::User, text, false, this)
        );
    emit messagesChanged();

    // Ask AI
    m_ai.ask(text);
}

void ChatManager::onAIThinking()
{
    removeThinkingBubble();

    m_messages.append(
        new ChatMessage(ChatMessage::MrStrang, "Thinking…", true, this)
        );
    emit messagesChanged();
}

void ChatManager::onAIResponse(const QString &response)
{
    removeThinkingBubble();

    m_messages.append(
        new ChatMessage(ChatMessage::MrStrang, response, false, this)
        );
    emit messagesChanged();
}

void ChatManager::removeThinkingBubble()
{
    for (int i = m_messages.size() - 1; i >= 0; --i) {
        auto *msg = qobject_cast<ChatMessage*>(m_messages[i]);
        if (msg && msg->thinking()) {
            m_messages.removeAt(i);
            msg->deleteLater();
            return;
        }
    }
}
