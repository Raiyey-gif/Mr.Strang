#include "DeviceInfo.h"
#include <QTouchDevice>

DeviceInfo::DeviceInfo(QObject *parent)
    : QObject(parent)
{
    m_hasTouch = !QTouchDevice::devices().isEmpty();
}

bool DeviceInfo::hasTouch() const
{
    return m_hasTouch;
}
