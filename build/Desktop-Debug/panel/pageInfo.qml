import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import App 1.0

//rect parent.width x 650
Rectangle {
        id: pageInfo
        objectName: "pageInfo"
    width: stackViewList.width
    height: stackViewList.height
    Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height : 500
        anchors.margins: 12
        color: "transparent"
        Text {
            color: "black"
            anchors.centerIn: parent
            text:"
Группа компаний «Световые Технологии» — ведущий российский производитель
современного светотехнического оборудования, работающий на рынке с 1998 года.
За время существования компания стала признанным экспертом в области разработки и производства
энергоэффективных световых решений.
Миссия компании заключается в создании качественного и эффективного освещения для
различных сфер применения. Мы постоянно совершенствуем технологии и расширяем производственные
возможности, чтобы предлагать клиентам инновационные решения в области светотехники.
Контактная информация: 127273, г. Москва, улица Отрадная, дом 2Б, строение 7
Связаться с нами можно по бесплатному телефону 8(800)333-23-77 или по московскому номеру +7(495)995-55-95.
Гарантийные обязательства: мы предоставляем гарантию на всю продукцию сроком 3 года.
В течение этого периода действует сервисное обслуживание по всей России,
доступна техническая поддержка.
"
            font.pixelSize: 19
        }
    }
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 150
        anchors.margins: 12
        color: "transparent"
        RowLayout {
            anchors.fill: parent
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
                    onClicked: stackViewList.pop("pageStart.qml")
                }
            }
            Item { Layout.fillWidth: true }
            Text {text:"@design Peter Dmitriev dmpetr@ya.ru";
                font.pixelSize: 20;Layout.alignment: Qt.AlignRight | Qt.AlignBottom}
        }
    }
}




