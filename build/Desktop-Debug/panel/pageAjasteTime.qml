import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0  // <- новый модуль


//rect parent.width x 650
Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    TimeAjst { id: timeAjst }   // <- новый объект
    Rectangle {
        anchors.fill: parent
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height : 500
        anchors.margins: 12
        color: "transparent"
        Column {
            anchors.centerIn: parent
            spacing: 20

            // Дата
            Row {
                spacing: 30

                SpinBox {
                    id: day
                    from: 1
                    to: 31
                    value: new Date().getDate()
                    width: 150; height: 100
                    font.pixelSize: 50
                }

                SpinBox {
                    id: month
                    from: 1
                    to: 12
                    value: new Date().getMonth() + 1
                    width: 150; height: 100
                    font.pixelSize: 50
                }

                SpinBox {
                    id: year
                    from: 2025
                    to: 2100
                    value: new Date().getFullYear()
                    width: 200; height: 100
                    font.pixelSize: 50
                }

            // Время
                SpinBox {
                    id: hour
                    from: 0
                    to: 23
                    value: new Date().getHours()
                    width: 150; height: 100
                    font.pixelSize: 50
                }

                SpinBox {
                    id: minute
                    from: 0
                    to: 59
                    value: new Date().getMinutes()
                    width: 150; height: 100
                    font.pixelSize: 50
                }
            }

            // Кнопка
            Button {
                text: "Установить системное время"
                width: 400; height: 70
                font.pixelSize: 22
                onClicked: {
                    let d = new Date(year.value, month.value - 1, day.value, hour.value, minute.value)
                    timeAjst.setSystemTime(d.getTime())
                }
            }
        }

    }
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

                // Text {
                //     color: "black"
                //     anchors.centerIn: parent
                //     text: "ВЕРНУТЬСЯ"
                //     font.pixelSize: 30
                // }
                Image {
                    anchors.fill: parent
                    source: "qrc:/Back.png"
                    //scale: 1
                    // width: 1; height: 1
                     fillMode: Image.PreserveAspectFit
                   // fillMode: Image.Stretch
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: btnRet.color = "lightgray"
                    onExited: btnRet.color = "lightgray"
                    onPressed: btnRet.color = "gray"
                    onReleased: btnRet.color = "lightgray"
                    onClicked: stackViewList.pop("pageAjaste.qml")
                }
            }
        }
    }
}





