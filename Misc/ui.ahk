#Requires AutoHotkey v2.0

MyGui := Gui("+AlwaysOnTop -Caption")
MyGui.BackColor := "0x171012"
MyGui.Show("w1100 h750")
MyGui.Title := "SzymsX AS Macro"

OnMessage(0x0201, (*) => PostMessage(0xA1, 2)) ; allows moving gui
WinSetRegion("0-0 w1100 h750 R20-20", MyGui.Hwnd)

BackgroundColor := "0x171012"

MyGui.Add("Progress", "x5 y130 w805 h600 -Theme c0x413319 Background0x0d1115", 100) ; | makes hole for roblox window to fit with transparent color
WinSetTransColor "0x413319 255", "SzymsX AS Macro" ;                                    |

FontColor := "c734B5E"

MyGui.SetFont("s9 w600 c" . FontColor, "Segoe UI") ; overall font settings

; macro title
macrotitle := MyGui.Add("Text", "x10 y8 w400 h25", "SzymsX Anime Squadron Macro v1.0.0")
macrotitle.SetFont("s13")

MyGui.SetFont("s13")

; controls
F1START  := MyGui.Add("Text", "x75  y80 Background281B20",  "F1 START")
F2STOP   := MyGui.Add("Text", "x245 y80 Background281B20", "F2 STOP")
F3RELOAD := MyGui.Add("Text", "x425 y80 Background281B20", "F3 RELOAD")
F4CLOSE  := MyGui.Add("Text", "x625 y80 Background281B20", "F4 CLOSE")


; StatusText
StatusText := MyGui.Add("Text", "x842 y424 w221", "")
StatusText.SetFont("s9")

MyGui.SetFont("s9")

; modes + stages + acts buttons
ModesDDL          := MyGui.Add("DDL", "x884 y201", ["", "Story", "Squadron", "Raid", "Challange"])

; gui pic panels part1
modespanel := MyGui.Add("Pic", "x842 y177 w221 h206", "Images\sakuraguipanelstage.png")    ; modes, stages, acts panel

StoryStageDDL     := MyGui.Add("DDL", "x884 y241 Hidden", ["", "GT City", "Marine Lobby", "Ninja Village", "Eclipse (Before)"])
StoryActDDL       := MyGui.Add("DDL", "x884 y281 Hidden", ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])

SquadronStageDDL  := MyGui.Add("DDL", "x884 y241 Hidden", ["", "GT City", "Marine Lobby", "Ninja Village", "Eclipse (Before)"])
SquadronActDDL    := MyGui.Add("DDL", "x884 y281 Hidden", ["", "1", "2", "3"])
SquadronActDDL1   := MyGui.Add("DDL", "x884 y281 Hidden", ["", "1", "2", "3", "4"])

RaidStageDDL      := MyGui.Add("DDL", "x884 y241 Hidden", ["", "GT City", "Eclipse (Before)"])
RaidActDDL        := MyGui.Add("DDL", "x884 y281 Hidden", ["", "1", "2", "3", "4"])
RaidDiffDDL       := MyGui.Add("DDL", "x884 y321 Hidden", ["", "Normal", "Hard"])

ChallangeStageDDL := MyGui.Add("DDL", "x884 y241 Hidden", ["", "Daily", "Katakara Bridge", "TheHeroHunter"])
ChallangeDiffDDL  := MyGui.Add("DDL", "x884 y281 Hidden", ["", "Normal", "Hard"])

EventsStageDDL    := MyGui.Add("DDL", "x884 y241 Hidden", ["", "Boros"]) 

ModesDDL.OnEvent("Change", ShowModes)
SquadronStageDDL.OnEvent("Change", ShowModes)
ChallangeStageDDL.OnEvent("Change", ShowModes)

