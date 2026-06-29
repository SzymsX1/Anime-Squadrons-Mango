#Requires AutoHotkey v2.0
CoordMode("pixel", "window")
CoordMode("mouse", "window")
roblox := "ahk_exe RobloxPlayerBeta.exe"
CurrentTime := A_Now
ActivateRoblox() {
    if !WinExist(roblox) {
        StatusText.Text := "Roblox Not Found!"
        return false
    } else {
        WinActivate(roblox)
        WinGetPos(&x, &y, &w, &h, roblox)
        WinMove(x, y, 800, 600, roblox)
        WinActivate(roblox)
        SetTimer(AttachRBX, 50)
    }
}

AttachRBX() {
    if !WinExist(roblox) {
        StatusText.Text := "Roblox Not Found!"
        return false
    } else {
    WinGetPos(&x, &y, &w, , MyGui)
    WinMove(x, y + 100, 800, 600, roblox)
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
    global Paused
    Paused := !Paused
    Pause(Paused)
    StatusText.Text := paused ? "> Paused" : "> Resumed"
}

; main play function
PlayFunction() {
    if (EventsStageDDL.Text = "Boros") {
        EventsPlayFunc()
    } else {
    
        Wiggle1(40, 300) ; play gui button
        Sleep(2000)
        Wiggle1(409, 502) ; create match button
        Sleep(500)
    
        if (AutoChallangeCheck.Value = "1") {
            AutoChallangePlay()
        } else {
    
            Sleep(500)

            ModePlayFunc()

            Sleep(500)
    
            if (ModesDDL.Text = "Story") {
                StoryPlayFunc()
            } else if (ModesDDL.Text = "Squadron") {
                SquadronPlayFunc()
            } else if (ModesDDL.Text = "Raid") {
                RaidPlayFunc()
            } else if (ModesDDL.Text = "Challange") {
                ChallangePlayFunc()
            }

            Sleep(500)
            Wiggle1(530, 418)
            Sleep(500)
            Wiggle1(597, 436)
        }
    }
}

ModePlayFunc() {
    if (ModesDDL.Text = "Story") {
        Wiggle1(249, 470)
    } else if (ModesDDL.Text = "Squadron") {
        Wiggle1(364, 471)
    } else if (ModesDDL.Text = "Raid") {
        Wiggle1(598, 472)
    } else if (ModesDDL.Text = "Challange") {
        Wiggle1(480, 473)
    }
}

StoryPlayFunc() {
    StagePlayFunc(StoryStageDDL)
    Sleep(500)
    ActsPlayFunc(StoryActDDL)
    Sleep(500)
    Wiggle1(579, 335)

}


SquadronPlayFunc() {
    StagePlayFunc(SquadronStageDDL)
    Sleep(500)
    
    if (SquadronStageDDL.Text = "Ninja Village" || SquadronStageDDL.Text = "Eclipse (Before)") {
        ActsPlayFunc(SquadronActDDL1)
    } else {
        ActsPlayFunc(SquadronActDDL)
    }
    
    Sleep(500)
    Wiggle1(579, 335)
}

RaidPlayFunc() {
    RaidFUNCPlayFunc()
    Sleep(500)
    ActsPlayFunc(RaidActDDL)
    Sleep(500)
    DiffPlayFunc(RaidDiffDDL)

}

ActsPlayFunc(control) {
        if (control.Text = "1") {
            Wiggle1(417, 228)
        } else if (control.Text = "2") {
            Wiggle1(415, 253)
        } else if (control.Text = "3") {
            Wiggle1(415, 280)
        } else if (control.Text = "4") {
            Wiggle1(416, 301)
        } else if (control.Text = "5") {
            Wiggle1(417, 327)
        } else if (control.Text = "6") {
            Wiggle1(417, 349)
        } else if (control.Text = "7") {
            Wiggle1(416, 374)
        } else if (control.Text = "8") {
            Wiggle1("415", "267")
            Sleep(500)
            Send("{WheelDown}")
            Sleep(500)
            Wiggle1(417, 333)
        } else if (control.Text = "9") {
            Wiggle1("415", "267")
            Sleep(500)
            Send("{WheelDown}")
            Sleep(500)
            Wiggle1(418, 354)
        } else if (control.Text = "10") {
            Wiggle1("415", "267")
            Sleep(500)
            Send("{WheelDown}")
            Sleep(500)
            Wiggle1(416, 377)
        }
 }

StagePlayFunc(control) {
        if (control.Text = "GT City") {
            Wiggle1(275, 222)
        } else if (control.Text = "Marine Lobby") {
            Wiggle1(271, 270)
        } else if (control.Text = "Ninja Village") {
            Wiggle1(270, 314)
        } else if (control.Text = "Eclipse (Before)") {
            Wiggle1(267, 360)
        }
}

DiffPlayFunc(control) {
    if (control.Text = "Hard") {
        Wiggle1(579, 335)
    } else {
        Wiggle1(551, 336)
    }
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

ChallangePlayFunc() {
    if (ChallangeStageDDL.Text = "Daily") {
        StatusText.Text := "> Playing Daily Challange"
        Wiggle1(275, 222)
        Sleep(500)
        Wiggle1(530, 418)
        Sleep(500)
        Wiggle1(597, 436)
        Sleep(8000)
        loop 
            if PixelSearch5("0xC90101", 370, 456, 426, 482, "11") {
                Sleep(500)
                Wiggle1(429, 425)
                StatusText.Text := "> Daily Challange Completed"
                break
            }        
    } else if (ChallangeStageDDL.Text = "Katakara Bridge") {
        StatusText.Text := "> Playing Katakara Bridge"
        Wiggle1(270, 314)
        if (ChallangeDiffDDL.Text = "Hard") {
            StatusText.Text := "> Playing Katakara Bridge Hard"
            Wiggle1(580, 336)
        } else {
            StatusText.Text := "> Playing Katakara Bridge Normal"
            Wiggle1(551, 337)
        }
    } else if (ChallangeStageDDL.Text = "TheHeroHunter") {
        Wiggle1(267, 360)
        if (ChallangeDiffDDL.Text = "Hard") {
            StatusText.Text := "> Playing TheHeroHunter Hard"
            Wiggle1(580, 336)
        } else {
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
}

AutoChallangePlay() {
    StatusText.Text := "> Playing Regular Challange"
    Wiggle1(480, 473)
    Sleep(500)
    Wiggle1(271, 270)
    Sleep(500)
    Wiggle1(530, 419)
    Sleep(500)
    Wiggle1(597, 436)
    SetTimer(AutoChallangeLoop, 50)
}

AutoChallangeLoop() {
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
            if PixelSearch5("0x24cdfb", "69", "373", "114", "414", "5") {
                Sleep(500)
                PlayFunction()
                break
            }
        }
    }
}