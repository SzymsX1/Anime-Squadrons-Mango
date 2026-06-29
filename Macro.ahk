#Requires AutoHotkey v2.0
#SingleInstance Force
#Include Misc\funcs.ahk
#Include Misc\ui.ahk
LoadSettings()
ActivateRoblox()
F1:: {
    ActivateRoblox()
    Sleep(300)
    PlayFunction()
}
Paused := false
F2:: {
    PauseMacro()
}
F3:: Reload
F4:: ExitApp()