#pragma once
#include <QObject>
#include <QDateTime>

class ChatMessage : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString sender READ sender CONSTANT)
    Q_PROPERTY(QString text READ text CONSTANT)
    Q_PROPERTY(QDateTime timestamp READ timestamp CONSTANT)
    Q_PROPERTY(bool thinking READ thinking CONSTANT)

public:
    enum Sender {
        User,
        MrStrang
    };
    Q_ENUM(Sender)

    explicit ChatMessage(
        Sender sender,
        const QString &text,
        bool thinking = false,
        QObject *parent = nullptr
        );

    QString sender() const;
    QString text() const;
    QDateTime timestamp() const;
    bool thinking() const;

private:
    Sender m_sender;
    QString m_text;
    QDateTime m_timestamp;
    bool m_thinking;
};
