#ifndef SYSTEMOBJECTS_H
#define SYSTEMOBJECTS_H

#include <QObject>
#include <QString>
#include <QColor>

// --- Сеть ---
class Network : public QObject {
    Q_OBJECT
    Q_PROPERTY(Status status READ status WRITE setStatus NOTIFY statusChanged)

public:
    enum Status {
        Ok,
        Failure
    };
    Q_ENUM(Status)

    explicit Network(QObject *parent = nullptr) : QObject(parent), m_status(Ok) {}

    Status status() const { return m_status; }
    void setStatus(Status s) {
        if (m_status != s) {
            m_status = s;
            emit statusChanged();
        }
    }

    Q_INVOKABLE QString statusString() const {
        return m_status == Ok ? "ОК" : "Авария";
    }

    Q_INVOKABLE QColor statusColor() const {
        return m_status == Ok ? QColor("#5EC85E") : QColor("#FF4C4C");
    }

signals:
    void statusChanged();

private:
    Status m_status;
};

// --- Система ---
class System : public QObject {
    Q_OBJECT
    Q_PROPERTY(Status status READ status WRITE setStatus NOTIFY statusChanged)

public:
    enum Status {
        Ok,
        Failure
    };
    Q_ENUM(Status)

    explicit System(QObject *parent = nullptr) : QObject(parent), m_status(Ok) {}

    Status status() const { return m_status; }
    void setStatus(Status s) {
        if (m_status != s) {
            m_status = s;
            emit statusChanged();
        }
    }

    Q_INVOKABLE QString statusString() const {
        return m_status == Ok ? "ОК" : "Авария";
    }

    Q_INVOKABLE QColor statusColor() const {
        return m_status == Ok ? QColor("#5EC85E") : QColor("#FF4C4C");
    }

signals:
    void statusChanged();

private:
    Status m_status;
};

// --- Режим ---
class Mode : public QObject {
    Q_OBJECT
    Q_PROPERTY(State state READ state WRITE setState NOTIFY stateChanged)

public:
    enum State {
        Work,       // рабочий
        Emergency,  // аварийный
        Test,       // тест
        TimedTest   // тест на время
    };
    Q_ENUM(State)

    explicit Mode(QObject *parent = nullptr) : QObject(parent), m_state(Work) {}

    State state() const { return m_state; }
    void setState(State st) {
        if (m_state != st) {
            m_state = st;
            emit stateChanged();
        }
    }

    Q_INVOKABLE QString stateString() const {
        switch (m_state) {
        case Work: return "Рабочий";
        case Emergency: return "Аварийный";
        case Test: return "Тест";
        case TimedTest: return "Тест на время";
        }
        return "Unknown";
    }

    Q_INVOKABLE QColor stateColor() const {
        switch (m_state) {
        case Work: return QColor("#5EC85E");
        case Emergency: return QColor("#FF4C4C");
        case Test: return QColor("#FFC700");
        case TimedTest: return QColor("#FFA500");
        }
        return QColor("gray");
    }

signals:
    void stateChanged();

private:
    State m_state;
};

#endif // SYSTEMOBJECTS_H
