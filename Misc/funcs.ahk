#Requires AutoHotkey v2.0
#Include Libs\AHKv2-Gdip-master\Gdip_All.ahk
CoordMode("pixel", "window")
CoordMode("mouse", "window")
roblox := "ahk_exe RobloxPlayerBeta.exe"
global CurrentTime := A_Now
global WinTotal := 0
global LossTotal := 0
global MatchesTotal := 0
global StageLoopedTime := A_TickCount
global runStartingTime := A_TickCount
ActivateRoblox() {
    if !WinExist(roblox) {
        StatusText.Text := "Roblox Not Found!"
        return false
    } else {
        WinActivate(roblox)
        WinGetPos(&x, &y, &w, &h, MyGui)
        WinMove(x, y + 100, 800, 600, roblox)
    }
}

AttachRBX() {
    global paused
    PostMessage(0xA1, 2)
    Sleep 1
    if (!paused && WinExist(roblox)) {
        WinGetPos(&x, &y, &w, &h, MyGui)
        WinActivate(roblox)
        WinMove(X, Y + 100, 800, 600, roblox)
    }
}

Wiggle1(x, y) {
    MouseMove(x, y)
    Sleep(300)
    MouseMove(1, 1, 5, "R")
    Sleep(300)
    MouseMove(-1, -1, 5, "R")
    Sleep(300)
    Click
}

PixelSearch5(color, x1, y1, x2, y2, variation) {
    global foundX, foundY
    if PixelSearch(&foundX, &foundY, x1, y1, x2, y2, color, variation) {
        return [foundX, foundY]
    }
    return false
}

PauseMacro(*) {
    if !WinExist(roblox) {
        return
    }
    static paused := false
    paused := !paused
    Pause paused
    StatusText.Text := paused ? "> Paused" : "> Resumed"
}

; main play function
PlayFunction() {
    if (EventsStageDDL.Text = "Boros") {
        StatusText.Text := "> Playing Event"
        EventsPlayFunc()
    } else {
        Wiggle1(40, 300) ; play gui button
        Sleep(2000)
        Wiggle1(409, 502) ; create match button
        Sleep(500)

        if (AutoChallengeCheck.Value = "1") {
            StatusText.Text := "> Playing Auto-Challenge"
            AutoChallengePlay()
        } else {

            ModePlayFunc()
            Sleep(500)

            switch ModesDDL.Text {
                case "Story":
                    StoryPlayFunc()
                case "Squadron":
                    SquadronPlayFunc()
                case "Raid":
                    RaidPlayFunc()
                case "Challenge":
                    ChallengePlayFunc()
                case "Invasion":
                    InvasionPlayFunc()
            }

            Sleep(500)
            Wiggle1(530, 418) ; clicks create match2
            Sleep(500)
            Wiggle1(595, 438) ; clicks start
            Sleep(500)

            ingameDetection()
        }
    }
}

GameMainLoop() {
    loop {
        DisconnectDetection()
        Sleep(500)

        result := WinOrLossDetection()
        Sleep(1600)

        if (result = "Win" || result = "Loss") {
            ReplayFunc()
            Sleep(750)
        }
    }
    
}

ModePlayFunc() {
    switch ModesDDL.Text {
        case "Story": 
            Wiggle1(302, 468)

        case "Squadron": 
            Wiggle1(424, 467)

        case "Raid": 
            Wiggle1(362, 520)

        case "Challenge": 
            Wiggle1(546, 468)
        
        case "Invasion": 
            Wiggle1(484, 518) 
    }
}

StagePlayFunc(control) {
    switch control.Text {
        case "GT City": 
            Wiggle1(275, 222)

        case "Marine Lobby": 
            Wiggle1(271, 270)

        case "Ninja Village":  
            Wiggle1(270, 314)
        
        case "Eclipse (Before)": 
            Wiggle1(267, 360)

        case "Ice Continent": 
            Wiggle1(270, 404) 
    }
}

ActCoords := Map(
    "1",  [417, 228],
    "2",  [415, 253],
    "3",  [415, 280],
    "4",  [416, 301],
    "5",  [417, 327],
    "6",  [417, 349],
    "7",  [416, 374],
    "8",  [417, 333],
    "9",  [418, 354],
    "10", [416, 377]
)

ActsPlayFunc(control) {
    global ActCoords

    if !ActCoords.Has(control.Text)
        return

    ; Acts 8-10 require scrolling first
    if Integer(control.Text) >= 8 {
        Wiggle1(415, 267)
        Sleep(500)
        Send("{WheelDown}")
        Sleep(500)
    }

    pos := ActCoords[control.Text]
    Wiggle1(pos[1], pos[2])
}

DiffPlayFunc(control) {
    if (control.Text = "Hard") {
        Wiggle1(580, 336) ; sets hard diff
    } else {
        Wiggle1(551, 336) ; sets normal diff
    }
}

