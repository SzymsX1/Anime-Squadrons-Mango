#Requires AutoHotkey v2.0
#SingleInstance Force
#Include Misc\funcs.ahk
#Include Misc\ui.ahk
#Include Misc\Libs\Discord-Webhook-master\lib\WEBHOOK.ahk
#Include Misc\Libs\AHKv2-Gdip-master\Gdip_All.ahk
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