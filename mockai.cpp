#include "mockai.h"
#include <QRandomGenerator>

MockAI::MockAI(QObject *parent)
    : QObject(parent)
{
    m_timer.setSingleShot(true);

    connect(&m_timer, &QTimer::timeout, this, [this]() {
        const QString reply = generateReply(m_lastPrompt);
        emit responseReady(reply);
    });
}

void MockAI::ask(const QString &prompt)
{
    if (prompt.trimmed().isEmpty())
        return;

    m_lastPrompt = prompt;

    emit thinking();

    // Simulate AI thinking delay (human-like)
    m_timer.start(900 + QRandomGenerator::global()->bounded(600));
}

// ============================
// Core AI logic
// ============================
QString MockAI::generateReply(const QString &prompt)
{
    const int sass = sassLevelFromPrompt(prompt);

    if (sass <= 1)
        return gentleReply();
    else if (sass <= 3)
        return focusedReply();
    else
        return sassyReply();
}

// ============================
// Sass detection
// ============================
int MockAI::sassLevelFromPrompt(const QString &prompt) const
{
    int level = 0;
    const int len = prompt.length();

    if (len > 40)  level++;
    if (len > 90)  level++;

    if (prompt.contains("lazy", Qt::CaseInsensitive)) level++;
    if (prompt.contains("tired", Qt::CaseInsensitive)) level++;
    if (prompt.contains("help", Qt::CaseInsensitive)) level--;

    return qBound(0, level, 5);
}

// ============================
// Personality responses
// ============================
QString MockAI::gentleReply()
{
    static const QStringList replies = {
        "That’s a reasonable place to begin.\nTake your time.",
        "Curiosity is already progress.",
        "You’re not late. You’re early in a long journey.",
        "Let’s warm up. No pressure."
    };

    return replies.at(QRandomGenerator::global()->bounded(replies.size()));
}

QString MockAI::focusedReply()
{
    static const QStringList replies = {
        "Alright. Let’s be precise.\nWhat exactly is blocking you?",
        "Five honest minutes will do more than overthinking.",
        "Discipline first. Motivation follows.",
        "Structure beats panic. Always."
    };

    return replies.at(QRandomGenerator::global()->bounded(replies.size()));
}

QString MockAI::sassyReply()
{
    static const QStringList replies = {
        "Ah. Avoidance disguised as reflection.",
        "Bold words for someone not started yet.",
        "You survived linear algebra.\nYou’ll survive this.",
        "I’ve seen worse excuses.\nTry again."
    };

    return replies.at(QRandomGenerator::global()->bounded(replies.size()));
}
