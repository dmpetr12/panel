// logger.cpp
#include "logger.h"
#include "schedulemanager.h"   // где объявлен log()

extern void log(const QString &msg);

void Logger::write(const QString &msg) {
    log(msg);
}
