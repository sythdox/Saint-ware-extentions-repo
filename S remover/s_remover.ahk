#NoEnv
#SingleInstance Force
#Persistent
SetBatchLines, -1
SendMode, Input

; Block S only while Roblox is active
#IfWinActive, Roblox
*s::return
#IfWinActive
