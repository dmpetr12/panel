#ifndef TESTCONTROLLER_H
#define TESTCONTROLLER_H

#include <QObject>
#include <QDebug>
#include <QTimer>
#include <QMap>
#include "linesmodel.h"

class TestController : public QObject
{
    Q_OBJECT
public:
    explicit TestController(QObject *parent = nullptr)
        : QObject(parent), m_model(nullptr) {}

    void setModel(LinesModel *model) { m_model = model; }

    // --- запуск теста ---
    Q_INVOKABLE void startTest(int lineIndex, int minutes)
    {
        if (!m_model) {
            qWarning() << "LinesModel not set!";
            return;
        }

        const int durationMs = minutes * 60 * 1000;

        // если тест уже идёт, сбрасываем таймер
        if (lineIndex >= 0 && m_timers.contains(lineIndex)) {
            m_timers[lineIndex]->stop();
            delete m_timers.take(lineIndex);
        }

        if (lineIndex >= 0 && lineIndex < m_model->rowCount()) {
            Line *line = m_model->line(lineIndex);
            if (line) {
                qInfo() << "▶️ Запуск теста линии:" << line->description()
                    << "на" << minutes << "минут";
                line->setStatus(Line::Test);

                // создаём таймер
                QTimer *timer = new QTimer(this);
                timer->setSingleShot(true);
                connect(timer, &QTimer::timeout, this, [=]() {
                    qInfo() << "⏰ Автоостановка теста линии:" << line->description();
                    line->setStatus(Line::OK);
                    m_timers.remove(lineIndex);
                    timer->deleteLater();
                });
                timer->start(durationMs);
                m_timers[lineIndex] = timer;
            }
        } else if (lineIndex < 0) {
            qInfo() << "▶️ Запуск теста для всех линий на" << minutes << "минут";

            // общий таймер для всех линий
            QTimer *globalTimer = new QTimer(this);
            globalTimer->setSingleShot(true);
            connect(globalTimer, &QTimer::timeout, this, [=]() {
                qInfo() << "⏰ Автоостановка теста всех линий";
                stopTest(-1);
                m_timers.remove(-1);
                globalTimer->deleteLater();
            });
            globalTimer->start(durationMs);
            m_timers[-1] = globalTimer;

            // переводим все линии в статус теста
            for (int i = 0; i < m_model->rowCount(); ++i) {
                Line *line = m_model->line(i);
                if (line)
                    line->setStatus(Line::Test);
            }
        }
    }

    // --- ручная остановка ---
    Q_INVOKABLE void stopTest(int lineIndex)
    {
        if (!m_model) return;

        if (lineIndex >= 0 && lineIndex < m_model->rowCount()) {
            Line *line = m_model->line(lineIndex);
            if (line) {
                qInfo() << "⏹ Остановка теста линии:" << line->description();
                line->setStatus(Line::OK);
            }
            if (m_timers.contains(lineIndex)) {
                m_timers[lineIndex]->stop();
                delete m_timers.take(lineIndex);
            }
        } else if (lineIndex < 0) {
            qInfo() << "⏹ Остановка теста всех линий";
            for (int i = 0; i < m_model->rowCount(); ++i) {
                Line *line = m_model->line(i);
                if (line)
                    line->setStatus(Line::OK);
            }
            if (m_timers.contains(-1)) {
                m_timers[-1]->stop();
                delete m_timers.take(-1);
            }
        }
    }

private:
    LinesModel *m_model;
    QMap<int, QTimer*> m_timers; // ключ = индекс линии, -1 = все линии
};

#endif // TESTCONTROLLER_H

