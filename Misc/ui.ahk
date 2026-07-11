#Requires AutoHotkey v2.0
global MacroVersion := "v1.0.0"
MyGui := Gui("+AlwaysOnTop -Caption")
MyGui.Show("w1100 h750")
MyGui.Title := "SzymsX AS Macro"

; font colors
switch IniRead("Misc\Settings.ini", "Extra Options", "Theme") {
    case "Sakura": 
        MyGui.BackColor := "0x171012"
        FontColor := "734B5E"

    case "Crimson": 
        MyGui.BackColor := "0x331414"
        FontColor := "E63946"
    
    case "Dark": 
        MyGui.BackColor := "0x212529"
        FontColor := "ADB5BD"

    case "Matcha": 
        MyGui.BackColor := "0x2d6a4f"
        FontColor := "95D5B2"
}

;OnMessage(0x0201, (*) => PostMessage(0xA1, 2)) ; allows moving gui
WinSetRegion("0-0 w1100 h750 R20-20", MyGui.Hwnd)

MyGui.Add("Progress", "x5 y130 w805 h600 -Theme c0x413319 Background0x0d1115", 100) ; | makes hole for roblox window to fit with transparent color
WinSetTransColor "0x413319 255", "SzymsX AS Macro" ;                                    |

MyGui.SetFont("s9 w600 c" . FontColor, "Segoe UI") ; overall font settings

StageText      := MyGui.Add("Text", "x926 y145 w70 h31", "Stage")
OptionsText    := MyGui.Add("Text", "x918 y604 w70 h31", "Options")
WebhookText    := MyGui.Add("Text", "x913 y453 w70 h20", "Webhook")
StageText.SetFont("s11")
OptionsText.SetFont("s11")
WebhookText.SetFont("s11")

WebhookCheck := MyGui.Add("Checkbox", "x840 y456 vEnableWebhook", "Enable")
dcID         := MyGui.Add("Edit", "x876 y504 w150 vDiscordIDEdit")
WebhookEdit  := MyGui.Add("Edit", "x876 y538 w150 vMyEdit")
dcID.SetFont("s9 cblack")
WebhookEdit.SetFont("s9 cblack")

SendMessage(0x1501, 0, StrPtr("Discord ID"), dcID.Hwnd)
SendMessage(0x1501, 0, StrPtr("Webhook URL"), WebhookEdit.Hwnd)

; macro title
macrotitle := MyGui.Add("Text", "x10 y8 w400 h25", "SzymsX Anime Squadron Macro " MacroVersion)
macrotitle.SetFont("s13")
MyGui.Add("Pic", "x995 y22 w65 h65", "Images\icon.png")
RBXSnapText := MyGui.Add("Text", "x0 y0 w1100 h70")
RBXSnapText.OnEvent("Click",  (*) => AttachRBX())

; StatusText
StatusText := MyGui.Add("Text", "x842 y414 w221")
StatusText.SetFont("s9 c" . FontColor)

MyGui.SetFont("s9")

; modes + stages + acts buttons
ModesDDL          := MyGui.Add("DDL", "x884 y201 Choose1", ["", "Story", "Squadron", "Raid", "Invasion", "Challenge", "Events"])


switch IniRead("Misc\Settings.ini", "Extra Options", "Theme") {
    case "Sakura": 
        MyGui.Add("Pic", "x842 y177 w221 h206", "Images\sakuraguipanelstage.png")

    case "Crimson": 
        MyGui.Add("Pic", "x842 y177 w221 h206", "Images\crimsonguipanelstage.png")

    case "Dark": 
        MyGui.Add("Pic", "x842 y177 w221 h206", "Images\darkguipanelstage.png")
    
    case "Matcha":
        MyGui.Add("Pic", "x842 y177 w221 h206", "Images\matchaguipanelstage.png") 
}


StoryStageDDL     := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "GT City", "Marine Lobby", "Ninja Village", "Eclipse (Before)", "Ice Continent"])
StoryActDDL       := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"])

SquadronStageDDL  := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "GT City", "Marine Lobby", "Ninja Village", "Eclipse (Before)", "Ice Continent"])
SquadronActDDL    := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "1", "2", "3"])
SquadronActDDL1   := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "1", "2", "3", "4"])

RaidStageDDL      := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "GT City", "Eclipse (Before)"])
RaidActDDL        := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "1", "2", "3", "4"])
RaidDiffDDL       := MyGui.Add("DDL", "x884 y321 Hidden Choose1", ["", "Normal", "Hard"])

