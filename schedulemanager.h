#pragma once
#include <QObject>
#include <QDate>
#include <QTime>
#include <QTimer>
#include <QJsonArray>
#include <QJsonObject>
#include <QFile>
#include <QTextStream>

struct TestEntry {
    bool enabled = true;
    QString period;
    QDate startDate;
    QTime startTime;
    QString testType;
    QStringList weekDays;
};

class ScheduleManager : public QObject {
    Q_OBJECT
public:
    explicit ScheduleManager(QObject *parent = nullptr);

    Q_INVOKABLE void loadFromFile(const QString &path);
    Q_INVOKABLE void saveToFile(const QString &path = QString());
    Q_INVOKABLE void addTest(const QVariantMap &data);
    Q_INVOKABLE void removeTest(int index);
    Q_INVOKABLE QVariantList getAllTests() const;
    Q_INVOKABLE void updateTestProperty(int index, const QString &key, const QVariant &value);
    Q_INVOKABLE void resetRunningFlag();

signals:
    void startTestRequested(QString testType);

private slots:
    void checkSchedule();

private:
    QList<TestEntry> m_tests;
    QTimer m_timer;
    bool m_testRunning = false;
    QDateTime m_lastRun;
    QString m_filePath;

    void autoSave();
    void logEvent(const QString &text, bool scheduleOnly = false);
};
