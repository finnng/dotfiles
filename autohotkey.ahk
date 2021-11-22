#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
F1::
if WinExist("ahk_exe chrome.exe",,"Picture-in-Picture")
    WinActivate
return

F2::
if WinExist("ahk_exe code.exe")
    WinActivate
return

!F2::
if WinExist("ahk_exe thunderbird.exe")
    WinActivate
return

F3::
if WinExist("ahk_exe WindowsTerminal.exe")
    WinActivate
return

F4::
if WinExist("ahk_exe rider64.exe")
    WinActivate
return

F5::
if WinExist("ahk_exe firefox.exe",,"Picture-in-Picture")
    WinActivate
return

!F5::
if WinExist("ahk_exe telegram.exe")
    WinActivate
return

F6::
if WinExist("ahk_exe discord.exe")
    WinActivate
return

F7::
if WinExist("ahk_exe Slack.exe")
    WinActivate
return

F8::
if WinExist("ahk_exe Postman.exe")
    WinActivate
return

F9::
if WinExist("ahk_exe pritunl.exe")
    WinActivate
if WinExist("ahk_exe Authy Desktop.exe")
    WinActivate
return

F10::
if WinExist("ahk_exe clickup.exe")
    WinActivate
return

; + arrow keys
<!Up::send {RAlt Up}{PgUp}
<!Down::send {RAlt Up}{PgDn}
<!Left::send {RAlt Up}{Home}
<!Right::send {RAlt Up}{End}

^j::send {Down}
^k::send {Up}
^h::send {Left}
^l::send {Right}

$~*Ctrl:: 
if !state 
	state :=  (GetKeyState("Shift", "P") ||  GetKeyState("Alt", "P") || GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
return 

$~ctrl up::
if instr(A_PriorKey, "control") && !state
	send {esc}
state := 0 
return 