ChallengeStageDDL := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "Daily", "Katakara Bridge", "TheHeroHunter"])
ChallengeDiffDDL  := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "Normal", "Hard"])

InvasionStageDDL  := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "Lava Continent"])
InvasionActsDDL   := MyGui.Add("DDL", "x884 y281 Hidden Choose1", ["", "1", "2", "3", "4"])
InvasionDiffDDL   := MyGui.Add("DDL", "x884 y321 Hidden Choose1", ["", "Normal", "Hard"])

EventsStageDDL    := MyGui.Add("DDL", "x884 y241 Hidden Choose1", ["", "Boros"]) 

ModesDDL.OnEvent("Change", ShowModes)
ChallengeStageDDL.OnEvent("change", ShowModes)
SquadronStageDDL.OnEvent("change", ShowModes)

; ShowModes
ShowModes(*) {
    VisibleStory(false)
    VisibleSquadron(false)
    VisibleRaid(false)
    VisibleChallenge(false)
    VisibleEvents(false)
    VisibleInvasion(false)

    switch ModesDDL.Text {
        case "Story":
            VisibleStory(true)

        case "Squadron":
            VisibleSquadron(true)

        case "Raid":
            VisibleRaid(true)

        case "Challenge":
            VisibleChallenge(true)

        case "Events":
            VisibleEvents(true)

        case "Invasion":
            VisibleInvasion(true) 
    }
}

VisibleStory(trueorfalse) {
    StoryStageDDL.Visible := trueorfalse
    StoryActDDL.Visible   := trueorfalse
}

VisibleSquadron(trueorfalse) {
    SquadronStageDDL.Visible := trueorfalse

    if !trueorfalse {
        SquadronActDDL.Visible  := false
        SquadronActDDL1.Visible := false
        return
    }

    if SquadronStageDDL.Text = "" {
        SquadronActDDL1.Visible := false
        SquadronActDDL.Visible  := false
    
    } else if SquadronStageDDL.Text = "GT City" || SquadronStageDDL.Text = "Marine Lobby" {
        SquadronActDDL1.Visible := false
        SquadronActDDL.Visible  := true

    } else {
        SquadronActDDL.Visible  := false
        SquadronActDDL1.Visible := true
    }
}

VisibleRaid(trueorfalse) {
    RaidStageDDL.Visible := trueorfalse
    RaidActDDL.Visible   := trueorfalse
    RaidDiffDDL.Visible  := trueorfalse
}

VisibleInvasion(trueorfalse) {
    InvasionStageDDL.Visible := trueorfalse
    InvasionActsDDL.Visible  := trueorfalse
    InvasionDiffDDL.Visible  := trueorfalse
}

VisibleChallenge(trueorfalse) {
    ChallengeStageDDL.Visible := trueorfalse
    if (ChallengeStageDDL.Text = "Katakara Bridge" || ChallengeStageDDL.Text = "TheHeroHunter") {
        ChallengeDiffDDL.Visible := true
    }

}

VisibleEvents(trueorfalse) {
    EventsStageDDL.Visible := trueorfalse
}


; themes + options, save buttons
MainUiSaveButton := MyGui.Add("Button", "x894 y647 w115", "Save Webhook")
optionsbutton     := MyGui.Add("Button", "x894 y687 w115", "Options")

MainUiSaveButton.OnEvent("Click", WebhookSave)
optionsbutton.OnEvent("Click", ShowOptionsGui)

