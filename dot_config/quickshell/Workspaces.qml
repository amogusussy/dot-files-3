import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick.Controls
import QtQuick
import QtQuick.Layouts


Rectangle {
  default property alias data: workspaces.data
  anchors.verticalCenter: parent.verticalCenter
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
    rightPadding: 40
    bottomInset: verticalInset / 2
    topInset: verticalInset / 2

    contentItem: RowLayout {
      anchors {
        fill: parent
        margins: 8
      }

      Repeater {
          model: 9

          Text {
              property var ws: Hyprland.workspaces.values.find(w => w.id === index + 1)
              property bool isActive: Hyprland.focusedWorkspace?.id === (index + 1)
              anchors.verticalCenter: parent.verticalCenter
              text: index + 1
              width: 40
              color: isActive ? "#9ece6a" : (ws ? "#7aa2f7" : "#444b6a")
              font {
                pixelSize: 14
              }

              MouseArea {
                  anchors.fill: parent
                  onClicked: Hyprland.dispatch("workspace " + (index + 1))
              }
          }
      }
    }
  }
}
