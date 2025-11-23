import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

// rect parent.width x 650
Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    Rectangle {
        id: body
        anchors.top: parent.top
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
                width  : 450
                anchors.margins: 12
                color: "transparent"
                Column {
                    anchors.fill: parent
                    spacing: 14
                    Network { id: net }
                    System { id: sys }
                    Mode { id: mode }

                    Text { text: "СИСТЕМА"; font.pixelSize: 40;
                        color: "black"; font.bold: true; anchors.horizontalCenter: parent.horizontalCenter }
                    //Сеть
                        // RowLayout {
                        //     Layout.preferredHeight:330
                        //     width: parent.width
                        //     anchors.margins: 10
                        //     spacing: 10

                        //     // Кружок или иконка
                        //     Rectangle {
                        //        width: 50
                        //        height: 50
                        //        color: net.statusColor()
                        //        border.color: "black"
                        //        radius: 25
                        //     }
                        //     // состояние кнопка
                        //     Text {
                        //         text: "Сеть: "
                        //         color: "black"
                        //         font.pixelSize: 40
                        //         Layout.alignment: Qt.AlignVCenter
                        //     }
                        //      // Статус
                        //      Text {
                        //          text: net.statusString()
                        //          color: net.statusColor()
                        //          font.pixelSize: 40
                        //          Layout.alignment: Qt.AlignVCenter
                        //          Layout.fillWidth: true
                        //          horizontalAlignment: Text.AlignRight
                        //     }
                        // }
                    //Режим
                    RowLayout {
                        Layout.preferredHeight:330
                        width: parent.width
                        anchors.margins: 10
                        spacing: 10
                        // Кружок или иконка
                        Rectangle {
                            width: 50
                            height: 50
                            color: mode.stateColor()
                            border.color: "black"
                            radius: 25
                        }
                        // состояние кнопка
                        Text {
                            text: "Режим: "
                            color: "black"
                            font.pixelSize: 40
                            Layout.alignment: Qt.AlignVCenter

                        }
                        // Статус
                        Text {
                            text: mode.stateString()
                            color: mode.stateColor()
                            font.pixelSize: 40
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                    //Система
                    RowLayout {
                        Layout.preferredHeight:330
                        width: parent.width
                        anchors.margins: 10
                        spacing: 10
                        // Кружок или иконка
                         Rectangle {
                            width: 50
                            height: 50
                            color: sys.statusColor()
                            border.color: "black"
                            radius: 25
                        }
                        // состояние кнопка
                        Text {
                            text: "Система: "
                            color: "black"
                            font.pixelSize: 40
                            Layout.alignment: Qt.AlignVCenter

                        }
                        // Статус
                        Text {
                            text: sys.statusString()
                            color: sys.statusColor()
                            font.pixelSize: 40
                            Layout.alignment: Qt.AlignVCenter
                            Layout.fillWidth: true
                            horizontalAlignment: Text.AlignRight
                        }
                    }
                    GridLayout {
                        columns: 3
                        rowSpacing: 10
                        columnSpacing: 10
                        Text { text: "Мощность";font.pixelSize: 30 }
                        Label {text: "224";font.pixelSize: 30 }
                        Text { text: "Вт ";font.pixelSize: 30 }
                        Text { text: "Напряжение";font.pixelSize: 30}
                        Label { text: "220";font.pixelSize: 30}
                        Text { text: "В";font.pixelSize: 30}
                        Text { text: "Ток";font.pixelSize: 30 }
                        Label {text: "1";font.pixelSize: 30}
                        Text { text: "А";font.pixelSize: 30 }
                        Text { text: "Частота";font.pixelSize: 30 }
                        Label {text: "50,1";font.pixelSize: 30}
                        Text { text: "Гц";font.pixelSize: 30 }
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
                    spacing:0

                    Text {
                        text: "ЛИНИИ"
                        font.pixelSize: 40
                        color: "black"
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: "              описание                              состояние  статус"
                        font.pixelSize: 20
                        color: "black"

                    }
                    Text {
                        text: "___"
                        font.pixelSize: 25
                        color: "white"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    ListView {
                        id: listView
                        width: parent.width
                        height: 280
                        model: linesModel

                        delegate: Item {
                            // Скрываем, если состояние "не используется"
                            visible: mode !== 2 && index < countLn// Line.NotUsed
                            width: parent.width
                            height: visible ? 50 : 0  // если не видно, высота = 0

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 10

                                // Кружок по статусу
                                Rectangle {
                                    id : roundButton
                                    width: 24
                                    height: 24
                                    radius: 12
                                    border.color: "black"
                                    color: status === 0 ? "#5EC85E"     // OK
                                          : status === 1 ? "#FF4C4C"     // АВАРИЯ
                                          : "#FFC700"                   // ТЕСТ

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onClicked: console.log( description + " нажата")
                                    }
                                }

                                // Кнопка с описанием
                                Rectangle {
                                    id: descButton
                                    width: 290; height: 38
                                    radius: 3
                                    color: "#E7E7E7"

                                    Text {
                                        text: (index+1)+": "+description
                                        color: "black"
                                        //font.bold: true
                                        font.pixelSize: 28
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: 6
                                        elide: Text.ElideRight
                                    }
                                }

                                // Состояние (вкл/выкл)
                                Text {
                                    text: lineState === Line.On ? "вкл" : "выкл"
                                    color: "black"
                                    font.pixelSize: 24
                                    Layout.alignment: Qt.AlignVCenter
                                }

                                // Текст статуса
                                Text {
                                    text: status === 0 ? "OK"
                                         : status === 1 ? "АВАРИЯ"
                                         : "ТЕСТ"
                                    color: status === 0 ? "#5EC85E"
                                          : status === 1 ? "#FF4C4C"
                                          : "#FFC700"
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
    //нижние  кнопки
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 250

        ColumnLayout {
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 30
            anchors.topMargin: 20
            spacing: 10  // расстояние между рядами

            // Первый ряд
            Row {
                //Layout.alignment: Qt.AlignRight | Qt.AlignTop
                spacing: 30  // расстояние между кнопками в ряду
                // нулевая кнопка кнопка входа
                Rectangle {
                    id: btnPass
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        id : txtPass
                        anchors.centerIn: parent
                        text: if (!unlocked) {"ВХОД"} else {"ВЫХОД"}
                        color: "white"
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnPass.color = "grey"
                        onExited: btnPass.color = "grey"
                        onPressed: btnPass.color = "black"
                        onReleased: btnPass.color = "grey"
                        onClicked: if (!unlocked){stackViewList.push("pagePass.qml") }
                                   else {unlocked =false }
                    }
                }



                // вторая кнопка
                // Rectangle {
                //     id: btnTestDur
                //     visible: unlocked
                //     width: 300; height: 100
                //     radius: 20; color: "grey"

                //     Text {
                //         anchors.centerIn: parent
                //         text: "ТЕСТ на время"
                //         color: if(!unlocked) {"grey"} else {"white"}
                //         font.bold: true
                //         font.pixelSize: 40
                //     }

                //     MouseArea {
                //         anchors.fill: parent
                //         hoverEnabled: true
                //         onEntered: btnTestDur.color = "grey"
                //         onExited: btnTestDur.color = "grey"
                //         onPressed: if (unlocked) {btnTestDur.color = "black"} else {btnTestDur.color = "grey"}
                //         onReleased: btnTestDur.color = "grey"
                //         onClicked: if (unlocked)stackViewList.push("pageAjaste.qml")
                //     }
                // }
            }

            // Второй ряд
            Row {
                Layout.alignment: Qt.AlignRight
                spacing: 30  // расстояние между кнопками в ряду

                // первая кнопка
                Rectangle {
                    id: btnTest
                    visible: unlocked
                    width: 300; height: 100
                    radius: 20; color:"grey"

                    Text {
                        anchors.centerIn: parent
                        text: "РУЧНОЙ ТЕСТ"
                        color: if(!unlocked) {"grey"} else {"white"}
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnTest.color = "grey"
                        onExited: btnTest.color = "grey"
                        onPressed: if (unlocked) {btnTest.color = "black"} else {btnTest.color = "grey"}
                        onReleased: btnTest.color = "grey"
                        onClicked: if (unlocked)stackViewList.push("pageTest.qml")
                    }
                }
                // // кнопка инфо
                // Rectangle {
                //     id: btnInfo
                //     width: 300; height: 100
                //     radius: 20;
                //     color: "grey"

                //     Text {
                //         anchors.centerIn: parent
                //         text: "ИНФОРМАЦИЯ"
                //         color: "white"
                //         font.bold: true
                //         font.pixelSize: 35
                //     }

                //     MouseArea {
                //         anchors.fill: parent
                //         hoverEnabled: true
                //         onEntered: btnInfo.color = "grey"
                //         onExited: btnInfo.color = "grey"
                //         onPressed: if (unlocked) {btnInfo.color = "black"} else {btnInfo.color = "grey"}
                //         onReleased: btnInfo.color = "grey"
                //         onClicked: stackViewList.push("pageInfo.qml")
                //     }
                // }
                // третья кнопка
                Rectangle {
                    id: btnAjst
                    visible: unlocked
                    width: 300; height: 100
                    radius: 20;
                    color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "НАСТРОЙКА"
                        color: if(!unlocked) {"grey"} else {"white"}
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnAjst.color = "grey"
                        onExited: btnAjst.color = "grey"
                        onPressed: if (unlocked) {btnAjst.color = "black"} else {btnAjst.color = "grey"}
                        onReleased: btnAjst.color = "grey"
                        onClicked: if (unlocked)stackViewList.push("pageAjaste.qml")
                    }
                }

                // Расписание кнопка
                Rectangle {
                    id: btnRasp
                    visible: unlocked
                    width: 300; height: 100
                    radius: 20; color: "grey"

                    Text {
                        anchors.centerIn: parent
                        text: "РАСПИСАНИЕ"
                        color: if(!unlocked) {"grey"} else {"white"}
                        font.bold: true
                        font.pixelSize: 40
                    }

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: btnRasp.color = "grey"
                        onExited: btnRasp.color = "grey"
                        onPressed: if (unlocked) {btnRasp.color = "black"} else {btnRasp.color = "grey"}
                        onReleased: btnRasp.color = "grey"
                        onClicked: if (unlocked) stackViewList.push("SchedulePage.qml")
                    }
                }
            }
        }
    }

}

