#include <QGuiApplication>
#include <QQuickStyle>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QFont>
#include "PasswordManager.h"
#include "ValueProvider.h"
#include "TimeAjst.h"
#include "linesmodel.h"
#include "testcontroller.h"
#include "systemObjects.h"
#include "schedulemanager.h"
#include "logger.h"
//using namespace Qt::StringLiterals;
extern void log(const QString &msg);

int main(int argc, char *argv[])
{
    // 1. Отключаем HighDPI, чтобы 1 px был 1 реальным пикселем
    QCoreApplication::setAttribute(Qt::AA_DisableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQuickStyle::setStyle("Fusion"); // или "Material", "Imagine" и т.д.
    // 2. Задаём один и тот же шрифт и базовый размер для всего приложения
    QFont font("DejaVu Sans");        // выбери шрифт, который точно есть и на Ubuntu, и на панели
    font.setPixelSize(30);            // базовый размер
    app.setFont(font);

    qmlRegisterType<TimeAjst>("App", 1, 0, "TimeAjst");
    qmlRegisterType<Line>("App", 1, 0, "Line");
    qmlRegisterType<LinesModel>("App", 1, 0, "LinesModel");
    qmlRegisterType<Network>("App", 1, 0, "Network");
    qmlRegisterType<System>("App", 1, 0, "System");
    qmlRegisterType<Mode>("App", 1, 0, "Mode");

    qmlRegisterSingletonType<Logger>("App.Logger", 1, 0, "Logger",[](QQmlEngine*, QJSEngine*) -> QObject* {return new Logger();});

    QQmlApplicationEngine engine;

    PasswordManager pwManager;
    engine.rootContext()->setContextProperty("pwManager", &pwManager);

    // пример ValueProvider (температура)
    ValueProvider temperature;
    temperature.setValue(25);
    engine.rootContext()->setContextProperty("temperature", &temperature);

    // пример LinesModel
    LinesModel lines;
    //lines.addLine("Цех", 234.3,236.3,1.01,228, 5.0, Line::Constant, Line::OK, Line::On);
    // lines.addLine("Насосная", 85.0, 0,0,0,10.0, Line::NonConstant, Line::OK, Line::Off);
    // lines.addLine("Склад", 120.0,0,0,0, 5.0, Line::NonConstant, Line::OK, Line::On);
    // lines.addLine("Лестница", 120.0,0,0,0, 5.0, Line::Constant, Line::OK, Line::On);
    if (!lines.loadFromFile("lines.json"))
        for (int i = 1; i<26;i++)lines.addLine(QString("Линия %1").arg(i), 0.0,0,0,0, 5.0, Line::NotUsed, Line::OK, Line::On);
    engine.rootContext()->setContextProperty("linesModel", &lines);

    TestController testController;
    testController.setModel(&lines);
    engine.rootContext()->setContextProperty("testController", &testController);

    ScheduleManager scheduleManager;
    scheduleManager.loadFromFile("schedule.json");
    engine.rootContext()->setContextProperty("scheduleManager", &scheduleManager);
    /*QObject::connect(
        &scheduleManager, &ScheduleManager::startTestRequested,
        &testController,   &TestController::startTest
        );*/

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
        &app, [url](QObject *obj, const QUrl &objUrl) { if (!obj && url == objUrl)QCoreApplication::exit(-1);},
        Qt::QueuedConnection);
    log("старт engine");
    engine.load(url);

    return app.exec();
}






