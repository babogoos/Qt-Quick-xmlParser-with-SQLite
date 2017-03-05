import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0

Window {
    id: window
    visible: true
    width: 800
    height: 480
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation
    XmlListModel {
        id: feedModel
        source: "http://www.cwb.gov.tw/rss/forecast/36_08.xml"
        query: "/rss/channel/item"
        XmlRole { name: "description"; query: "description/string()" }
        onStatusChanged: list.model = getSubDescription(feedModel)
     }
    function getSubDescription(x) {
        var des = x.get(1).description;
        var subDes = des.split("<BR>");
        return subDes;
    }
    ListView {
        id: list
        anchors.fill: parent
        clip: isPortrait
        model: feedModel
        delegate:
            Text {
            text:  modelData
        }
    }


    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log(getSubDescription(feedModel)); //可是這邊又不會噴，乖乖印String array給我
        }
    }

    Component {
        id: footerText

        Rectangle {
            width: parent.width
            height: parent.height
            color: "lightgray"

            Text {
                text: "RSS Feed from Yahoo News"
                anchors.centerIn: parent
                font.pixelSize: 14
            }
        }

    }

    //    XmlListModel {
    //        id: feedModel

    //        source: "http://news.yahoo.com/rss/topstories"
    //        query: "/rss/channel/item[child::media:content]"
    //        namespaceDeclarations: "declare namespace media = 'http://search.yahoo.com/mrss/';"

    //        XmlRole { name: "title"; query: "title/string()" }
    //        // Remove any links from the description
    //        XmlRole { name: "description"; query: " fn:replace( description/string(),'\&lt;a href=.*\/a\&gt;','')" }
    ////        XmlRole { name: "description"; query: "description/string()" }
    //        XmlRole { name: "image"; query: "media:content/@url/string()" }
    //        XmlRole { name: "link"; query: "link/string()" }
    //        XmlRole { name: "pubDate"; query: "pubDate/string()" }
    //    }

//    Item {
//                 width: list.width
//                  height: textItem.implicitHeight

//                       Text {
//                           id: textItem
//                           z: 2
//                           text: modelData
//                           width: parent.width
//                       }

//                       Rectangle {
//                           z: 1
//                           color: "red"
//                           anchors.fill: parent
//                       }
//                   }
}

