import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

Window {
    id: win
    property int lineCount: 20 // задаем начальное значение
    // ******************************************************************
    property bool unlocked: true // кнопки разаблокированы
    property bool testStart : false
    property string correctPassword: ""
    property int  durationAv: 1 // Длительность работы аварийного режима
    property int  countLn: 25 // количество аварийных линий
    property double showPower : 0 // настроечная мощность
    property int indexCh: 0 // индекс изменяемой линии
    property int coutPush: 0 // для смены пароля
    property int coutPushCh: 10 // для смены пароля
    property int mintpower: 0
    property Line currentLine  // линия для редактирования
    property string testName: ""

    Component.onCompleted: correctPassword = pwManager.password

    visible: true
    width: 1024
    height: 768
    //******************************************************************
    //flags: Qt.FramelessWindowHint
    color: "#FFFFFF"
    maximumWidth: width
    maximumHeight: height
    minimumWidth: width
    minimumHeight: height
    x:0
    y:0

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
            //spacing: 20

            Image {
                source: "qrc:/logo.png"
                scale: 1
                // width: 1; height: 1
                // fillMode: Image.PreserveAspectFit
               // fillMode: Image.Stretch
                MouseArea {
                    anchors.fill: parent
                    onClicked:  {
                        if ( stackViewList.currentItem.objectName !== "pageInfo") {coutPush = 0;stackViewList.push("pageInfo.qml")}
                        else {coutPush++;if(coutPush > 15){coutPush = 0; stackViewList.push("pagePassCh.qml")}   }
                    }
                }
            }
            // Column {
            //     spacing: 2
            //     Text { text: "СВЕТОВЫЕ\nТЕХНОЛОГИИ"; font.pixelSize: 22; color: "#21323a"; font.bold: true }
            // }

            Item { Layout.fillWidth: true }
            Text {
                text: temperature ? temperature.value + " °C" : ""
                font.pixelSize: 40;
                Layout.margins: 55
            Layout.alignment: Qt.AlignVCenter | Qt.AlignTop
            }

            Column {
                spacing: 4
                Layout.alignment: Qt.AlignRight | Qt.AlignTop
                Layout.rightMargin: 20

                Text { id: dateText; text: Qt.formatDate(new Date(), "dd.MM.yyyy"); font.pixelSize: 40; color:"#000000" }
                Text { id: timeText; text: Qt.formatTime(new Date(), "hh:mm"); font.pixelSize: 40; color:"#000000" }
                //Text { id: timeText; text: Qt.formatTime(new Date(), "hh:mm:ss"); font.pixelSize: 40; color:"#000000" }
                Timer { interval: 1000; running: true; repeat: true; onTriggered: { timeText.text = Qt.formatTime(new Date(), /*"hh:mm:ss"*/"hh:mm"); dateText.text = Qt.formatDate(new Date(), "dd.MM.yyyy") } }
            }
            Item { width: 80 }
        }
    }

    // основной контейнер — горизонтальный
    StackView {
        id: stackViewList
        anchors.top: header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height : 650

        initialItem: "pageStart.qml"
    }
}
