import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

Window {
    id: win
    property int lineCount: 20 // задаем начальное значение
    visible: true
    width: 1024
    height: 768
    //flags: Qt.FramelessWindowHint
    color: "#FFFFFF"
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height

    // sample model — 20 линий
    ListModel {
        id: linesModel
        Component.onCompleted: {
            var statuses = [
                {status: "OK", color: "#5EC85E"},         // зелёный
                {status: "АВАРИЯ", color: "#FF4C4C"},     // красный
                {status: "ТЕСТ", color: "#FFC700"}    // жёлтый
            ];
            for (var i=1; i<=lineCount; ++i) {
                append( {"idT": "line" + i, "nameT": "ЛИНИЯ " + i,
                    "statusT": statuses[0].status,
                    "colorT": statuses[0].color
                })
            }
        }
    }
    // обработчик изменения количества линий
    onLineCountChanged: {
        linesModel.clear()
        for (var i=1; i<=lineCount; ++i) {
            append( {"nameT": "ЛИНИЯ " + i,
                "statusT": statuses[0].status,
                "colorT": statuses[0].color
            })
        }
    }
    ListModel {
        id: linesModel1
        Component.onCompleted: {
            var statuses = {
                "ok" : {status: "OK", color: "#5EC85E"},         // зелёный
                "fail" : {status: "АВАРИЯ", color: "#FF4C4C"},     // красный
                "work":{status: "РАБОЧИЙ", color: "#5EC85E"},    // зелёный
                "emergency" : {status: "АВАРИЙНЫЙ", color: "#FF4C4C"},     // красный
                "test":{status: "ТЕСТ", color: "#FFC700"}    // жёлтый
            };
            append({ nameT: "СЕТЬ", statusT: statuses["ok"].status, colorT: statuses["ok"].color })
            append({ nameT: "РЕЖИМ ", statusT: statuses["work"].status, colorT: statuses["work"].color })
            append({ nameT: "СИСТЕМА ", statusT: statuses["ok"].status, colorT: statuses["ok"].color })
        }
    }

    // верхняя панель — логотип и время
    Rectangle {
        id: header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 120
        color: "transparent"
        border.width: 0
        RowLayout {
            anchors.fill: parent
            anchors.margins: 12
            spacing: 20

            Image {
                source: "qrc:/logo.png"
                width: 100; height: 100
                fillMode: Image.Stretch
            }
            // Column {
            //     spacing: 2
            //     Text { text: "СВЕТОВЫЕ\nТЕХНОЛОГИИ"; font.pixelSize: 22; color: "#21323a"; font.bold: true }
            // }
            Item { Layout.fillWidth: true }

            Column {
                anchors.top: parent.top
                anchors.rightMargin: 20
                spacing: 4
                Text { id: dateText; text: Qt.formatDate(new Date(), "dd.MM.yyyy"); font.pixelSize: 30; color:"#000000" }
                Text { id: timeText; text: Qt.formatTime(new Date(), "hh:mm:ss"); font.pixelSize: 40; color:"#000000" }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: { timeText.text = Qt.formatTime(new Date(), "hh:mm:ss"); dateText.text = Qt.formatDate(new Date(), "dd.MM.yyyy") } }
            }
            Item { width: 140 }
        }
    }

    // основной контейнер — горизонтальный
    Rectangle {
        id: body
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height : 400
        anchors.margins: 12
        color: "transparent"

        RowLayout {
            anchors.fill: parent
            spacing: 20
            Rectangle {
                id: bodyleft
                height: parent.height
                width  : 550
                anchors.margins: 12
                color: "transparent"
                Column {
                    anchors.fill: parent
                    spacing: 8
                     Text { text: "СИСТЕМА"; font.pixelSize: 30;
                        color: "black"; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }
                     ListView {
                         id: listView1
                         width: parent.width
                         height: 330
                         model: linesModel1

                         delegate: Item {
                             id: lineItem
                             width: parent.width
                             height: 80

                             RowLayout {
                                 anchors.fill: parent
                                 anchors.margins: 10
                                 spacing: 10

                                 // Кружок или иконка
                                 Rectangle {
                                     width: 50
                                     height: 50
                                     color: colorT
                                     border.color: "black"
                                     radius: 25
                                 }


                                 // состояние кнопка
                                 Text {
                                     text: nameT
                                     color: "black"
                                     font.pixelSize: 40
                                     Layout.alignment: Qt.AlignVCenter

                                 }

                                 // Статус
                                 Text {
                                     text: statusT
                                     color: colorT
                                     font.pixelSize: 40
                                     Layout.alignment: Qt.AlignVCenter
                                     Layout.fillWidth: true
                                     horizontalAlignment: Text.AlignRight
                                }
                             }

                             // Разделитель
                             Rectangle {
                                 anchors.left: parent.left
                                 anchors.right: parent.right
                                 anchors.bottom: parent.bottom
                                 height: 1
                                 color: "#DDDDDD"
                             }
                         }
                     }

                }
            }
            Rectangle {
                width: 2              // толщина линии
                height: parent.height // высота линии
                color: "black"        // цвет линии
            }
            Rectangle {
                id: bodyright
                Layout.fillWidth: true   // займёт всё оставшееся место по ширине
                Layout.fillHeight: true  // можно, если хочешь по высоте тянуть
                color: "transparent"
                Column {
                    anchors.fill: parent
                    spacing: 25

                    Text {
                        text: "ЛИНИИ"
                        font.pixelSize: 30
                        color: "black"
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    ListView {
                        id: listView
                        width: parent.width
                        height: 330
                        model: linesModel

                        delegate: Item {
                            //id: lineItem
                            width: parent.width
                            height: 50

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 10

                                // Кружок или иконка
                                Rectangle {
                                    width: 24
                                    height: 24
                                    color: colorT
                                    border.color: "black"
                                    radius: 12
                                }


                                // состояние кнопка
                                Rectangle {
                                    id: idT
                                    width: 200; height: 38
                                    radius: 3; color: "#E7E7E7"

                                    Text {
                                        anchors.centerIn: parent
                                        text: nameT
                                        color: "black"
                                        font.bold: true
                                        font.pixelSize: 20
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onEntered: idT.color = "#E7E7E7"
                                        onExited: idT.color = "#E7E7E7"
                                        onPressed: idT.color = "black"
                                        onReleased: idT.color = "#E7E7E7"
                                        onClicked: console.log(idT+"нажата")
                                    }
                                }

                                // Статус
                                Text {
                                    text: statusT
                                    color: colorT
                                    font.pixelSize: 24
                                    Layout.alignment: Qt.AlignVCenter
                                    Layout.fillWidth: true
                                    horizontalAlignment: Text.AlignRight
                                }
                            }

                            // Разделитель
                            Rectangle {
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                height: 1
                                color: "#DDDDDD"
                            }
                        }
                    }
                }

            }
        }
    }
    //нижние четыре кнопки
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 250

        ColumnLayout {
            anchors.centerIn: parent
            spacing: 10  // расстояние между рядами
            // Первый ряд
            Row {
                spacing: 100  // расстояние между кнопками в ряду

                // первая кнопка
                Rectangle {
                    id: btnTest
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "ТЕСТ"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnTest.color = "grey"
                        onExited: btnTest.color = "grey"
                        onPressed: btnTest.color = "black"
                        onReleased: btnTest.color = "grey"
                        onClicked: console.log("Зелёная нажата")
                    }
                }

                // вторая кнопка
                Rectangle {
                    id: btnTestDur
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "ТЕСТ на время"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnTestDur.color = "grey"
                        onExited: btnTestDur.color = "grey"
                        onPressed: btnTestDur.color = "black"
                        onReleased: btnTestDur.color = "grey"
                        onClicked: console.log("Красная  нажата")
                    }
                }
            }

            // Второй ряд
            Row {
                spacing: 100

                // третья кнопка
                Rectangle {
                    id: btnBlue2
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "НАСТРОЙКА"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnBlue2.color = "grey"
                        onExited: btnBlue2.color = "grey"
                        onPressed: btnBlue2.color = "black"
                        onReleased: btnBlue2.color = "grey"
                        onClicked: console.log("Чёрная нажата")
                    }
                }

                // Расписание кнопка
                Rectangle {
                    id: btnRasp
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "РАСПИСАНИЕ"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnRasp.color = "grey"
                        onExited: btnRasp.color = "grey"
                        onPressed: btnRasp.color = "black"
                        onReleased: btnRasp.color = "grey"
                        onClicked: console.log("Желтая нажата")
                    }
                }
            }
        }
    }

    // счетчик
    Item {
        id: root
        width: 400; height: 200



        Text {
            id: counter
            anchors.centerIn: parent
            font.pixelSize: 40
            text: countdown > 0 ? countdown : "Время вышло!"
        }

        Timer {
            id: countdownTimer
            interval: 1000      // шаг = 1 секунда
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

        Button {
            text: "Старт"
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                countdown = 10   // сбросить значение
                countdownTimer.start()
            }
        }
    }

}
