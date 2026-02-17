#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%




launcherPID := DllCall("GetCurrentProcessId")


ahkExe := A_ScriptDir "\..\..\bin\AutoHotkey.exe"
worker := A_ScriptDir "\visualizer_worker.ahk"



if !FileExist(ahkExe) {
    MsgBox, 16, Visualizer, Missing AutoHotkey.exe at:`n%ahkExe%
    ExitApp
}
if !FileExist(worker) {
    MsgBox, 16, Visualizer, Missing worker at:`n%worker%
    ExitApp
}

Run, % """" ahkExe """ """ worker """ " launcherPID, %A_ScriptDir%, Hide

return
