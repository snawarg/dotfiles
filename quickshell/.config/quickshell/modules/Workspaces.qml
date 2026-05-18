import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../theme"

CutCornerShape {
	id: root
	implicitHeight: parent.height
	implicitWidth: workspacesRow.implicitWidth + Theme.spacingMd * 2
	fillColor: Theme.surface
	useGradient: true

	RowLayout {
		id: workspacesRow
		anchors.centerIn: parent
		spacing: Theme.spacingXs

		Repeater {
			model: 5

			delegate: Rectangle {
				required property int index
				readonly property int wsId: index + 1
				readonly property bool active: Hyprland.focusedMonitor?.activeWorkspace?.id === wsId
				readonly property bool occupied: {
					for (const ws of Hyprland.workspaces.values) {
						if (ws.id === wsId) return true; 
					}
					return false;
				}

				implicitWidth: active ? 32 : 28
				implicitHeight: 22
				color: "transparent"

				Behavior on implicitWidth {
					NumberAnimation { duration: 150 }
				}

				Text {
					anchors.centerIn: parent
					text: wsId
					color: active ? Theme.accent : Theme.textMuted
					font.family: Theme.fontMono
					font.pixelSize: active ? Theme.fontSizeBase : Theme.fontSizeSmall
				}

				// Dot indicator for working workspaces
				Rectangle {
					visible: occupied || active
					width: 3
					height: 3
					radius: 1.5
					color: active ? Theme.accent : Theme.accentAlt
					anchors.bottom: parent.bottom
					anchors.bottomMargin: 2
					anchors.horizontalCenter: parent.horizontalCenter
				}

				MouseArea {
					anchors.fill: parent
					onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${wsId} })`)
				}
			}
		}
	}
}