MyGui.SetFont("s13")
switch IniRead("Misc\Settings.ini", "Extra Options", "Theme") {
    case "Sakura": 
        MyGui.Add("Text", "x75  y80 Background281B20",  "F1 START")
        MyGui.Add("Text", "x245 y80 Background281B20", "F2 STOP")
        MyGui.Add("Text", "x425 y80 Background281B20", "F3 RELOAD")
        MyGui.Add("Text", "x625 y80 Background281B20", "F4 CLOSE")
        MyGui.Add("Pic", "x842 y627 w221 h106", "Images\sakuraguipaneloptions.png") ; options
        MyGui.Add("Pic", "x61  y73  w105 h40",  "Images\sakuraguipanelcontrols.png") ; F1
        MyGui.Add("Pic", "x228 y73  w105 h40",  "Images\sakuraguipanelcontrols.png") ; F2
        MyGui.Add("Pic", "x407 y73  w130 h40",  "Images\sakuraguipanelcontrols.png") ; F3
        MyGui.Add("Pic", "x610 y73  w110 h40",  "Images\sakuraguipanelcontrols.png") ; F4
        MyGui.Add("Pic", "x842 y480 w221 h106", "Images\sakuraguipaneloptions.png") ; Webhook panel
    
    case "Crimson": 
        MyGui.Add("Text", "x75  y80 Background471b1c",  "F1 START")
        MyGui.Add("Text", "x245 y80 Background471b1c", "F2 STOP")
        MyGui.Add("Text", "x425 y80 Background471b1c", "F3 RELOAD")
        MyGui.Add("Text", "x625 y80 Background471b1c", "F4 CLOSE")
        MyGui.Add("Pic", "x842 y627 w221 h106", "Images\crimsonguipaneloptions.png")
        MyGui.Add("Pic", "x61  y73  w105 h40",  "Images\crimsonguipanelcontrols.png")
        MyGui.Add("Pic", "x228 y73  w105 h40",  "Images\crimsonguipanelcontrols.png")
        MyGui.Add("Pic", "x407 y73  w130 h40",  "Images\crimsonguipanelcontrols.png")
        MyGui.Add("Pic", "x610 y73  w110 h40",  "Images\crimsonguipanelcontrols.png")
        MyGui.Add("Pic", "x842 y470 w221 h106", "Images\crimsonguipaneloptions.png")
    
    case "Dark": 
        MyGui.Add("Text", "x75  y80 Background343a40",  "F1 START")
        MyGui.Add("Text", "x245 y80 Background343a40", "F2 STOP")
        MyGui.Add("Text", "x425 y80 Background343a40", "F3 RELOAD")
        MyGui.Add("Text", "x625 y80 Background343a40", "F4 CLOSE")
        MyGui.Add("Pic", "x842 y627 w221 h106", "Images\darkguipaneloptions.png")
        MyGui.Add("Pic", "x61  y73  w105 h40",  "Images\darkguipanelcontrols.png")
        MyGui.Add("Pic", "x228 y73  w105 h40",  "Images\darkguipanelcontrols.png")
        MyGui.Add("Pic", "x407 y73  w130 h40",  "Images\darkguipanelcontrols.png")
        MyGui.Add("Pic", "x610 y73  w110 h40",  "Images\darkguipanelcontrols.png")
        MyGui.Add("Pic", "x842 y470 w221 h106", "Images\darkguipaneloptions.png")
    
    case "Matcha": 
        MyGui.Add("Text", "x75  y80 Background52b788",  "F1 START")
        MyGui.Add("Text", "x245 y80 Background52b788", "F2 STOP")
        MyGui.Add("Text", "x425 y80 Background52b788", "F3 RELOAD")
        MyGui.Add("Text", "x625 y80 Background52b788", "F4 CLOSE")
        MyGui.Add("Pic", "x842 y627 w221 h106", "Images\matchaguipaneloptions.png")
        MyGui.Add("Pic", "x61  y73  w105 h40",  "Images\matchaguipanelcontrols.png")
        MyGui.Add("Pic", "x228 y73  w105 h40",  "Images\matchaguipanelcontrols.png")
        MyGui.Add("Pic", "x407 y73  w130 h40",  "Images\matchaguipanelcontrols.png")
        MyGui.Add("Pic", "x610 y73  w110 h40",  "Images\matchaguipanelcontrols.png")
        MyGui.Add("Pic", "x842 y470 w221 h106", "Images\matchaguipaneloptions.png")
}

; options gui
ShowOptionsGui(*) {
    OptionsGui.Show("w501 h601")
}

global OptionsGui := Gui("AlwaysOnTop -Caption")
OptionsGui.SetFont("s9 w600 c" . FontColor, "Segoe UI") ; overall font options settings

