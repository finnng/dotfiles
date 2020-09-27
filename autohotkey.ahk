#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#MenuMaskKey vkE8  ; Change the masking key to something unassigned such as vkE8.

; cmd+a
!a::
Send, ^a
return

; starts vim keys
^j::
Send, {down}
return

^k::
Send, {up}
return

^h::
Send, {left}
return

#IfWinActive ahk_class MozillaWindowClass
!l::
Send, ^l
return

#IfWinNotActive ahk_class MozillaWindowClass
^l::
Send, {right}
return

#IfWinActive ahk_exe nvim-qt.exe
j & k::
Send, {Esc}
return

#IfWinActive ahk_exe nvim-qt.exe
k & j::
Send, {Esc}
return

; ~j::
; Send, j
; return

; ~k::
; Send, k
; return

; ends vim keys ------------------------kk

!q::
Send, !{f4}
return

!c::
Send, ^c
return

!v::
Send, ^v
return

!t::
Send, ^t
return

!w::
Send, ^w
return

!BackSpace::
Send, +{Home}{BackSpace}
return
