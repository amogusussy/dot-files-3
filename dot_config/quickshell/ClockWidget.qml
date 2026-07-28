import Quickshell
import QtQuick.Controls
import QtQuick


Rectangle {
  default property alias data: workspaces.data
  anchors {
    verticalCenter: parent.verticalCenter
  }

  implicitWidth: workspaces.implicitWidth
  implicitHeight: 20
  border {
    color: "#565f89ff"
    width: 1
  }
  radius: 20
  color: "#161620" 

  Control {
    id: workspaces
    property real verticalInset: 20
    horizontalPadding: 10

    contentItem: Text {
      color: "#c0caf5"
      text: Time.time
      horizontalAlignment: Text.AlignHCenter
      verticalAlignment: Text.AlignVCenter
      font {
        pixelSize: 15
      }
    }
  }
}
