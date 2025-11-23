//ValueProvider.h

#ifndef VALUEPROVIDER_H
#define VALUEPROVIDER_H
#include <QObject>

class ValueProvider : public QObject {
    Q_OBJECT
    Q_PROPERTY(int value READ value NOTIFY valueChanged)

public:
    explicit ValueProvider(QObject *parent = nullptr) : QObject(parent), m_value(0) {}

    int value() const { return m_value; }

    void setValue(int v) {
        if (m_value != v) {
            m_value = v;
            emit valueChanged();
        }
    }

signals:
    void valueChanged();

private:
    int m_value;
};

#endif // VALUEPROVIDER_H
