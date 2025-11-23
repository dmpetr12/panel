import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

//rect parent.width x 650
Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    Rectangle {
        width: parent.width
        height: 550

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            // Заголовок
            Text {
                text: "          ТЕСТ ЛИНИЙ"
                font.pixelSize: 40
                color: "black"
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                height: 40
            }

            // Контейнер колонок
            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 10

                // Левая колонка
                ColumnLayout {
                    Layout.preferredWidth: 300
                    spacing: 20
                    Layout.topMargin: 60

                    Rectangle {
                        width: 250
                        height: 90
                        radius: 12
                        color: "orange"
                        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

                        Text {
                            anchors.centerIn: parent
                            text: "Тест всех
 линий"
                            font.pixelSize: 30
                            color: "white"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {indexCh=-1;stackViewList.push("pageTestEx.qml")}
                        }
                    }
                    Rectangle {
                        width: 250
                        height: 90
                        radius: 12
                        color: "orange"
                        Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

                        Text {
                            anchors.centerIn: parent
                            text: "Тест на время"
                            font.pixelSize: 30
                            color: "white"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {indexCh=-2;stackViewList.push("pageTestEx.qml")}
                        }
                    }
                    Item { Layout.fillHeight: true }
                }

                // Правая колонка
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 10


                    Text {
                        text: "тест линии"
                        font.pixelSize: 30
                        //font.bold: true
                        color: "white"
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                    }

                    ListView {
                        id: listView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: linesModel
                        spacing: 0

                        delegate: Item {
                            width: ListView.view.width
                            visible: mode !== 2 && index < countLn
                            height: visible ? 80 : 0

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 10


                                Rectangle {
                                    width: 500; height: 70
                                    radius: 3; color: "#E7E7E7"

                                    Text {
                                        text: (index+1)+": "+description
                                        font.pixelSize: 30
                                        anchors.fill: parent
                                        //font.bold: true
                                        color: "black"
                                        //Layout.fillWidth: true
                                        verticalAlignment: Text.AlignVCenter
                                        //horizontalAlignment: Text.AlignRight
                                        elide: Text.ElideRight
                                    }

                                }
                                Rectangle {
                                    id: idT
                                    width: 180; height: 70
                                    radius: 3; color: "#E7E7E7"

                                    Text {
                                        text:  "  тест"
                                        anchors.fill: parent
                                        verticalAlignment: Text.AlignVCenter
                                        font.pixelSize: 30
                                        color: "black"
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        onPressed: idT.color = "black"
                                        onReleased: idT.color = "#E7E7E7"
                                        onClicked: {
                                            indexCh= index
                                            stackViewList.push("pageTestEx.qml")
                                        }
                                    }
                                }
                                Item { Layout.fillWidth: true }


                            }

                            //Rectangle { anchors.left: parent.left; anchors.right: parent.right; anchors.bottom: parent.bottom; height: 1; color: "#DDDDDD" }
                        }
                    }
                }
            }
        }
    }

    // Вернуться
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
                    onClicked:{
                        stackViewList.pop()
                        stackViewList.push("qrc:/pageStart.qml")
                    }
                }
            }
        }
    }
}




