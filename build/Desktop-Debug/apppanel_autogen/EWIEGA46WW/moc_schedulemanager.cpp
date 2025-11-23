/****************************************************************************
** Meta object code from reading C++ file 'schedulemanager.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.4.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../../schedulemanager.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'schedulemanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 68
#error "This file was generated using the moc from 6.4.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

#ifndef Q_CONSTINIT
#define Q_CONSTINIT
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
namespace {
struct qt_meta_stringdata_ScheduleManager_t {
    uint offsetsAndSizes[34];
    char stringdata0[16];
    char stringdata1[19];
    char stringdata2[1];
    char stringdata3[9];
    char stringdata4[14];
    char stringdata5[13];
    char stringdata6[5];
    char stringdata7[11];
    char stringdata8[8];
    char stringdata9[5];
    char stringdata10[11];
    char stringdata11[6];
    char stringdata12[12];
    char stringdata13[19];
    char stringdata14[4];
    char stringdata15[6];
    char stringdata16[17];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_ScheduleManager_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_ScheduleManager_t qt_meta_stringdata_ScheduleManager = {
    {
        QT_MOC_LITERAL(0, 15),  // "ScheduleManager"
        QT_MOC_LITERAL(16, 18),  // "startTestRequested"
        QT_MOC_LITERAL(35, 0),  // ""
        QT_MOC_LITERAL(36, 8),  // "testType"
        QT_MOC_LITERAL(45, 13),  // "checkSchedule"
        QT_MOC_LITERAL(59, 12),  // "loadFromFile"
        QT_MOC_LITERAL(72, 4),  // "path"
        QT_MOC_LITERAL(77, 10),  // "saveToFile"
        QT_MOC_LITERAL(88, 7),  // "addTest"
        QT_MOC_LITERAL(96, 4),  // "data"
        QT_MOC_LITERAL(101, 10),  // "removeTest"
        QT_MOC_LITERAL(112, 5),  // "index"
        QT_MOC_LITERAL(118, 11),  // "getAllTests"
        QT_MOC_LITERAL(130, 18),  // "updateTestProperty"
        QT_MOC_LITERAL(149, 3),  // "key"
        QT_MOC_LITERAL(153, 5),  // "value"
        QT_MOC_LITERAL(159, 16)   // "resetRunningFlag"
    },
    "ScheduleManager",
    "startTestRequested",
    "",
    "testType",
    "checkSchedule",
    "loadFromFile",
    "path",
    "saveToFile",
    "addTest",
    "data",
    "removeTest",
    "index",
    "getAllTests",
    "updateTestProperty",
    "key",
    "value",
    "resetRunningFlag"
};
#undef QT_MOC_LITERAL
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_ScheduleManager[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   74,    2, 0x06,    1 /* Public */,

 // slots: name, argc, parameters, tag, flags, initial metatype offsets
       4,    0,   77,    2, 0x08,    3 /* Private */,

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       5,    1,   78,    2, 0x02,    4 /* Public */,
       7,    1,   81,    2, 0x02,    6 /* Public */,
       7,    0,   84,    2, 0x22,    8 /* Public | MethodCloned */,
       8,    1,   85,    2, 0x02,    9 /* Public */,
      10,    1,   88,    2, 0x02,   11 /* Public */,
      12,    0,   91,    2, 0x102,   13 /* Public | MethodIsConst  */,
      13,    3,   92,    2, 0x02,   14 /* Public */,
      16,    0,   99,    2, 0x02,   18 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    3,

 // slots: parameters
    QMetaType::Void,

 // methods: parameters
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void, QMetaType::QString,    6,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QVariantMap,    9,
    QMetaType::Void, QMetaType::Int,   11,
    QMetaType::QVariantList,
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::QVariant,   11,   14,   15,
    QMetaType::Void,

       0        // eod
};

Q_CONSTINIT const QMetaObject ScheduleManager::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_ScheduleManager.offsetsAndSizes,
    qt_meta_data_ScheduleManager,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_ScheduleManager_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<ScheduleManager, std::true_type>,
        // method 'startTestRequested'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<QString, std::false_type>,
        // method 'checkSchedule'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'loadFromFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'saveToFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'saveToFile'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'addTest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QVariantMap &, std::false_type>,
        // method 'removeTest'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'getAllTests'
        QtPrivate::TypeAndForceComplete<QVariantList, std::false_type>,
        // method 'updateTestProperty'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QVariant &, std::false_type>,
        // method 'resetRunningFlag'
        QtPrivate::TypeAndForceComplete<void, std::false_type>
    >,
    nullptr
} };

void ScheduleManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ScheduleManager *>(_o);
        (void)_t;
        switch (_id) {
        case 0: _t->startTestRequested((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 1: _t->checkSchedule(); break;
        case 2: _t->loadFromFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 3: _t->saveToFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1]))); break;
        case 4: _t->saveToFile(); break;
        case 5: _t->addTest((*reinterpret_cast< std::add_pointer_t<QVariantMap>>(_a[1]))); break;
        case 6: _t->removeTest((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 7: { QVariantList _r = _t->getAllTests();
            if (_a[0]) *reinterpret_cast< QVariantList*>(_a[0]) = std::move(_r); }  break;
        case 8: _t->updateTestProperty((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<QVariant>>(_a[3]))); break;
        case 9: _t->resetRunningFlag(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ScheduleManager::*)(QString );
            if (_t _q_method = &ScheduleManager::startTestRequested; *reinterpret_cast<_t *>(_a[1]) == _q_method) {
                *result = 0;
                return;
            }
        }
    }
}

const QMetaObject *ScheduleManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ScheduleManager::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ScheduleManager.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ScheduleManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 10;
    }
    return _id;
}

// SIGNAL 0
void ScheduleManager::startTestRequested(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(std::addressof(_t1))) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