; ShowModes
ShowModes(*) {
    if (ModesDDL.Text = "Story") {
        StoryStageDDL.Visible     := true
        StoryActDDL.Visible       := true
        SquadronStageDDL.Visible  := false
        SquadronActDDL.Visible    := false
        RaidStageDDL.Visible      := false
        RaidActDDL.Visible        := false
        RaidDiffDDL.Visible       := false
        ChallangeStageDDL.Visible := false
        ChallangeDiffDDL.Visible  := false
        EventsStageDDL.Visible    := false
    } else if (ModesDDL.Text = "Squadron") {
        StoryStageDDL.Visible     := false
        StoryActDDL.Visible       := false
        SquadronStageDDL.Visible  := true
        SquadronActDDL.Visible    := true
        RaidStageDDL.Visible      := false
        if (SquadronStageDDL.Text = "Ninja Village" || SquadronStageDDL.Text = "Eclipse (Before)") {
            SquadronActDDL.Visible  := false
            SquadronActDDL1.Visible := true
        }
        RaidActDDL.Visible        := false
        RaidDiffDDL.Visible       := false
        ChallangeStageDDL.Visible := false
        ChallangeDiffDDL.Visible  := false
        EventsStageDDL.Visible    := false
    } else if (ModesDDL.Text = "Raid") {
        StoryStageDDL.Visible     := false
        StoryActDDL.Visible       := false
        SquadronStageDDL.Visible  := false
        SquadronActDDL.Visible    := false
        RaidStageDDL.Visible      := true
        RaidActDDL.Visible        := true
        RaidDiffDDL.Visible       := true
        ChallangeStageDDL.Visible := false
        ChallangeDiffDDL.Visible  := false
        EventsStageDDL.Visible    := false
    } else if (ModesDDL.Text = "Challange") {
        StoryStageDDL.Visible     := false
        StoryActDDL.Visible       := false
        SquadronStageDDL.Visible  := false
        SquadronActDDL.Visible    := false
        RaidStageDDL.Visible      := false
        RaidActDDL.Visible        := false
        RaidDiffDDL.Visible       := false
        ChallangeStageDDL.Visible := true
        ChallangeDiffDDL.Visible  := false
        if (ChallangeStageDDL.Text = "Katakara Bridge" || ChallangeStageDDL.Text = "TheHeroHunter") {
            ChallangeDiffDDL.Visible := true
        }
        EventsStageDDL.Visible    := false
    } else if (ModesDDL.Text = "Events") {
        StoryStageDDL.Visible     := false
        StoryActDDL.Visible       := false
        SquadronStageDDL.Visible  := false
        SquadronActDDL.Visible    := false
        RaidStageDDL.Visible      := false
        RaidActDDL.Visible        := false
        RaidDiffDDL.Visible       := false
        ChallangeStageDDL.Visible := false
        ChallangeDiffDDL.Visible  := false
        EventsStageDDL.Visible    := true
     } else {
        StoryStageDDL.Visible     := false
        StoryActDDL.Visible       := false
        SquadronStageDDL.Visible  := false
        SquadronActDDL.Visible    := false
        RaidStageDDL.Visible      := false
        RaidActDDL.Visible        := false
        RaidDiffDDL.Visible       := false
        ChallangeStageDDL.Visible := false
        ChallangeDiffDDL.Visible  := false
        EventsStageDDL.Visible    := false
    }
}

; themes + options buttons
optionsbutton := MyGui.Add("Button", "x894 y667 w115", "Options")
optionsbutton.OnEvent("Click", ShowOptionsGui)

; gui pic panels part2
sakuraoptions := MyGui.Add("Pic", "x842 y627 w221 h106", "Images\sakuraguipaneloptions.png")  ; options, themes

panelcontrolsF1 := MyGui.Add("Pic", "x61  y73  w105 h40",  "Images\sakuraguipanelcontrols.png") ; F1 panel
panelcontrolsF2 := MyGui.Add("Pic", "x228 y73  w105 h40",  "Images\sakuraguipanelcontrols.png") ; F2 panel
panelcontrolsF3 := MyGui.Add("Pic", "x407 y73  w130 h40",  "Images\sakuraguipanelcontrols.png") ; F3 panel
panelcontrolsF4 := MyGui.Add("Pic", "x610 y73  w110 h40",  "Images\sakuraguipanelcontrols.png") ; F4 panel


; options gui
ShowOptionsGui(*) {
    OptionsGui.Show("w501 h601")
}
BorderColor := "0x36232b"
global OptionsGui := Gui("AlwaysOnTop -Caption")
OptionsGui.BackColor := "0x171012"
OptionsGui.SetFont("s9 w600 c" . FontColor, "Segoe UI") ; overall font options settings
OptionsGui.Add("Text", "x0   y0   w6   h600 Background" . BorderColor) ; Left Options Gui Border
OptionsGui.Add("Text", "x0   y0   w501 h6   Background" . BorderColor) ; Top Options Gui Border
OptionsGui.Add("Text", "x495 y0   w6   h600 Background" . BorderColor) ; Right Options Gui Border
OptionsGui.Add("Text", "x0   y595 w501 h6   Background" . BorderColor) ; Bottom Options Gui Border



OptionsCloseButton := OptionsGui.Add("Text", "x461 y20 w20 h20", "x")
OptionsCloseButton.SetFont("s13")
OptionsCloseButton.OnEvent("Click", XOPTIONS)
XOPTIONS(*) {
    OptionsGui.Hide()
}

OptionsCloseButton := OptionsGui.Add("Text", "x441 y20 w20 h20", "-")
OptionsCloseButton.SetFont("s13")
OptionsCloseButton.OnEvent("Click", MINIMIZEOPTIONS)
MINIMIZEOPTIONS(*) {
    OptionsGui.Minimize()
}


AutoChallangeCheck := OptionsGui.Add("Checkbox", "x43 y94", "Auto Challange")

OptionsGuiSaveButton := OptionsGui.Add("Button", "x173 y550 w115", "Save")
OptionsGuiSaveButton.OnEvent("Click", SettingsSave)



; options settings functions
SettingsSave(*) {
    StatusText.Text := "> Settings Saved"
    if (AutoChallangeCheck.Value = "1") {
        IniWrite("yes", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challange")
    } else {
        IniWrite("no", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challange")
    }
}

LoadSettings() {
    StatusText.Text := "> Settings Loaded"
    if "yes" = IniRead(A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challange") {
        AutoChallangeCheck.Value := "1"
    } else if "no" = IniRead(A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challange") {
        AutoChallangeCheck.Value := "0"
    }
}