StoryPlayFunc() {
    StagePlayFunc(StoryStageDDL)
    Sleep(500)
    ActsPlayFunc(StoryActDDL)
    Sleep(500)
    Wiggle1(579, 334) ; sets diff
}


SquadronPlayFunc() {
    StagePlayFunc(SquadronStageDDL)
    Sleep(500)
    
    if (SquadronStageDDL.Text = "Ninja Village" || SquadronStageDDL.Text = "Eclipse (Before)" || SquadronStageDDL.Text = "Ice Continent") {
        ActsPlayFunc(SquadronActDDL1)
    } else {
        ActsPlayFunc(SquadronActDDL)
    }
    
    Sleep(500)
    Wiggle1(580, 337)
}

RaidPlayFunc() {
    RaidFUNCPlayFunc()
    Sleep(500)
    ActsPlayFunc(RaidActDDL)
    Sleep(500)
    DiffPlayFunc(RaidDiffDDL)

}

RaidFUNCPlayFunc() {
    if (RaidStageDDL.Text = "GT City") {
        StatusText.Text := "> Playing GT City Raid"
        Wiggle1(275, 222)    
    } else if (RaidStageDDL.Text = "Eclipse (Before)") {
        StatusText.Text := "> Playing Eclipse (Before) Raid"
        Wiggle1(271, 270)
    }
}

InvasionPlayFunc() {
    if InvasionStageDDL.Text = "Lava Continent"
        Wiggle1(275, 222)
    Sleep(500)
    ActsPlayFunc(InvasionActsDDL)
    Sleep(500)
    DiffPlayFunc(InvasionDiffDDL)
}

ChallengePlayFunc() {

    switch ChallengeStageDDL.Text {
        case "Daily":
            StatusText.Text := "> Playing Daily Challenge"
            Wiggle1(275, 222)
            Sleep(500)
            Wiggle1(530, 418)
            Sleep(500)
            Wiggle1(634, 436)
            Sleep(8000)
            loop {
                if PixelSearch5(0xFFFFFF, 231, 202, 344, 213, 2) {
                    if PixelSearch5(0x29D379, 342, 209, 407, 221, 2) {
                        Sleep(500)
                        WinOrLossDetection()
                        Sleep(300)
                        Wiggle1(429, 425)
                        StatusText.Text := "> Daily Challenge Completed"
                        break
                    }
                }
            }

        case "Katakara Bridge":
            StatusText.Text := "> Playing Katakara Bridge"
            Wiggle1(275, 316)
            Sleep(500)

            switch ChallengeDiffDDL.Text {
                case "Hard": 
                    StatusText.Text := "> Playing Katakara Bridge Hard"
                    Wiggle1(580, 336)

                case "Normal": 
                    StatusText.Text := "> Playing Katakara Bridge Normal"
                    Wiggle1(551, 337)
            }
        
        case "TheHeroHunter": 
            StatusText.Text := "> Playing TheHeroHunter"
            Wiggle1(267, 360)
            Sleep(500)

            switch ChallengeDiffDDL.Text {
                case "Hard": 
                    StatusText.Text := "> Playing TheHeroHunter Hard"
                    Wiggle1(580, 336)

                case "Normal": 
                    StatusText.Text := "> Playing TheHeroHunter Normal"
                    Wiggle1(551, 337)
            }
    }
}

EventsPlayFunc() {
    Wiggle1(775, 324)
    Sleep(500)
    Wiggle1(533, 410)
    Sleep(500)
    Wiggle1(671, 437)
    Sleep(500)
    ingameDetection()
}

AutoChallengePlay() {
    StatusText.Text := "> Playing Regular Challenge"
    Wiggle1(546, 468)
    Sleep(500)
    Wiggle1(271, 270)
    Sleep(500)
    Wiggle1(530, 419)
    Sleep(500)
    Wiggle1(634, 436)
    Sleep(500)
    ingameDetection()
    SetTimer(AutoChallengeLoop, 50)
}

AutoChallengeLoop() {
    CurrentTime := FormatTime(A_Now, "mmss")

    if (CurrentTime = "0010" || CurrentTime = "3010") {
        if WinExist(roblox) {
            WinClose(roblox)
            Sleep(300)
            WinClose(roblox)
            Sleep(1000)
        }
            
        Run("roblox://placeId=" 71132543521245)
        WinWait(roblox)
        loop {
            Click(411, 332)
            Sleep(1000)
            if PixelSearch5("0x24cdfb", "69", "373", "114", "414", "2") {
                Sleep(500)
                PlayFunction()
                break
            }
        }
    }
}

DisconnectDetection() {
    if ImageSearch(&foundX, &foundY, 335, 214, 475, 241, "Images\disconnect.png") {
        WebhookScreenshot("Disconnected", "Launching Roblox...")
        Sleep(500)
        Run("roblox://placeId=" 71132543521245)
        WinWait(roblox)
        loop {
            Click(411, 332)
            Sleep(1000)
            if PixelSearch5("0x24cdfb", "69", "373", "114", "414", "2") {
                Sleep(500)
                PlayFunction()
                break
            }
        }
    }

}

