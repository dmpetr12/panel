import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

Page {
    id: lineEditPage
    property bool tested: false // кнопки разаблокированы

    property string saveFilePath: "lines.json"
    Component.onCompleted: if (linesModel) currentLine = linesModel.line(indexCh)
    Component.onDestruction: if (tested) testController.stopTest(indexCh)

    Column {
        anchors.fill: parent
        anchors.leftMargin: 20
        //spacing: 15

        Text {
            text: "Настройка линии: " + (currentLine ? currentLine.description : "")
            font.pixelSize: 30
        }

        GridLayout {
            columns: 2
            rowSpacing: 10
            columnSpacing: 10

            Text { text: "Описание:";font.pixelSize: 30 ;Layout.alignment: Qt.AlignRight }

            Rectangle {
                width: 600; height: 40

                TextField {
                    id: lineNameField
                    width: 600
                    text: currentLine ? currentLine.description : ""
                    font.pixelSize: 30
                    readOnly: true
                    onTextChanged: if (currentLine) currentLine.description = text
                    TapHandler {
                        onTapped: keyboard.openFor(lineNameField)
                    }
                }


            }

            Rectangle {
                 width: 250
                 height: 90
                 radius: 12
                 color: "orange"

                 Text {
                     anchors.centerIn: parent
                     text: tested ? "Стоп" : "Тест"
                     font.pixelSize: 30
                     color: "white"
                 }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: {
                         if (tested) {
                              testController.stopTest(indexCh)   // ← остановка теста в C++
                         } else {
                             testController.startTest(indexCh, 300)  // ← запуск теста
                         }
                         tested= !tested
                     }
                 }
            }
             Rectangle {
                 width: 250
                 height: 90
                 radius: 12
                 color: "orange"
                 visible: tested

                 Text {
                     anchors.centerIn: parent
                     text: "ввести
измеренное"
                     font.pixelSize: 30
                     color: "white"
                 }

                 MouseArea {
                     anchors.fill: parent
                     onClicked: {
                         sbW.value =currentLine ? currentLine.power : 0
                         sbmW.value = currentLine ? currentLine.power %1*10 : 0
                     }
                 }
             }



            Text { Layout.row: 4; text: "Установочная мощность, Вт:";font.pixelSize: 30;Layout.alignment: Qt.AlignRight }
            RowLayout{
                SpinBox {
                    id: sbW
                    font.pixelSize: 30
                    from: 0
                    to: 2000
                    value: showPower
                    onValueChanged: if (currentLine) currentLine.mpower = value +sbmW.value/10.0
                }
                Text {text: " , ";font.pixelSize: 30}
                SpinBox {
                    id : sbmW
                    font.pixelSize: 30
                    from: 0
                    to: 9
                    value: (showPower % 1)*10
                    onValueChanged: if (currentLine) currentLine.mpower = value/10.0 + sbW.value
                }
                Text {text: "  ";font.pixelSize: 30}

            }
            //Text { text: "" }

            Text {
                Layout.row: 5
                text: "Мощность, Вт:";font.pixelSize: 30;Layout.alignment: Qt.AlignRight
                //Layout.row : 2
            }
            Label {visible: tested
                text: currentLine ? currentLine.power : 0;font.pixelSize: 30
            }

            Text { Layout.row: 6; text: "Напряжение, В:";font.pixelSize: 30;Layout.alignment: Qt.AlignRight }
            Label {
                visible: tested
                text: currentLine ? currentLine.voltage : 0;font.pixelSize: 30
            }

            Text {  Layout.row: 7;text: "Ток, А:";font.pixelSize: 30 ;Layout.alignment: Qt.AlignRight}
            Label {
                visible: tested
                text: currentLine ? currentLine.current : 0;font.pixelSize: 30
            }

            Text { Layout.row: 8;text: "Допуск, %";font.pixelSize: 30;Layout.alignment: Qt.AlignRight }
            SpinBox {
                from: 0
                to: 100
                font.pixelSize: 30
                value: currentLine ? currentLine.tolerance : 0
                onValueChanged: if (currentLine) currentLine.tolerance = value
            }

            Text { text: "Режим работы:";font.pixelSize: 35;Layout.alignment: Qt.AlignRight }
            Rectangle { width: 300; height: 40
                ComboBox {
                    id: control
                    font.pixelSize: 35
                    anchors.fill: parent


                    delegate: ItemDelegate {
                        width: control.width
                        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
                        font.weight: control.currentIndex === index ? Font.DemiBold : Font.Normal
                        font.family: control.font.family
                        font.pointSize: control.font.pointSize
                        highlighted: control.highlightedIndex === index
                        hoverEnabled: control.hoverEnabled
                    }
                    model: ["постоянный", "непостоянный", "линия отключена"]
                    currentIndex: currentLine ? currentLine.mode : 0
                    onCurrentIndexChanged: if (currentLine) currentLine.mode = currentIndex
                }
            }

            // Text { text: "Status:" ;font.pixelSize: 30}
            // ComboBox {
            //     model: ["OK", "Failure", "Test"];font.pixelSize: 30
            //     currentIndex: currentLine ? currentLine.status : 0
            //     onCurrentIndexChanged: if (currentLine) currentLine.status = currentIndex
            // }

            // Text { text: "State:";font.pixelSize: 30 }
            // ComboBox {
            //     model: ["Off", "On"];font.pixelSize: 30
            //     currentIndex: currentLine ? currentLine.lineState : 0
            //     onCurrentIndexChanged: if (currentLine) currentLine.lineState = currentIndex
            // }
        }

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
                onClicked: {
                    if (tested) testController.stopTest(indexCh)
                    linesModel.saveToFile("lines.json");
                    stackViewList.pop()
                    stackViewList.push("qrc:/pageAjaste.qml")
                }
            }
        }
    }
    OperatorKeyboard {
            id: keyboard
            parent: lineEditPage   // чтобы Popup растягивался на всю страницу
    }
}
