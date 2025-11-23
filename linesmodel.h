#ifndef LINESMODEL_H
#define LINESMODEL_H

#include <QAbstractListModel>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include "line.h"

class LinesModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum LineRoles {
        DescriptionRole = Qt::UserRole + 1,
        PowerRole,
        MPowerRole,
        CurrentRole,
        VoltageRole,
        ToleranceRole,
        ModeRole,
        StatusRole,
        LineStateRole
    };

    explicit LinesModel(QObject *parent = nullptr) : QAbstractListModel(parent) {}

    int rowCount(const QModelIndex &parent = QModelIndex()) const override {
        Q_UNUSED(parent)
        return m_lines.size();
    }

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override {
        if (!index.isValid() || index.row() < 0 || index.row() >= m_lines.size())
            return QVariant();

        Line *line = m_lines.at(index.row());
        switch (role) {
        case DescriptionRole: return line->description();
        case PowerRole: return line->power();
        case VoltageRole: return line->voltage();
        case MPowerRole: return line->mpower();
        case CurrentRole: return line->current();
        case ToleranceRole: return line->tolerance();
        case ModeRole: return line->mode();
        case StatusRole: return line->status();
        case LineStateRole: return line->lineState();
        default: return QVariant();
        }
    }

    bool setData(const QModelIndex &index, const QVariant &value, int role) override {
        if (!index.isValid() || index.row() < 0 || index.row() >= m_lines.size())
            return false;

        Line *line = m_lines.at(index.row());
        switch (role) {
        case DescriptionRole: line->setDescription(value.toString()); break;
        case PowerRole: line->setPower(value.toDouble()); break;
        case MPowerRole: line->setmPower(value.toDouble()); break;
        case CurrentRole: line->setCurrent(value.toDouble()); break;
        case VoltageRole: line->setVoltage(value.toDouble()); break;
        case ToleranceRole: line->setTolerance(value.toDouble()); break;
        case ModeRole: line->setMode(static_cast<Line::Mode>(value.toInt())); break;
        case StatusRole: line->setStatus(static_cast<Line::Status>(value.toInt())); break;
        case LineStateRole: line->setLineState(static_cast<Line::LineState>(value.toInt())); break;
        default: return false;
        }

        emit dataChanged(index, index, { role });
        return true;
    }

    Qt::ItemFlags flags(const QModelIndex &index) const override {
        if (!index.isValid())
            return Qt::NoItemFlags;
        return Qt::ItemIsEnabled | Qt::ItemIsSelectable | Qt::ItemIsEditable;
    }

    QHash<int, QByteArray> roleNames() const override {
        QHash<int, QByteArray> roles;
        roles[DescriptionRole] = "description";
        roles[PowerRole] = "power";
        roles[MPowerRole] = "mpower";
        roles[CurrentRole] = "current";
        roles[VoltageRole] = "voltage";
        roles[ToleranceRole] = "tolerance";
        roles[ModeRole] = "mode";
        roles[StatusRole] = "status";
        roles[LineStateRole] = "lineState";
        return roles;
    }
    Q_INVOKABLE Line* line(int index) const {
        if (index < 0 || index >= m_lines.size()) return nullptr;
        return m_lines.at(index);
    }

    Q_INVOKABLE void addLine(const QString &desc,
                             double power,
                             double mpower,
                             double current,
                             double voltage,
                             double tolerance,
                             Line::Mode mode,
                             Line::Status status,
                             Line::LineState lineState)
    {
        beginInsertRows(QModelIndex(), m_lines.size(), m_lines.size());
        Line *line = new Line(this);
        line->setDescription(desc);
        line->setPower(power);
        line->setmPower(mpower);
        line->setCurrent(current);
        line->setVoltage(voltage);
        line->setTolerance(tolerance);
        line->setMode(mode);
        line->setStatus(status);
        line->setLineState(lineState);
        m_lines.append(line);
        endInsertRows();
    }
    Q_INVOKABLE void removeLine(int index) {
        if (index < 0 || index >= m_lines.count())
            return;
        beginRemoveRows(QModelIndex(), index, index);
        delete m_lines.takeAt(index);
        endRemoveRows();
    }

    Q_INVOKABLE void clear() {
        beginResetModel();
        qDeleteAll(m_lines);
        m_lines.clear();
        endResetModel();
    }

    Q_INVOKABLE void updateLine(int row,
                                const QString &desc,
                                double power,
                                double mpower,
                                double current,
                                double voltage,
                                double tolerance,
                                int mode,
                                int status,
                                int lineState)
    {
        if (row < 0 || row >= m_lines.size()) return;
        QModelIndex idx = index(row);
        setData(idx, desc, DescriptionRole);
        setData(idx, power, PowerRole);
        setData(idx, mpower, MPowerRole);
        setData(idx, current, CurrentRole);
        setData(idx, voltage, VoltageRole);
        setData(idx, tolerance, ToleranceRole);
        setData(idx, mode, ModeRole);
        setData(idx, status, StatusRole);
        setData(idx, lineState, LineStateRole);
    }

    // 🔹 Сохранение в JSON файл
    Q_INVOKABLE bool saveToFile(const QString &filePath) {
        QJsonArray array;
        for (Line *line : m_lines) {
            QJsonObject obj;
            obj["description"] = line->description();
            obj["power"] = line->power();
            obj["mpower"] = line->mpower();
            obj["current"] = line->current();
            obj["voltage"] = line->voltage();
            obj["tolerance"] = line->tolerance();
            obj["mode"] = line->mode();
            obj["status"] = line->status();
            obj["lineState"] = line->lineState();
            array.append(obj);
        }
        QJsonDocument doc(array);

        QFile file(filePath);
        if (!file.open(QIODevice::WriteOnly))
            return false;
        file.write(doc.toJson());
        return true;
    }

    // 🔹 Загрузка из JSON файла
    Q_INVOKABLE bool loadFromFile(const QString &filePath) {
        QFile file(filePath);
        if (!file.open(QIODevice::ReadOnly))
            return false;

        QByteArray data = file.readAll();
        QJsonDocument doc = QJsonDocument::fromJson(data);
        if (!doc.isArray())
            return false;

        beginResetModel();
        qDeleteAll(m_lines);
        m_lines.clear();

        QJsonArray array = doc.array();
        for (const QJsonValue &val : array) {
            QJsonObject obj = val.toObject();
            Line *line = new Line(this);
            line->setDescription(obj["description"].toString());
            line->setPower(obj["power"].toDouble());
            line->setmPower(obj["mpower"].toDouble());
            line->setCurrent(obj["current"].toDouble());
            line->setVoltage(obj["voltage"].toDouble());
            line->setTolerance(obj["tolerance"].toDouble());
            line->setMode(static_cast<Line::Mode>(obj["mode"].toInt()));
            line->setStatus(static_cast<Line::Status>(obj["status"].toInt()));
            line->setLineState(static_cast<Line::LineState>(obj["lineState"].toInt()));
            m_lines.append(line);
        }
        endResetModel();
        return true;
    }

private:
    QList<Line*> m_lines;
};

#endif // LINESMODEL_H
