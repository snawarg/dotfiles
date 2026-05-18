pragma Singleton
import QtQuick

QtObject {
	// --- Base -----------------------------------------
	readonly property color base:    "#0e0e0e"
	readonly property color surface: "#1a1a1a"
	readonly property color overlay: "#2a2a2a"

	// --- Text -----------------------------------------
	readonly property color text:      "#e0e0e0"
	readonly property color textMuted: "#666666"

	// --- Accents --------------------------------------
	readonly property color accent:    "#00ff9f"
	readonly property color accentAlt: "#bf5fff"

	// --- Semantic -------------------------------------
	readonly property color borderActive:   accent
	readonly property color borderInactive: overlay

	// --- Typography -----------------------------------
	readonly property string fontSans: "Geist"
	readonly property string fontMono: "JetBrainsMono Nerd Font"
	readonly property int    fontSizeBase: 13
	readonly property int    fontSizeSmall: 11
	
	// --- Spacing --------------------------------------
	readonly property int spacingXs: 4
	readonly property int spacingSm: 8
	readonly property int spacingMd: 12
	readonly property int spacingLg: 16
	
	// --- Geometry--------------------------------------
	readonly property int radius: 8
	readonly property int barHeight: 40
}
