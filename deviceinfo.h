#pragma once
#include <QObject>

class DeviceInfo : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool hasTouch READ hasTouch CONSTANT)

public:
    explicit DeviceInfo(QObject *parent = nullptr);
    bool hasTouch() const;

private:
    bool m_hasTouch;
};
