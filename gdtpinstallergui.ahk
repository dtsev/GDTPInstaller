﻿; Generated by AutoGUI 2.5.8
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;Tray customization
Menu, Tray, Icon, gdtpinstallericon.ico

Gui Add, Text, x4 y3 w337 h23 +0x200, In order to choose the texture pack you need, open the explorer, open
Gui Add, Text, x5 y25 w336 h23 +0x200, the folder with your texture pack and just select the files that are 
Gui Add, Text, x5 y48 w336 h23 +0x200, INSIDE the folder with the texture pack itself and click button below
Gui Add, Button, x2 y76 w336 h23 gGD_TP_Installer, Install texture pack

Gui Show, w341 h102, GDTPInstaller
Return

GuiEscape:
GuiClose:
ExitApp

Explorer_GetSelection(hwnd="") {
	hwnd := hwnd ? hwnd : WinExist("A")
	WinGetClass class, ahk_id %hwnd%
	if (class="CabinetWClass" or class="ExploreWClass" or class="Progman")
		for window in ComObjCreate("Shell.Application").Windows
			if (window.hwnd==hwnd)
				sel := window.Document.SelectedItems
	for item in sel
		ToReturn .= item.path "`n"
	return Trim(ToReturn,"`n")
}

GD_TP_Installer:
WinActivate, ahk_class CabinetWClass
Sleep 1000
RegRead, OutputVar, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 322170, InstallLocation
SelectedPath := % Explorer_GetSelection()
Loop, Parse, % SelectedPath, `n, `r
{
	FileCopy, %A_LoopField%, %OutputVar%\Resources\, 1
}
MsgBox, The texture pack has been installed.
return
