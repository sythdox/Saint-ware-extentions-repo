#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SendMode, Input
SetWorkingDir, %A_ScriptDir%

global Keybind := "x"
global ReinforceDelay := 5

; ===== LOAD CONFIG.JSON =====
cfgFile := A_ScriptDir "\config.json"
if !FileExist(cfgFile) {
    MsgBox, 16, Better Reinforce, Missing config.json
    ExitApp
}

FileRead, raw, %cfgFile%
Keybind := JsonGetString(raw, "keybind", "x")
ReinforceDelay := JsonGetNumber(raw, "reinforce_delay_ms", 5)

; =========================================================
; ONLY ACTIVE WHEN ROBLOX IS FOCUSED
; =========================================================
#If WinActive("ahk_exe RobloxPlayerBeta.exe")

Hotkey, % "$*" Keybind, DoBurstReinforce, On
return

DoBurstReinforce:
{
    global Keybind, ReinforceDelay

    ; ===== BURST FIRST =====
    SendInput, {LButton Down}
    Sleep, 1
    SendInput, {LButton Up}

    SendInput, {f Down}
    Sleep, 1
    SendInput, {f Up}

    SendInput, {RButton Down}
    Sleep, 1
    SendInput, {RButton Up}

    ; ===== THEN REINFORCE =====
    Sleep, ReinforceDelay

    SendInput, {%Keybind% Down}
    Sleep, 10
    SendInput, {%Keybind% Up}
}
return

#If  ; end context


; ===== JSON HELPERS =====
JsonGetNumber(json, key, def) {
    RegExMatch(json, """" key """" "\s*:\s*([0-9]+)", m)
    return (m1 != "" ? m1 : def)
}

JsonGetString(json, key, def) {
    RegExMatch(json, """" key """" "\s*:\s*""([^""]*)""", m)
    return (m1 != "" ? m1 : def)
}
