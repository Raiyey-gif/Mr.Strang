#include "chatmessage.h"

ChatMessage::ChatMessage(
    Sender sender,
    const QString &text,
    bool thinking,
    QObject *parent
    )
    : QObject(parent),
    m_sender(sender),
    m_text(text),
    m_timestamp(QDateTime::currentDateTime()),
    m_thinking(thinking)
{
}

QString ChatMessage::sender() const
{
    return m_sender == User ? "user" : "mr.strang";
}

QString ChatMessage::text() const
{
    return m_text;
}

QDateTime ChatMessage::timestamp() const
{
    return m_timestamp;
}

bool ChatMessage::thinking() const
{
    return m_thinking;
}
