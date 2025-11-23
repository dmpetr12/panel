import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App.Logger 1.0

Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    color: "white"
    property string passwordBuffer: ""

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Поле отображения пароля
        Text {
            id: passwordDisplay
            text: "*".repeat(passwordBuffer.length)
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            width: 200
        }

        // Клавиатура (сетка 3x4)
        GridLayout {
            id: keypad
            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: 9
                delegate: Button {
                    text: index + 1
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 80
                    onClicked: passwordBuffer += text
                }
            }

            // Кнопки в последней строке
            Button {
                text: "Clear"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 80
                onClicked: passwordBuffer = ""
            }

            Button {
                text: "0"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 80
                onClicked: passwordBuffer += "0"
            }

            Button {
                text: "⌫"
                Layout.preferredWidth: 80
                Layout.preferredHeight: 80
                onClicked: if (passwordBuffer.length > 0)
                              passwordBuffer = passwordBuffer.slice(0, -1)
            }
        }

        // Кнопка OK
        Button {
            text: "OK"
            width: 260
            height: 60
            onClicked: {
                if (passwordBuffer === correctPassword) {
                    unlocked = true
                    Logger.write("Доступ разрешён")
                } else {
                    unlocked = false
                    Logger.write("введен неверный пароль")
                }
                stackViewList.push("pageStart.qml")
            }
        }


    }
}


