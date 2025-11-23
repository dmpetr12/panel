import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    property int countdown: 10
    property int selectedMinutes: 5    // значение по умолчанию

    Component.onCompleted: {
        if (linesModel && indexCh > -1) {
            currentLine = linesModel.line(indexCh)
            testName = "линия " + currentLine.description
        } else if (indexCh < 0)
        {testName = "все линии"; if (indexCh < -1)testName = "все линии на время"}
    }
    Component.onDestruction: {
        if (countdownTimer.running) {
            countdownTimer.stop()
            testController.stopTest(indexCh)
        }
    }


    Column {
        anchors.fill: parent
        anchors.margins: 50
        spacing: 20

        Row {
            Text {
                text: "ТЕСТ: " + testName
                font.pixelSize: 40
            }
        }

        Row {
            spacing: 80

            // --- Левая колонка (кнопка старт/стоп) ---
            Column {
                spacing: 20
                Rectangle {
                    width: 250
                    height: 90
                    radius: 12
                    color: "orange"

                    Text {
                        anchors.centerIn: parent
                        text: countdownTimer.running ? "Стоп" : "Старт"
                        font.pixelSize: 30
                        color: "white"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (countdownTimer.running) {
                                countdownTimer.stop()
                                 testController.stopTest(indexCh)   // ← остановка теста в C++
                            } else {
                                countdown = selectedMinutes * 60  // пересчёт в секунды
                                countdownTimer.start()
                                testController.startTest(indexCh, selectedMinutes)  // ← запуск теста
                            }
                        }
                    }
                }

                // --- Барабан для выбора времени ---
                Row {
                    spacing: 10
                    Text {
                        text: indexCh > -2 ? "Время теста, мин:" : "Время теста, ч:"
                        font.pixelSize: 28
                        verticalAlignment: Text.AlignVCenter
                    }
                    SpinBox {
                        id: spinMinutes
                        from: 1
                        to: indexCh > -2 ? 60 : 3
                        value: indexCh > -2 ?  selectedMinutes : 1
                        stepSize: 1
                        font.pixelSize: 30
                        width: 120
                        height: 80
                        onValueChanged: selectedMinutes = indexCh > -2 ? value : value*60
                    }
                }
            }

            // --- Правая колонка (счётчик времени) ---
            Column {
                spacing: 20
                Rectangle {
                    width: 250
                    height: 90
                    border.color: "lightgray"
                    border.width: 2
                    radius: 10

                    Text {
                        id: counter
                        anchors.centerIn: parent
                        font.pixelSize: 60
                        text: countdownTimer.running ? Math.floor(countdown / 60) + ":" + ("0" + (countdown % 60)).slice(-2) : ""
                    }

                    Timer {
                        id: countdownTimer
                        interval: 1000
                        repeat: true
                        running: false
                        onTriggered: {
                            if (countdown > 0) {
                                countdown--
                            } else {
                                stop()
                            }
                        }
                    }

                }
            }
        }
    }

    // --- Нижняя панель с кнопкой "Назад" ---
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 150
        anchors.margins: 12
        color: "transparent"

        Row {
            Rectangle {
                id: btnRet
                width: 150
                height: 150
                color: "lightgray"
                radius: 6
                Image {
                    anchors.fill: parent
                    source: "qrc:/Back.png"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: btnRet.color = "lightgray"
                    onExited: btnRet.color = "lightgray"
                    onPressed: btnRet.color = "gray"
                    onReleased: btnRet.color = "lightgray"
                    onClicked: stackViewList.pop()
                }
            }
        }
    }
}

