/****************************************************************************
** Meta object code from reading C++ file 'linesmodel.h'
**
** Created by: The Qt Meta Object Compiler version 68 (Qt 6.4.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../../../linesmodel.h"
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'linesmodel.h' doesn't include <QObject>."
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
struct qt_meta_stringdata_LinesModel_t {
    uint offsetsAndSizes[50];
    char stringdata0[11];
    char stringdata1[5];
    char stringdata2[6];
    char stringdata3[1];
    char stringdata4[6];
    char stringdata5[8];
    char stringdata6[5];
    char stringdata7[6];
    char stringdata8[7];
    char stringdata9[8];
    char stringdata10[8];
    char stringdata11[10];
    char stringdata12[11];
    char stringdata13[5];
    char stringdata14[13];
    char stringdata15[7];
    char stringdata16[16];
    char stringdata17[10];
    char stringdata18[11];
    char stringdata19[6];
    char stringdata20[11];
    char stringdata21[4];
    char stringdata22[11];
    char stringdata23[9];
    char stringdata24[13];
};
#define QT_MOC_LITERAL(ofs, len) \
    uint(sizeof(qt_meta_stringdata_LinesModel_t::offsetsAndSizes) + ofs), len 
Q_CONSTINIT static const qt_meta_stringdata_LinesModel_t qt_meta_stringdata_LinesModel = {
    {
        QT_MOC_LITERAL(0, 10),  // "LinesModel"
        QT_MOC_LITERAL(11, 4),  // "line"
        QT_MOC_LITERAL(16, 5),  // "Line*"
        QT_MOC_LITERAL(22, 0),  // ""
        QT_MOC_LITERAL(23, 5),  // "index"
        QT_MOC_LITERAL(29, 7),  // "addLine"
        QT_MOC_LITERAL(37, 4),  // "desc"
        QT_MOC_LITERAL(42, 5),  // "power"
        QT_MOC_LITERAL(48, 6),  // "mpower"
        QT_MOC_LITERAL(55, 7),  // "current"
        QT_MOC_LITERAL(63, 7),  // "voltage"
        QT_MOC_LITERAL(71, 9),  // "tolerance"
        QT_MOC_LITERAL(81, 10),  // "Line::Mode"
        QT_MOC_LITERAL(92, 4),  // "mode"
        QT_MOC_LITERAL(97, 12),  // "Line::Status"
        QT_MOC_LITERAL(110, 6),  // "status"
        QT_MOC_LITERAL(117, 15),  // "Line::LineState"
        QT_MOC_LITERAL(133, 9),  // "lineState"
        QT_MOC_LITERAL(143, 10),  // "removeLine"
        QT_MOC_LITERAL(154, 5),  // "clear"
        QT_MOC_LITERAL(160, 10),  // "updateLine"
        QT_MOC_LITERAL(171, 3),  // "row"
        QT_MOC_LITERAL(175, 10),  // "saveToFile"
        QT_MOC_LITERAL(186, 8),  // "filePath"
        QT_MOC_LITERAL(195, 12)   // "loadFromFile"
    },
    "LinesModel",
    "line",
    "Line*",
    "",
    "index",
    "addLine",
    "desc",
    "power",
    "mpower",
    "current",
    "voltage",
    "tolerance",
    "Line::Mode",
    "mode",
    "Line::Status",
    "status",
    "Line::LineState",
    "lineState",
    "removeLine",
    "clear",
    "updateLine",
    "row",
    "saveToFile",
    "filePath",
    "loadFromFile"
};
#undef QT_MOC_LITERAL
} // unnamed namespace

Q_CONSTINIT static const uint qt_meta_data_LinesModel[] = {

 // content:
      10,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags, initial metatype offsets
       1,    1,   56,    3, 0x102,    1 /* Public | MethodIsConst  */,
       5,    9,   59,    3, 0x02,    3 /* Public */,
      18,    1,   78,    3, 0x02,   13 /* Public */,
      19,    0,   81,    3, 0x02,   15 /* Public */,
      20,   10,   82,    3, 0x02,   16 /* Public */,
      22,    1,  103,    3, 0x02,   27 /* Public */,
      24,    1,  106,    3, 0x02,   29 /* Public */,

 // methods: parameters
    0x80000000 | 2, QMetaType::Int,    4,
    QMetaType::Void, QMetaType::QString, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, 0x80000000 | 12, 0x80000000 | 14, 0x80000000 | 16,    6,    7,    8,    9,   10,   11,   13,   15,   17,
    QMetaType::Void, QMetaType::Int,    4,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int, QMetaType::QString, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Double, QMetaType::Int, QMetaType::Int, QMetaType::Int,   21,    6,    7,    8,    9,   10,   11,   13,   15,   17,
    QMetaType::Bool, QMetaType::QString,   23,
    QMetaType::Bool, QMetaType::QString,   23,

       0        // eod
};

Q_CONSTINIT const QMetaObject LinesModel::staticMetaObject = { {
    QMetaObject::SuperData::link<QAbstractListModel::staticMetaObject>(),
    qt_meta_stringdata_LinesModel.offsetsAndSizes,
    qt_meta_data_LinesModel,
    qt_static_metacall,
    nullptr,
    qt_incomplete_metaTypeArray<qt_meta_stringdata_LinesModel_t,
        // Q_OBJECT / Q_GADGET
        QtPrivate::TypeAndForceComplete<LinesModel, std::true_type>,
        // method 'line'
        QtPrivate::TypeAndForceComplete<Line *, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'addLine'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<Line::Mode, std::false_type>,
        QtPrivate::TypeAndForceComplete<Line::Status, std::false_type>,
        QtPrivate::TypeAndForceComplete<Line::LineState, std::false_type>,
        // method 'removeLine'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'clear'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        // method 'updateLine'
        QtPrivate::TypeAndForceComplete<void, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<double, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        QtPrivate::TypeAndForceComplete<int, std::false_type>,
        // method 'saveToFile'
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>,
        // method 'loadFromFile'
        QtPrivate::TypeAndForceComplete<bool, std::false_type>,
        QtPrivate::TypeAndForceComplete<const QString &, std::false_type>
    >,
    nullptr
} };

void LinesModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<LinesModel *>(_o);
        (void)_t;
        switch (_id) {
        case 0: { Line* _r = _t->line((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])));
            if (_a[0]) *reinterpret_cast< Line**>(_a[0]) = std::move(_r); }  break;
        case 1: _t->addLine((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<Line::Mode>>(_a[7])),(*reinterpret_cast< std::add_pointer_t<Line::Status>>(_a[8])),(*reinterpret_cast< std::add_pointer_t<Line::LineState>>(_a[9]))); break;
        case 2: _t->removeLine((*reinterpret_cast< std::add_pointer_t<int>>(_a[1]))); break;
        case 3: _t->clear(); break;
        case 4: _t->updateLine((*reinterpret_cast< std::add_pointer_t<int>>(_a[1])),(*reinterpret_cast< std::add_pointer_t<QString>>(_a[2])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[3])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[4])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[5])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[6])),(*reinterpret_cast< std::add_pointer_t<double>>(_a[7])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[8])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[9])),(*reinterpret_cast< std::add_pointer_t<int>>(_a[10]))); break;
        case 5: { bool _r = _t->saveToFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->loadFromFile((*reinterpret_cast< std::add_pointer_t<QString>>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

const QMetaObject *LinesModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *LinesModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_LinesModel.stringdata0))
        return static_cast<void*>(this);
    return QAbstractListModel::qt_metacast(_clname);
}

int LinesModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<QMetaType *>(_a[0]) = QMetaType();
        _id -= 7;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
