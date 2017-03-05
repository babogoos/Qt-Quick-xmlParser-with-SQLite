import QtQuick 2.3
import QtQuick.Window 2.2
import QtQuick.XmlListModel 2.0
import QtQuick.LocalStorage 2.0
import "storage.js" as Storage
// This is available in all editors.
Window {
    id: window
    visible: true
    width: 800
    height: 480
    property bool isPortrait: Screen.primaryOrientation === Qt.PortraitOrientation

    Component.onCompleted: {
            Storage.initialize();
    }

    XmlListModel {
        id: feedModel
        source: "http://www.cwb.gov.tw/rss/forecast/36_08.xml"
        query: "/rss/channel/item"
        XmlRole { name: "description"; query: "description/string()" }
        onStatusChanged:{
            var texting = getSubDescription(feedModel);
            list.model =Storage.getall();
            textView.text = "";
        }
     }
    function getSubDescription(x) {
        var des = x.get(1).description;
        var subDes = des.split("<BR>");
        for(var i = 0; i < subDes.length; i++)
            Storage.set(i,subDes[i]);
        return subDes;
    }
    function getFromDB(index){
        return Storage.get(index);
    }

    ListView {
        id: list
        anchors.fill: parent
        clip: isPortrait
        delegate:
            Text {
            text:  modelData
        }
    }
    Text {
        id:textView
        text: "Loading..."
        anchors.centerIn: parent
        font.pixelSize: 14
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

}

