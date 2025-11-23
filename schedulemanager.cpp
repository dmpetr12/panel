#include "schedulemanager.h"
#include <QJsonDocument>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QMutex>

// --- Безопасные ленивые singletons (вместо глобальных static) ---
static QMutex& logMutex() {
    static QMutex m;
    return m;
}

static QFile& systemLogFile() {
    static QFile f;
    return f;
}

static QFile& scheduleLogFile() {
    static QFile f;
    return f;
}

// --- Константы ---
static const qint64 MAX_LOG_SIZE = 10 * 1024 * 1024; // 10 МБ
static const int MAX_LOG_FILES = 5;

// --- Вспомогательная функция ротации ---
static void rotateLogs(const QString &baseName) {
    QFile baseFile(baseName);
    if (baseFile.exists() && baseFile.size() >= MAX_LOG_SIZE) {
        QString oldFile = QString("%1_%2.txt")
        .arg(baseName.left(baseName.size() - 4))
            .arg(MAX_LOG_FILES);
        if (QFile::exists(oldFile))
            QFile::remove(oldFile);

        for (int i = MAX_LOG_FILES - 1; i >= 1; --i) {
            QString src = QString("%1_%2.txt").arg(baseName.left(baseName.size() - 4)).arg(i);
            QString dst = QString("%1_%2.txt").arg(baseName.left(baseName.size() - 4)).arg(i + 1);
            if (QFile::exists(src))
                QFile::rename(src, dst);
        }

        QString rotated = QString("%1_1.txt").arg(baseName.left(baseName.size() - 4));
        baseFile.rename(rotated);
    }
}

// --- Инициализация логов ---
static void initLogFiles() {
    QDir().mkpath(".");

    rotateLogs("system_log.txt");
    rotateLogs("schedule_log.txt");

    if (!systemLogFile().isOpen()) {
        systemLogFile().setFileName("system_log.txt");
        systemLogFile().open(QIODevice::Append | QIODevice::Text);
    }

    if (!scheduleLogFile().isOpen()) {
        scheduleLogFile().setFileName("schedule_log.txt");
        scheduleLogFile().open(QIODevice::Append | QIODevice::Text);
    }
}

// --- Запись в файл ---
static void logToFile(QFile &file, const QString &text) {
    QMutexLocker locker(&logMutex());
    if (!file.isOpen()) return;

    QTextStream out(&file);
    out.setEncoding(QStringConverter::Utf8);
    out << "[" << QDateTime::currentDateTime().toString("yyyy-MM-dd hh:mm:ss") << "] "
        << text << "\n";
    out.flush();

    if (file.size() >= MAX_LOG_SIZE) {
        QString name = file.fileName();
        file.close();
        rotateLogs(name);
        file.open(QIODevice::Append | QIODevice::Text);
    }
}

// --- Глобальные функции для внешнего использования ---
void log(const QString &msg) {
    logToFile(systemLogFile(),msg );
    qInfo().noquote() << msg;
}

// =========================================================
//              ScheduleManager
// =========================================================

