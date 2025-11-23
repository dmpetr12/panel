#pragma once
#include <QObject>
#include <QDateTime>
#include <QDebug>

#ifdef _WIN32
#include <windows.h>
#else
#include <sys/time.h>
#include <unistd.h>
#endif

class TimeAjst : public QObject {
    Q_OBJECT
public:
    explicit TimeAjst(QObject *parent = nullptr) : QObject(parent) {}

public slots:
    void setSystemTime(qint64 msec) {
        QDateTime dt = QDateTime::fromMSecsSinceEpoch(msec);

#ifdef _WIN32
        SYSTEMTIME st;
        dt = dt.toUTC(); // Windows ожидает UTC

        st.wYear         = dt.date().year();
        st.wMonth        = dt.date().month();
        st.wDay          = dt.date().day();
        st.wHour         = dt.time().hour();
        st.wMinute       = dt.time().minute();
        st.wSecond       = dt.time().second();
        st.wMilliseconds = dt.time().msec();

        if (!SetSystemTime(&st)) {
            qDebug() << "❌ Ошибка: не удалось установить время (нужны права администратора)";
        } else {
            qDebug() << "✅ Системное время обновлено (Windows):" << dt.toString();
        }
#else
        struct timeval tv;
        tv.tv_sec  = dt.toSecsSinceEpoch();
        tv.tv_usec = 0;

        if (settimeofday(&tv, nullptr) != 0) {
            perror("❌ Ошибка установки времени");
        } else {
            qDebug() << "✅ Системное время обновлено (Linux):" << dt.toString();
        }
#endif
    }
};
