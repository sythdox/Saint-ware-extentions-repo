#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

Log(msg) {
    FileAppend, %A_Now% " [worker] " msg "`n", %A_ScriptDir%\watchdog.log
}

; Correct way to read args in AHK v1.1+
launcherPID := (A_Args.Length() >= 1) ? A_Args[1] : 0

exePath := A_ScriptDir "\ParryIndicator.exe"
cfgPath := A_ScriptDir "\config.json"

if !FileExist(exePath) {
    Log("missing ParryIndicator.exe")
    ExitApp
}

duration := 3000
if FileExist(cfgPath) {
    FileRead, raw, %cfgPath%
    RegExMatch(raw, """duration_ms""\s*:\s*([0-9]+)", m)
    if (m1 != "")
        duration := m1
}
Log("duration=" duration)


Run, % """" exePath """ OPENTHRUAKAIMACROPACKONLYSUPPORTARC " duration, %A_ScriptDir%, Hide


SetTimer, WatchLauncher, 300
return

WatchLauncher:
    if (!launcherPID) {
        
        ExitApp
    }

    Process, Exist, %launcherPID%
    if (ErrorLevel = 0) {
        Log("launcher dead -> closing indicator")

        
        Run, % """" exePath """ to close", %A_ScriptDir%, Hide
        Sleep, 150

        
        Process, Close, ParryIndicator.exe

        
        ExitApp
    }
return
