#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
F1::
if WinExist("ahk_exe msedge.exe",,"Picture-in-Picture")
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
return

;; With alt
<!F3::
if WinExist("ahk_exe explorer.exe")
    WinActivate
return