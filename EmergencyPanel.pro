QT += quick quickcontrols2 core gui

CONFIG += c++17

SOURCES += main.cpp \
    logger.cpp \
    schedulemanager.cpp

RESOURCES += resources.qrc

TARGET = EmergencyPanel
TEMPLATE = app

# Опционально: если используешь специфичные модули
# QT += qml

DISTFILES +=

FORMS +=

HEADERS += \
    PasswordManager.h \
    TimeAjst.h \
    ValueProvider.h \
    line.h \
    linesModel.h \
    logger.h \
    schedulemanager.h \
    systemObjects.h \
    testcontroller.h