ingameDetection() {
    global StageLoopedTime

    loop {
        if PixelSearch5(0x8D8100, 715, 323, 800, 352, 2) {
            StageLoopedTime := A_TickCount
            if EventsStageDDL.Text = "Boros" {
                Send("{d down}")
                Sleep(950)
                Send("{d up}")
                Sleep(300)
                Send("{w down}")
                Sleep(500)
                Send("{w up}")
                Sleep(300)
                Send("{e}")
            }
            GameMainLoop()
            return
        }
    }
}

ReplayFunc() {
    global StageLoopedTime

    switch WinOrLossDetection() {
        case "Win", "Loss":
            return
    }
    StageLoopedTime := A_TickCount
    Sleep(3000)
    GameMainLoop()

}

WinOrLossDetection() {
    if PixelSearch5(0xFFFFFF, 231, 202, 344, 213, 2) {
        if PixelSearch5(0xF20018, 342, 209, 407, 221, 2) {
            global MatchesTotal += 1
            try
                WebhookScreenshot("Match Loss", "")
            return "Loss"
            
        }
    }

    if PixelSearch5(0xFFFFFF, 231, 202, 344, 213, 2) {
        if PixelSearch5(0x29D379, 342, 209, 407, 221, 2) {
            global MatchesTotal += 1
            try
                WebhookScreenshot("Match Win", "")
            return "Win"
            
        }
    }
}

LoopTime(Start1ngTime) {
    MsLooped := A_TickCount - Start1ngTime
    hour := Floor(MsLooped / (1000 * 60 * 60))
    minute := Floor(Mod(MsLooped / (1000 * 60), 60))
    second := Float(Mod(MsLooped / 1000, 60))

    if (hour > 0)
        return Format("{:02d}:{:02d}:{:02d}", hour, minute, second)
    else
        return Format("{:02d}:{:02d}", minute, second)
}

WebhookScreenshot(title, description) {
    ActivateRoblox()

    if MyGui["EnableWebhook"].Value {
        StatusText.Text := "Webhook Enabled"
        color := 0x00aeff

        if InStr(title, "Win")
            color := 0x4BB543
        else if InStr(title, "Loss")
            color := 0xFF3333
        else if InStr(title, "Disconnected")
            color := 0x8B2FC9

        discordId := MyGui["DiscordIDEdit"].Value
        WebhookURL := MyGui["MyEdit"].Value
        webhook := WebhookBuilder(WebhookURL)

        if !(WebhookURL ~=
            "i)^https:\/\/((?:ptb|canary)\.)?discord(?:app)?\.com\/api\/webhooks\/\d{17,23}\/[A-Za-z0-9_\-\.]{60,100}$"
        ) {
            MsgBox("Invalid Discord webhook URL", "Webhook Error", "Icon!")
            return
        }

        pToken := Gdip_Startup()
        if !pToken {
            MsgBox("Failed to initialize GDI+")
            return
        }

        MonitorGet(MonitorGetPrimary(), &Left, &Top, &Right, &Bottom)
        pBitmap := Gdip_BitmapFromScreen(Left "|" Top "|" (Right - Left) "|" (Bottom - Top))
        if !pBitmap {
            MsgBox("Failed to capture the screen")
            Gdip_Shutdown(pToken)
            return
        }

        WinGetClientPos(&x, &y, &w, &h, roblox)
        pCroppedBitmap := Gdip_CloneBitmapArea(pBitmap, x, y + 5, w - 10, h - 10)
        if !pCroppedBitmap {
            MsgBox("Failed to crop the bitmap")
            Gdip_DisposeImage(pBitmap)
            Gdip_Shutdown(pToken)
            return
        }

        global WinTotal, LossTotal, MatchesTotal
        loopedTime := LoopTime(StageLoopedTime)
        totalTime := LoopTime(runStartingTime)

        attachment := AttachmentBuilder(pCroppedBitmap)
        myEmbed := EmbedBuilder()

        myEmbed.setTitle(title . " - " . ModesDDL.Text . " #" . MatchesTotal)

        enhancedDesc := description
        if (description == "")
            enhancedDesc := "**Run Summary:** `n• :1234: Run #: " . MatchesTotal

        myEmbed.setDescription(enhancedDesc)
        myEmbed.setColor(color)
        myEmbed.setImage(attachment)

        currentTime := FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss")
        myEmbed.setFooter({ text: "SzymsX AS Macro " MacroVersion " | Run: " loopedTime " | Total: " totalTime " | " currentTime })

        webhook.send({
            content: discordId ? "<@" discordId ">" : "",
            embeds: [myEmbed],
            files: [attachment]
        })

        Gdip_DisposeImage(pCroppedBitmap)
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        StatusText.Text := "Webhook sent: " title
    }
}
