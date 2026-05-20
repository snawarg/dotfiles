import Quickshell
import Quickshell.Hyprland
import Quickshell.Widgets
import QtQuick
import QtQuick.Layouts
import "../theme"
import "utils"

CutCornerShape {
	implicitHeight: parent.height
	implicitWidth: parent.width
	fillColor: Theme.surface
	useGradient: true

	readonly property string title: {
		const title = Hyprland.activeToplevel?.title;
		Hyprland.refreshToplevels();
		return title ?? "Desktop";
	}

	RowLayout {
		anchors.centerIn: parent
		spacing: Theme.spacingXs

		IconImage {
			property string currentIcon: Icons.getAppIcon(Hyprland.activeToplevel?.lastIpcObject.class ?? "")
			id: icon
			asynchronous: true
			source: currentIcon
			implicitSize: currentIcon !== "" ? 18 : 0
		}

		Text {
			id: windowTitle
			text: title
			color: Theme.text
			font.family: Theme.fontSans
			font.pixelSize: Theme.fontSizeBase
			elide: Text.ElideRight
			maximumLineCount: 1
		}
	}
}
