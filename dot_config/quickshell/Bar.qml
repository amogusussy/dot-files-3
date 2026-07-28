import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Hyprland

Scope {
  Variants {
    model: Quickshell.screens
    PanelWindow {
      required property var modelData
      screen: modelData
      color: "#1a1b2600"
      
      implicitHeight: 20
      anchors {
        top: true
        left: true
        right: true
      }

      Rectangle {
        width: 1920
        height: 25
        color: "#00000000"

        Workspaces {
          anchors.left: parent
        }

        ClockWidget {
          anchors.centerIn: parent
        }
      }

      // SystrayType {}
    }
  }
}
