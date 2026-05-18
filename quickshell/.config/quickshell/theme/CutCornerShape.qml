import QtQuick
import QtQuick.Shapes

Item {
	id: root

	property color fillColor:     "transparent"
	property color borderColor:   Theme.accent
	property color gradientStart: Theme.accent
	property color gradientEnd:   Theme.accentAlt
	property bool  useGradient:   false
	property int   cut:           6
	property int   borderWidth:   1
	readonly property int b: root.borderWidth
	readonly property int c: root.cut

	Shape {
		width: root.width
		height: root.height

		// --- Border layer ------------------------------
		ShapePath {
			strokeWidth: 0

			fillGradient: LinearGradient {
				x1: 0;			y1: 0
				x2: root.width;	y2: root.height
				GradientStop { position: 0.0; color: useGradient ? root.gradientStart : root.borderColor }
				GradientStop { position: 1.0; color: useGradient ? root.gradientEnd : root.borderColor }
			}

			startX: root.cut; startY: 0
			PathLine { x: root.width;			y: 0 }
			PathLine { x: root.width;			y: root.height - root.cut }
			PathLine { x: root.width - root.cut;y: root.height }
			PathLine { x: 0;					y: root.height }
			PathLine { x: 0;					y: root.cut }
			PathLine { x: root.cut;				y: 0 }
		}

		// --- Fill layer (inset by borderWidth) ---------
		ShapePath {
			strokeWidth: 0
			fillColor:   root.fillColor

			startX: c + b;		startY: b
			PathLine { x: root.width - b;		y: b }
			PathLine { x: root.width - b;		y: root.height - c - b }
			PathLine { x: root.width - c - b;	y: root.height - b }
			PathLine { x: b;					y: root.height - b }
			PathLine { x: b;					y: c + b }
			PathLine { x: c + b;				y: b }
		}
	}
}
