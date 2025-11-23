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
            //anchors.centerIn: parent
            spacing: 20

            //Длительность аварийного режима
            Row {
                spacing: 30
                Text {
                     text: "Длительность аварийного режима"
                     //width: 400; height: 70
                     font.pixelSize: 40
                }

                SpinBox {
                    id: duration_Av
                    from: 1
                    to: 3
                    value: 1
                    width: 100; height: 60
                    font.pixelSize: 40
                    onValueChanged: durationAv = duration_Av.value
                }
                Text { text: "ч";font.pixelSize: 50 }
            }
            //Количество линий
            Row {
                spacing: 30
                Text {
                     text: "Количество линий"
                     //width: 400; height: 70
                     font.pixelSize: 40
                }

                SpinBox {
                    id: count_Ln
                    from: 1
                    to: 25
                    value: countLn
                    width: 100; height: 60
                    font.pixelSize: 40
                    onValueChanged: countLn = count_Ln.value
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





