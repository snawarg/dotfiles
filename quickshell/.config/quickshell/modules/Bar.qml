import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../theme"

PanelWindow {
	id: bar

	anchors {
		top: true
		left: true
		right: true
	}

	implicitHeight: Theme.barHeight
	color: "transparent"

	Rectangle {
		anchors.fill: parent
		color: "transparent"

		RowLayout {
			anchors.fill: parent
			anchors.margins: Theme.spacingSm
			spacing: Theme.spacingSm

			Workspaces {}
			ActiveWindow {
				Layout.fillWidth: true
			}
			SystemInfo {}
			Clock {}
		}
	}
}
