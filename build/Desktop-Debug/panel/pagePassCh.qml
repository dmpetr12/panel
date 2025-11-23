import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    width: stackViewList.width
    height: stackViewList.height
    color: "white"
    objectName: "pageInfo"


    property string newPasswordBuffer: ""     // буфер нового пароля
    property string confirmPasswordBuffer: "" // буфер подтверждения
    property string stage: "new"              // "old", "new", "confirm"

    Column {
        anchors.centerIn: parent
        spacing: 20

        // Заголовок
        Text {
            text: stage === "new" ? "Введите новый пароль" :
                                     "Подтвердите новый пароль"
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            width: 250
        }

        // Поле отображения пароля
        Text {
            text: (stage === "new" ? newPasswordBuffer :
                                     confirmPasswordBuffer).length > 0 ?
                  "*".repeat((stage === "new" ? newPasswordBuffer :
                                               confirmPasswordBuffer).length) : ""
            font.pixelSize: 28
            horizontalAlignment: Text.AlignHCenter
            width: 200
        }

        // Цифровая клавиатура
        GridLayout {
            columns: 3
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: 9
                delegate: Button {
                    text: index + 1
                    Layout.preferredWidth: 80
                    Layout.preferredHeight: 80
                    onClicked: {
                        if (stage === "new") newPasswordBuffer += text
                        else confirmPasswordBuffer += text
                    }
                }
            }

            Button { text: "Clear"; Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onClicked: {
                    if (stage === "new") newPasswordBuffer = ""
                    else confirmPasswordBuffer = ""
                }
            }
            Button { text: "0"; Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onClicked: {
                    if  (stage === "new") newPasswordBuffer += "0"
                    else confirmPasswordBuffer += "0"
                }
            }
            Button { text: "⌫"; Layout.preferredWidth: 80; Layout.preferredHeight: 80
                onClicked: {
                    if (stage === "new" && newPasswordBuffer.length > 0)
                        newPasswordBuffer = newPasswordBuffer.slice(0, -1)
                    else if (stage === "confirm" && confirmPasswordBuffer.length > 0)
                        confirmPasswordBuffer = confirmPasswordBuffer.slice(0, -1)
                }
            }
        }

        // Кнопки управления
        Row {
            spacing: 20
            Button { text: "Cancel"; width: 120
                onClicked: stackViewList.pop()
            }
            Button { text: "OK"; width: 120
                onClicked: {
                    if (stage === "new") {
                        if (newPasswordBuffer.length < 4)
                            console.log("❌ New password too short")
                        else stage = "confirm"
                    } else if (stage === "confirm") {
                        if (confirmPasswordBuffer === newPasswordBuffer) {
                            correctPassword = newPasswordBuffer
                            pwManager.password = correctPassword
                            console.log("✅ Password changed:", correctPassword)
                            stackViewList.pop()
                        } else console.log("❌ Passwords do not match")
                    }
                }
            }
        }
    }
}
