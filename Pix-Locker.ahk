#SingleInstance FORCE
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#Persistent
CoordMode Pixel, Screen  ; Interprets the coordinates below as relative to the screen rather than the active window.
DetectHiddenWindows, On

; Start gdi+
#Include, %A_ScriptDir%\Gdip_All.ahk
If !pToken := Gdip_Startup()
{
	MsgBox, 48, gdiplus error!, Gdiplus failed to start. Please ensure you have gdiplus on your system
	ExitApp
}
OnExit, ApClose

; Default
Campath := "C:\WinApps\Cam"
;HideFile := 0 ; Switch to 1 to hide the saved picture file ; To be implemented

; Run as Admin to allow BlockInput
full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

; Set keys as hotkeys
Loop, 26
  Hotkey, % Chr(96 + A_index), AnyKey
Loop, 10
  Hotkey, % A_Index - 1, AnyKey

AppsKey & l::
    State := State = "true" ? "False" : "True"
    secvar := 0
    If State = True
    {
        MsgBox, Once this message box passed, any key`npressed will block the controls and`ntrigger the camera.
        MouseGetPos, x, y
        xb := x
        yb := y
        secbol := True
        same := True
        Gosub, ApChecker
        return              
    }
    Else
    {
        BlockInput, on
        BlockInput, off
        MsgBox, The controls are unlocked.
        secvar := 1
        secbol := False
        Sleep, 15

        Gosub, Unkey
        return      
    }    
    return

ApChecker:
    while same = True
    {
        Sleep, 10
        MouseGetPos, xx, yy
        if (xx <> xb or yy <> yb)
        {
            same := False
            break
        }
    }

    if (secbol = True)
    {
        BlockInput, on
        Gosub, ApCam
        return
    }
    Else
        return

ApCam:
    if secvar = 0
    {
        Run, %Campath%
        Sleep, 1500
        SaveNQuit(A_ScriptDir, "")
        return        
    }
    return

AnyKey:
    same = False
    if secvar = 0
        Gosub, ApChecker
    return

; Save the picture
SaveNQuit(SavePath,Hwnd) 
{
	IfNotExist, %SavePath%
		FileCreateDir, %SavePath%
	if !Hwnd
		WinGet, Hwnd, ID, A
	WinGetPos, X, Y, W, H,  ahk_id %Hwnd%
	pToken := Gdip_Startup()
	pBitmap := Gdip_BitmapFromScreen(X "|" Y "|" W "|" H)
	FormatTime, TimeStamp ,, yyyy_MM_dd @ HH_mm_ss 
	FileName := TimeStamp " (" w "x" h  ").PNG"
	Gdip_SaveBitmapToFile(pBitmap, SavePath FileName)
	Gdip_DisposeImage(pBitmap)
	Gdip_Shutdown("pToken")
    ; Close the camera windows :
	MouseClick, Left, W-20, Y-40, 1, 1
	return SavePath FileName
}

Unkey:
    Loop, 26
        Hotkey, % Chr(96 + A_index), off
    Loop, 10
        Hotkey, % A_Index - 1, off
    return

ApClose:
    AppsKey & x::
    Gosub, Unkey
    ExitApp
    return
