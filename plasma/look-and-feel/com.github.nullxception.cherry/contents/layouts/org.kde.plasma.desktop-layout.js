var panel = new Panel()
// Panel setup
panel.height = Math.ceil(gridUnit * 2.5 / 2) * 1.4
panel.location = "top"

// App Launcher
var kickoff = panel.addWidget("org.kde.plasma.kickoff")
kickoff.currentConfigGroup = ["Shortcuts"]
kickoff.writeConfig("global", "Alt+F1")

// App Title
if (knownWidgetTypes.indexOf('org.kde.windowtitle') > -1) {
    var wTitle = panel.addWidget("org.kde.windowtitle")
    wTitle.writeConfig("boldFont", true)
    wTitle.writeConfig("filterByScreen", true)
    wTitle.writeConfig("placeHolder", "Cherry Desktop")
    wTitle.writeConfig("showIcon", false)
}

// App Menu
if (knownWidgetTypes.indexOf('org.kde.windowappmenu') > -1) {
    panel.addWidget("org.kde.windowappmenu")
} else {
    panel.addWidget("org.kde.plasma.appmenu")
}

// Spacer to push tray and the rest to the right side
panel.addWidget("org.kde.plasma.panelspacer")

// Tray
panel.addWidget("org.kde.plasma.systemtray")

// Clock
if (knownWidgetTypes.indexOf('org.kde.plasma.betterinlineclock') > -1) {
    var clock = panel.addWidget("org.kde.plasma.betterinlineclock")
    clock.writeConfig("fixedFont", true)
    clock.writeConfig("fontSize", Math.round(panel.height * 0.45))
    clock.writeConfig("showDate", false)
    clock.writeConfig("showSeparator", false)
} else {
    var clock = panel.addWidget("org.kde.plasma.digitalclock")
    clock.writeConfig("showDate", false)
}

// User Switch
var uswitch = panel.addWidget("org.kde.plasma.userswitcher")
uswitch.writeConfig("showFace", true)
uswitch.writeConfig("showFullName", false)
uswitch.writeConfig("showName", false)
uswitch.writeConfig("showTechnicalInfo", true)

// Create sensible "dock" using plasma panel if latte-dock is not exists
if (!applicationExists("latte-dock")) {
    var dock = new Panel()
    dock.alignment = "center"
    dock.height = 50
    dock.hiding = "windowscover"
    dock.location = "bottom"
    dock.minimumLength = gridUnit

    var tasks = dock.addWidget("org.kde.plasma.icontasks")
    tasks.writeConfig("maxStripes", 1)
}
