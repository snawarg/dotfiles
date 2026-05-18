import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../theme"

CutCornerShape {
	implicitHeight: parent.height
	implicitWidth: clockLayout.implicitWidth + Theme.spacingMd * 2
	fillColor: Theme.surface
	useGradient: true

	RowLayout {
		id: clockLayout
		anchors.centerIn: parent
		spacing: Theme.spacingSm

		Text {
			id: timeText
			text: Qt.formatTime(clock.date, "hh:mm")
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeBase
		}

		Text {
			id: dateText
			text: Qt.formatDate(clock.date, "dd/MM/yyyy")
			color: Theme.textMuted
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}
	}

	SystemClock {
		id: clock
		precision: SystemClock.Seconds
	}
}
