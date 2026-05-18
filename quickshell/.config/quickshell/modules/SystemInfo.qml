import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../theme"

CutCornerShape {
	id: root

	property bool expanded: hoverHandler.hovered

	implicitHeight: parent.height
	implicitWidth: expanded ? expandedContent.implicitWidth + Theme.spacingMd * 2
							: compactContent.implicitWidth + Theme.spacingMd * 2

	fillColor: Theme.surface
	useGradient: true

	onExpandedChanged: {
		if (expanded) {
			batteryProc.running	= true
			cpuProc.running		= true
			ramProc.running		= true
			tempProc.running	= true
			uptimeProc.running	= true
		}
	}

	Behavior on implicitWidth {
		NumberAnimation { duration: 200 }
	}

	HoverHandler {
		id: hoverHandler
	}

	// --- Compact --------------------------------
	RowLayout {
		id: compactContent
		anchors.centerIn: parent
		spacing: Theme.spacingSm
		visible: !expanded
		opacity: expanded ? 0 : 1
		Behavior on opacity { NumberAnimation { duration: 150 } }

		Text {
			text: "\uf240"
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeBase
		}

		Text {
			text: "\uf4bc"
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeBase
		}

		Text {
			text: "\uefc5"
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeBase
		}

		Text {
			text: "\uf2c9"
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeBase
		}
	}

	// --- Expanded -------------------------------
	RowLayout {
		id: expandedContent
		anchors.centerIn: parent
		spacing: Theme.spacingMd
		visible: expanded
		opacity: expanded ? 1 : 0
		Behavior on opacity { NumberAnimation { duration: 150 } }

		Text {
			text: "\uf240 " + batteryPercent + "% " + batteryStatus
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}

		Text {
			text: "\uf4bc " + cpuPercent + "%"
			color: Theme.accentAlt
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}

		Text {
			text: "\uefc5 " + ramUsed
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}

		Text {
			text: "\uf2c9 " + temp + "ºC"
			color: Theme.accentAlt
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}

		Text {
			text: "\uf43a " + uptime
			color: Theme.accent
			font.family: Theme.fontMono
			font.pixelSize: Theme.fontSizeSmall
		}
	}

	// --- Data -----------------------------------
	property string batteryPercent: "0"
	property string batteryStatus:  ""
	property string cpuPercent: "0"
	property string ramUsed:	"0G"
	property string ramTotal:	"0G"
	property string temp:		"0"
	property string uptime:		"0h"

	Process {
		id:batteryProc
		command: ["bash", "-c", "cat /sys/class/power_supply/BAT0/capacity 2>/dev/null && cat /sys/class/power_supply/BAT0/status 2>/dev/null | tr '\\n' '|'"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				const parts = data.trim().split("|");
				root.batteryPercent = parts[0] ?? "N/A";
				root.batteryStatus = parts[1] ?? "";
			}
		}
	}

	Process {
		id: cpuProc
		command: ["bash", "-c", "top -bn1 | grep 'Cpu' | awk '{print int($2)}'"]
		running: true
		stdout: SplitParser {
			onRead: data => root.cpuPercent = data.trim()
		}
	}

	Process {
		id: ramProc
		command: ["bash", "-c", "free -h | awk '/Mem:/{print $3\"|\"$2}'"]
		running: true
		stdout: SplitParser {
			onRead: data => {
				const parts = data.trim().split("|");
				root.ramUsed = parts[0] ?? "0G";
				root.ramTotal = parts[1] ?? "0G";
			}
		}
	}

	Process {
		id: tempProc
		command: ["bash", "-c", "cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null | awk '{print  int($1/1000)}'"]
		running: true
		stdout: SplitParser {
			onRead: data => root.temp = data.trim()
		}
	}

	Process {
		id: uptimeProc
		command: ["bash", "-c", "uptime -p | sed 's/up //'"]
		running: true
		stdout: SplitParser {
			onRead: data => root.uptime = data.trim()
		}
	}

	Timer {
		interval: 5000
		running: expanded
		repeat: true
		onTriggered: {
			batteryProc.running	= true
			cpuProc.running		= true
			ramProc.running		= true
			tempProc.running	= true
			uptimeProc.running	= true
		}
	}
}
