pragma Singleton

import QtQuick
import Quickshell

Singleton {
	id: root

	function getAppIcon(name: string): string {
		const icon = DesktopEntries.heuristicLookup(name)?.icon;
		return Quickshell.iconPath(icon, true);
	}
}