switch IniRead("Misc\Settings.ini", "Extra Options", "Theme") {
    case "Sakura": 
        OptionsGui.BackColor := "0x171012"
        OptionsGui.Add("Text", "x0   y0   w6   h600 Background0x36232b") ; Left Options Gui Border
        OptionsGui.Add("Text", "x0   y0   w501 h6   Background0x36232b") ; Top Options Gui Border
        OptionsGui.Add("Text", "x495 y0   w6   h600 Background0x36232b") ; Right Options Gui Border
        OptionsGui.Add("Text", "x0   y595 w501 h6   Background0x36232b") ; Bottom Options Gui Border
    
    case "Crimson": 
        OptionsGui.BackColor := "0x331414"
        OptionsGui.Add("Text", "x0   y0   w6   h600 Background0x5e2223") 
        OptionsGui.Add("Text", "x0   y0   w501 h6   Background0x5e2223") 
        OptionsGui.Add("Text", "x495 y0   w6   h600 Background0x5e2223") 
        OptionsGui.Add("Text", "x0   y595 w501 h6   Background0x5e2223") 
    
    case "Dark": 
        OptionsGui.BackColor := "0x212529"
        OptionsGui.Add("Text", "x0   y0   w6   h600 Background0x434a51") 
        OptionsGui.Add("Text", "x0   y0   w501 h6   Background0x434a51") 
        OptionsGui.Add("Text", "x495 y0   w6   h600 Background0x434a51") 
        OptionsGui.Add("Text", "x0   y595 w501 h6   Background0x434a51") 
    
    case "Matcha": 
        OptionsGui.BackColor := "0x2d6a4f"
        OptionsGui.Add("Text", "x0   y0   w6   h600 Background0x6bc297") 
        OptionsGui.Add("Text", "x0   y0   w501 h6   Background0x6bc297") 
        OptionsGui.Add("Text", "x495 y0   w6   h600 Background0x6bc297") 
        OptionsGui.Add("Text", "x0   y595 w501 h6   Background0x6bc297") 
}

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

OptionsGuiSaveButton := OptionsGui.Add("Button", "x173 y550 w115", "Save")
OptionsGuiSaveButton.OnEvent("Click", SettingsSave)

OptionsGui.Add("Text", "x133 y99", "Themes") ; themes text
ThemesDDL := OptionsGui.Add("DDL", "x43 y94 w80 Choose1", ["Sakura", "Crimson", "Dark", "Matcha"]) ; themes ddl

AutoChallengeCheck := OptionsGui.Add("Checkbox", "x43 y133", "Auto Challenges")

; options settings functions
SettingsSave(*) {
    StatusText.Text := "> Settings Saved"

    switch ThemesDDL.Text {
        case "Sakura": 
            IniWrite("Sakura", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Theme")

        case "Crimson": 
            IniWrite("Crimson", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Theme")

        case "Dark": 
            IniWrite("Dark", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Theme")
        
        case "Matcha": 
            IniWrite("Matcha", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Theme") 
    }

    switch AutoChallengeCheck.Value {
        case "1": 
            IniWrite("yes", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challenge")

        case "0": 
            IniWrite("no", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Auto-Challenge") 
    }
}

WebhookSave(*) {

    switch WebhookCheck.Value {
        case "1": 
            IniWrite("enabled", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Webhook")
            
            if dcID != "" && WebhookEdit != "" {
                IniWrite(dcID.Text, A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "WebhookID")
                IniWrite(WebhookEdit.Text, A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "WebhookURL")
            } else {
                MsgBox("Webhook Not Saved!", "Error!", "4096")
                IniWrite("", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "WebhookID")
                IniWrite("", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "WebhookURL")
            }

        case "0":
            IniWrite("disabled", A_ScriptDir . "\Misc\Settings.ini", "Extra Options", "Webhook") 
    }
}

LoadSettings() {
    StatusText.Text := "> Settings Loaded"

    switch IniRead("Misc\Settings.ini", "Extra Options", "Theme") {
        case "Sakura": 
            ThemesDDL.Text := "Sakura"

        case "Crimson": 
            ThemesDDL.Text := "Crimson"

        case "Dark": 
            ThemesDDL.Text := "Dark"
        
        case "Matcha": 
            ThemesDDL.Text := "Matcha"
    }

    switch IniRead("Misc\Settings.ini", "Extra Options", "Auto-Challenge") {
        case "yes": 
            AutoChallengeCheck.Value := "1"

        case "no": 
            AutoChallengeCheck.Value := "0"
    }

    switch IniRead("Misc\Settings.ini", "Extra Options", "Webhook") {
        case "enabled":
            WebhookCheck.Value := "1"
            
        case "disabled":
            WebhookCheck.Value := "0" 
    }

    webhookID  := IniRead("Misc\Settings.ini", "Extra Options", "WebhookID", "")
    webhookURL := IniRead("Misc\Settings.ini", "Extra Options", "WebhookURL", "")

    if webhookID != "" && webhookID != "Discord ID"
        dcID.Text := webhookID
        WebhookEdit.Text := webhookURL
}