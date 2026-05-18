import Quickshell
import Quickshell.Hyprland
import QtQuick
import QtQuick.Layouts
import "../theme"

CutCornerShape {
	implicitHeight: parent.height
	implicitWidth: parent.width
	fillColor: Theme.surface
	useGradient: true

	readonly property string title: {
		const title = Hyprland.activeToplevel?.title;
		return title ?? "Desktop";
	}

	Text {
		id: windowTitle
		anchors.centerIn: parent
		text: title
		color: Theme.text
		font.family: Theme.fontSans
		font.pixelSize: Theme.fontSizeBase
		elide: Text.ElideRight
		maximumLineCount: 1
	}
}
