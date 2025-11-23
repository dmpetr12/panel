import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Logger 1.0

Page {
    id: settingsPage
    title: "Настройки теста"

    // из PageSchedule передаём только индекс
    property int currentIndex: -1

    // локальная копия для удобства работы в UI
    property var entry: ({})
    function loadEntry() {
        // получить снапшот и вытащить текущую запись
        var all = scheduleManager.getAllTests()
        entry = (currentIndex >= 0 && currentIndex < all.length) ? all[currentIndex] : ({})
    }
    function saveWeekDays(days) {
        scheduleManager.updateTestProperty(currentIndex, "weekDays", days)
        Logger.write("Изменены weekDays: " + days.join(","))
    }

    Component.onCompleted: loadEntry()
    onVisibleChanged: if (visible) loadEntry()

    header: ToolBar {
        height: 120
        RowLayout {
            anchors.fill: parent
            spacing: 12
            anchors.margins: 10

            // Назад
            Rectangle {
                id: btnRet
                width: 80; height: 80; radius: 6
                color: "lightgray"
                Image {
                    anchors.fill: parent
                    source: "qrc:/Back.png"
                    fillMode: Image.PreserveAspectFit
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: stackViewList.pop()
                }
            }

            Label {
                text: "Настройка теста"
                font.pixelSize: 40
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "white"

        GridLayout {
            anchors.fill: parent
            anchors.margins: 40
            columns: 2
            columnSpacing: 28
            rowSpacing: 26

            // Активность
            Label { text: "Активность:"; font.pixelSize: 36; Layout.alignment: Qt.AlignRight | Qt.AlignVCenter }
            Switch {
                id: enabledSwitch
                scale: 2.0
                checked: entry.enabled === true
                onToggled: {
                    scheduleManager.updateTestProperty(currentIndex, "enabled", checked)
                    Logger.write("enabled=" + checked)
                    entry.enabled = checked
                }
            }

            // Периодичность
            Label { text: "Периодичность:"; font.pixelSize: 36; Layout.alignment: Qt.AlignRight | Qt.AlignVCenter }
            ComboBox {
                id: periodBox
                width: 600; implicitWidth: width; height: 80
                font.pixelSize: 34
                model: ["один раз", "ежедневно", "дни недели", "раз в месяц", "раз в 3 месяца", "раз в полгода", "раз в год"]
                Component.onCompleted: currentIndex = model.indexOf(entry.period || "один раз")
                onActivated: {
                    scheduleManager.updateTestProperty(settingsPage.currentIndex, "period", model[currentIndex])
                    Logger.write("period=" + model[currentIndex])
                    entry.period = model[currentIndex]
                }
                popup: Popup {
                    y: periodBox.height
                    width: periodBox.width
                    implicitHeight: contentItem.implicitHeight + 8
                    modal: true; clip: false
                    background: Rectangle { color: "white"; border.color: "#aaa"; radius: 8 }
                    contentItem: ListView {
                        implicitHeight: contentHeight
                        model: periodBox.delegateModel
                        currentIndex: periodBox.highlightedIndex
                        clip: true
                        interactive: false
                    }
                }
                delegate: ItemDelegate {
                    width: periodBox.width
                    text: modelData
                    font.pixelSize: 32
                    highlighted: periodBox.highlightedIndex === index
                }
            }

            // Дата и время первого старта
            Label {
                text: "Дата и время\nпервого старта:"
                font.pixelSize: 36
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
            }
            ColumnLayout {
                spacing: 20
                Layout.fillWidth: true

                // Дата
                RowLayout {
                    spacing: 20

                    property bool initialized: false  // защита от триггера при загрузке

                    Component.onCompleted: {
                        const parts = (entry.startDate || "2025-01-01").split("-")
                        yearBox.value = parseInt(parts[0])
                        monthBox.value = parseInt(parts[1])
                        dayBox.value = parseInt(parts[2])
                        initialized = true
                    }

                    function updateDate() {
                        if (!initialized) return
                        const y = yearBox.value
                        const m = ("0" + monthBox.value).slice(-2)
                        const d = ("0" + dayBox.value).slice(-2)
                        const s = y + "-" + m + "-" + d
                        scheduleManager.updateTestProperty(currentIndex, "startDate", s)
                        Logger.write("startDate=" + s)
                        entry.startDate = s
                    }

                    // День
                    SpinBox {
                        id: dayBox
                        from: 1; to: 31
                        width: 120; height: 90; font.pixelSize: 36
                        onValueChanged: parent.updateDate()
                    }
                    Label { text: "д"; font.pixelSize: 30 }

                    // Месяц
                    SpinBox {
                        id: monthBox
                        from: 1; to: 12
                        width: 120; height: 90; font.pixelSize: 36
                        onValueChanged: parent.updateDate()
                    }
                    Label { text: "м"; font.pixelSize: 30 }

                    // Год
                    SpinBox {
                        id: yearBox
                        from: 2025; to: 2055
                        width: 150; height: 90; font.pixelSize: 36
                        onValueChanged: parent.updateDate()
                    }
                    Label { text: "г"; font.pixelSize: 30 }
                }

                // Время
                RowLayout {
                    spacing: 20
                    Label { text: "Время:"; font.pixelSize: 30; verticalAlignment: Text.AlignVCenter }

                    SpinBox {
                        id: hourBox
                        from: 0; to: 23
                        width: 150; height: 90; font.pixelSize: 36
                        Component.onCompleted: {
                            const t = (entry.startTime || "00:00").split(":")
                            value = parseInt(t[0])
                        }
                        onValueChanged: {
                            const hh = ("0" + hourBox.value).slice(-2)
                            const mm = ("0" + minuteBox.value).slice(-2)
                            const s = hh + ":" + mm
                            scheduleManager.updateTestProperty(currentIndex, "startTime", s)
                            Logger.write("startTime=" + s)
                            entry.startTime = s
                        }
                    }
                    Label { text: ":"; font.pixelSize: 40; verticalAlignment: Text.AlignVCenter }

                    SpinBox {
                        id: minuteBox
                        from: 0; to: 59
                        width: 150; height: 90; font.pixelSize: 36
                        Component.onCompleted: {
                            const t = (entry.startTime || "00:00").split(":")
                            value = parseInt(t[1])
                        }
                        onValueChanged: {
                            const hh = ("0" + hourBox.value).slice(-2)
                            const mm = ("0" + minuteBox.value).slice(-2)
                            const s = hh + ":" + mm
                            scheduleManager.updateTestProperty(currentIndex, "startTime", s)
                            Logger.write("startTime=" + s)
                            entry.startTime = s
                        }
                    }
                }

                // Дни недели
                ColumnLayout {
                    spacing: 10
                    Label { text: "Дни недели:"; font.pixelSize: 30 }

                    RowLayout {
                        id: weekRow
                        spacing: 10
                        Layout.fillWidth: true

                        property var daysList: [
                            { short: "Пн", key: "Mon" },
                            { short: "Вт", key: "Tue" },
                            { short: "Ср", key: "Wed" },
                            { short: "Чт", key: "Thu" },
                            { short: "Пт", key: "Fri" },
                            { short: "Сб", key: "Sat" },
                            { short: "Вс", key: "Sun" }
                        ]

                        // локальная копия массива, чтобы не дёргать C++ на каждое чтение
                        property var localDays: (entry.weekDays ? entry.weekDays.slice(0) : [])

                        Repeater {
                            model: weekRow.daysList
                            CheckBox {
                                text: modelData.short
                                font.pixelSize: 28
                                checked: weekRow.localDays.indexOf(modelData.key) !== -1
                                onToggled: {
                                    var arr = weekRow.localDays.slice(0)
                                    var pos = arr.indexOf(modelData.key)
                                    if (checked && pos === -1) arr.push(modelData.key)
                                    if (!checked && pos !== -1) arr.splice(pos, 1)
                                    weekRow.localDays = arr
                                    saveWeekDays(arr)
                                }
                            }
                        }
                    }
                }
            }

            // Тип теста
            Label { text: "Тип теста:"; font.pixelSize: 36; Layout.alignment: Qt.AlignRight | Qt.AlignVCenter }
            ComboBox {
                id: testTypeBox
                width: 600                     // ✅ фиксированная ширина
                height: 90
                font.pixelSize: 36
                model: ["Функциональный", "На время"]

                // установка начального значения
                Component.onCompleted: currentIndex = model.indexOf(entry.testType || "Функциональный")

                // при выборе пункта
                onActivated: {
                    scheduleManager.updateTestProperty(settingsPage.currentIndex, "testType", model[currentIndex])
                    Logger.write("testType=" + model[currentIndex])
                    entry.testType = model[currentIndex]
                }

                // увеличиваем размер выпадающего списка
                popup: Popup {
                    y: testTypeBox.height
                    width: 600                  // ✅ фиксированная ширина popup'а
                    implicitHeight: contentItem.implicitHeight
                    modal: true
                    clip: true

                    background: Rectangle {
                        color: "white"
                        border.color: "#aaa"
                        radius: 8
                    }

                    contentItem: ListView {
                        implicitHeight: contentHeight
                        model: testTypeBox.delegateModel
                        currentIndex: testTypeBox.highlightedIndex
                        clip: true
                    }
                }

                delegate: ItemDelegate {
                    width: 600                  // ✅ фиксированная ширина пунктов
                    height: 90
                    text: modelData
                    font.pixelSize: 36
                    highlighted: testTypeBox.highlightedIndex === index
                }
            }


        }
    }
}
