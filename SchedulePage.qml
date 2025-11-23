import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Logger 1.0

Page {
    id: page
    title: "Расписание тестов"

    property int currentRow: -1

    function refresh() {
        list.model = scheduleManager.getAllTests()
        if (currentRow >= list.count) currentRow = -1
    }

    Component.onCompleted: refresh()
    onVisibleChanged: if (visible) refresh()

    header: ToolBar {
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
                text: "Расписание тестов"
                font.pixelSize: 34
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            // Добавить
            Rectangle {
                width: 200; height: 80; radius: 10
                color: "orange"
                Text {
                    anchors.centerIn: parent
                    text: "Добавить"
                    font.pixelSize: 26
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        scheduleManager.addTest({
                            "enabled": true,
                            "period": "один раз",
                            "startDate": "2025-06-15",
                            "startTime": "00:00",
                            "testType": "Функциональный",
                            "weekDays": []
                        })
                        Logger.write("Добавлена запись расписания")
                        refresh()
                    }
                }
            }

            // Удалить
            Rectangle {
                width: 200; height: 80; radius: 10
                color: currentRow >= 0 ? "orange" : "grey"
                Text {
                    anchors.centerIn: parent
                    text: "Удалить"
                    font.pixelSize: 26
                    color: "white"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: if (currentRow >= 0) {
                        scheduleManager.removeTest(currentRow)
                        Logger.write("Удалена запись №" + currentRow)
                        currentRow = -1
                        refresh()
                    }
                }
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 12
        spacing: 8

        // Заголовок таблицы
        Rectangle {
            Layout.fillWidth: true
            height: 50
            color: "#f2f2f2"
            border.color: "#d0d0d0"
            radius: 6

            RowLayout {
                anchors.fill: parent
                anchors.margins: 6
                spacing: 6
                Label { text: "Вкл"; Layout.preferredWidth: 70; horizontalAlignment: Text.AlignHCenter; font.pixelSize: 24 }
                Label { text: "Период"; Layout.preferredWidth: 170; font.pixelSize: 24 }
                Label { text: "Дата"; Layout.preferredWidth: 140; font.pixelSize: 24 }
                Label { text: "Время"; Layout.preferredWidth: 90; font.pixelSize: 24 }
                Label { text: "Дни"; Layout.preferredWidth: 280; font.pixelSize: 24 }
                Label { text: "Описание теста"; Layout.fillWidth: true; font.pixelSize: 24 }
            }
        }

        // Список
        Frame {
            Layout.fillWidth: true
            Layout.fillHeight: true
            padding: 0

            ListView {
                id: list
                anchors.fill: parent
                clip: true
                spacing: 4

                delegate: Rectangle {
                    width: list.width
                    height: 52
                    radius: 6
                    color: ListView.isCurrentItem ? "#eaf4ff" : "#ffffff"
                    border.color: ListView.isCurrentItem ? "#80b0ff" : "#cccccc"

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            list.currentIndex = index
                            page.currentRow = index
                        }
                        onDoubleClicked: {
                            stackViewList.push("TestSettingsPage.qml", { currentIndex: index })
                        }
                    }

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 6
                        spacing: 6

                        CheckBox {
                            Layout.preferredWidth: 70
                            checked: modelData.enabled
                            onToggled: {
                                scheduleManager.updateTestProperty(index, "enabled", checked)
                                Logger.write("Строка " + index + ": enabled=" + checked)
                                refresh()
                            }
                        }

                        Label { text: modelData.period;     Layout.preferredWidth: 170; font.pixelSize: 24 }
                        Label { text: modelData.startDate;  Layout.preferredWidth: 140; font.pixelSize: 24 }
                        Label { text: modelData.startTime;  Layout.preferredWidth: 90;  font.pixelSize: 24 }
                        Label {
                            text: {
                                if (modelData.period === "дни недели" && modelData.weekDays && modelData.weekDays.length > 0) {
                                    const names = {
                                        "Mon": "Пн",
                                        "Tue": "Вт",
                                        "Wed": "Ср",
                                        "Thu": "Чт",
                                        "Fri": "Пт",
                                        "Sat": "Сб",
                                        "Sun": "Вс"
                                    }
                                    return modelData.weekDays.map(d => names[d] || d).join(", ")
                                }
                                return "-"
                            }
                            Layout.preferredWidth: 280
                            font.pixelSize: 22
                            elide: Text.ElideRight
                        }
                        Label {
                            text: modelData.testType
                            Layout.fillWidth: true
                            font.pixelSize: 24
                            elide: Text.ElideRight
                        }
                    }
                }
            }
        }
    }
}
