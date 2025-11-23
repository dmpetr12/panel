// logger.h
#pragma once
#include <QObject>
#include <QString>

class Logger : public QObject {
    Q_OBJECT
public:
    explicit Logger(QObject *parent = nullptr) : QObject(parent) {}

    Q_INVOKABLE void write(const QString &msg);
};