ScheduleManager::ScheduleManager(QObject *parent)
    : QObject(parent),
    m_filePath("schedule.json")
{
    initLogFiles();
    connect(&m_timer, &QTimer::timeout, this, &ScheduleManager::checkSchedule);
    m_timer.start(30'000);
    logEvent("ScheduleManager инициализирован, проверка каждые 30 секунд");
}

void ScheduleManager::logEvent(const QString &text, bool scheduleOnly) {
    QString msg = text;
    qInfo().noquote() << msg;
    logToFile(systemLogFile(), msg);
    if (scheduleOnly || msg.contains("тест", Qt::CaseInsensitive))
        logToFile(scheduleLogFile(), msg);
}

void ScheduleManager::loadFromFile(const QString &path) {
    m_filePath = path.isEmpty() ? "schedule.json" : path;
    QFile file(m_filePath);

    if (!file.exists()) {
        logEvent("ℹ️ Файл расписания не найден, создаю новый: " + m_filePath);
        saveToFile(m_filePath);
        return;
    }

    if (!file.open(QIODevice::ReadOnly)) {
        logEvent("⚠️ Не удалось открыть файл расписания: " + m_filePath);
        return;
    }

    QJsonDocument doc = QJsonDocument::fromJson(file.readAll());
    file.close();

    m_tests.clear();
    const QJsonArray arr = doc.array();
    for (const QJsonValue &value : arr) {
        QJsonObject obj = value.toObject();
        TestEntry e;
        e.enabled = obj["enabled"].toBool();
        e.period = obj["period"].toString();
        e.startDate = QDate::fromString(obj["startDate"].toString(), "yyyy-MM-dd");
        e.startTime = QTime::fromString(obj["startTime"].toString(), "HH:mm");
        e.testType = obj["testType"].toString();

        const QJsonArray weekArr = obj["weekDays"].toArray();
        for (const QJsonValue &d : weekArr)
            e.weekDays << d.toString();
        m_tests.append(e);
    }

    logEvent(QString("✅ Расписание загружено (%1 тестов)").arg(m_tests.size()));
}

void ScheduleManager::saveToFile(const QString &path) {
    QString targetPath = path.isEmpty() ? m_filePath : path;
    if (targetPath.isEmpty())
        targetPath = "schedule.json";

    QJsonArray arr;
    const QList<TestEntry> &tests = m_tests;
    for (const auto &e : tests) {
        QJsonObject obj;
        obj["enabled"] = e.enabled;
        obj["period"] = e.period;
        obj["startDate"] = e.startDate.toString("yyyy-MM-dd");
        obj["startTime"] = e.startTime.toString("HH:mm");
        obj["testType"] = e.testType;

        QJsonArray weekArr;
        for (const auto &d : e.weekDays)
            weekArr.append(d);
        obj["weekDays"] = weekArr;

        arr.append(obj);
    }

    QFile file(targetPath);
    if (file.open(QIODevice::WriteOnly)) {
        file.write(QJsonDocument(arr).toJson(QJsonDocument::Indented));
        file.close();
        logEvent("💾 Расписание сохранено в " + targetPath);
    }
}

void ScheduleManager::autoSave() {
    static QDateTime lastSave;
    if (m_tests.isEmpty())
        return;

    if (lastSave.isValid() &&
        lastSave.msecsTo(QDateTime::currentDateTime()) < 500)
        return;

    lastSave = QDateTime::currentDateTime();
    saveToFile();
}

void ScheduleManager::addTest(const QVariantMap &data) {
    TestEntry e;
    e.enabled = data.value("enabled", true).toBool();
    e.period = data.value("period").toString();

    QString dateStr = data.value("startDate").toString();
    QString timeStr = data.value("startTime").toString();

    e.startDate = QDate::fromString(dateStr, "yyyy-MM-dd");
    e.startTime = QTime::fromString(timeStr, "HH:mm");
    e.testType = data.value("testType").toString();

    const QVariantList rawDays = data.value("weekDays").toList();
    for (const auto &d : rawDays)
        e.weekDays.append(d.toString());

    m_tests.append(e);
    logEvent(QString("➕ Добавлен новый тест: %1 (%2)").arg(e.testType, e.period));
    saveToFile(); // сохраняем сразу
}

void ScheduleManager::removeTest(int index) {
    if (index >= 0 && index < m_tests.size()) {
        QString name = m_tests[index].testType;
        m_tests.removeAt(index);
        autoSave();
        logEvent("🗑 Удалён тест: " + name);
    }
}

QVariantList ScheduleManager::getAllTests() const {
    QVariantList list;
    for (const auto &e : m_tests) {
        QVariantMap map;
        map["enabled"] = e.enabled;
        map["period"] = e.period;
        map["startDate"] = e.startDate.toString("yyyy-MM-dd");
        map["startTime"] = e.startTime.toString("HH:mm");
        map["testType"] = e.testType;
        map["weekDays"] = e.weekDays;
        list.append(map);
    }
    return list;
}

void ScheduleManager::updateTestProperty(int index, const QString &key, const QVariant &value) {
    if (index < 0 || index >= m_tests.size())
        return;

    TestEntry &e = m_tests[index];

    if (key == "enabled") e.enabled = value.toBool();
    else if (key == "period") e.period = value.toString();
    else if (key == "startDate") e.startDate = QDate::fromString(value.toString(), "yyyy-MM-dd");
    else if (key == "startTime") e.startTime = QTime::fromString(value.toString(), "HH:mm");
    else if (key == "testType") e.testType = value.toString();
    else if (key == "weekDays") e.weekDays = value.toStringList();

    autoSave();
    logEvent(QString("✏️ Обновлено поле [%1] у теста %2").arg(key, e.testType));
}

void ScheduleManager::resetRunningFlag() {
    m_testRunning = false;
    logEvent("✅ Разблокирован флаг выполнения теста");
}

void ScheduleManager::checkSchedule() {
    if (m_testRunning) {
        logEvent("⏸ Тест выполняется — проверка пропущена", true);
        // временно для отладки:
        m_testRunning = false;
        return;
    }

    const QDateTime now = QDateTime::currentDateTime();

    for (auto &e : m_tests) {
        if (!e.enabled)
            continue;

        if (!e.startDate.isValid() || !e.startTime.isValid()) {
            logEvent(QString("⚠️ Пропущен тест [%1] — некорректная дата или время").arg(e.testType), true);
            continue;
        }

        const QDateTime planned(e.startDate, e.startTime);
        if (!planned.isValid()) {
            logEvent(QString("⚠️ Пропущен тест [%1] — некорректная дата-время").arg(e.testType), true);
            continue;
        }

        qint64 diff = qAbs(planned.secsTo(now));

        if (diff <= 30) {
            QString msg = QString("▶ Запуск теста [%1], период: %2").arg(e.testType, e.period);
            m_testRunning = true;
            m_lastRun = now;
            emit startTestRequested(e.testType);
            logEvent(msg, true);
            return;
        }
    }
}
