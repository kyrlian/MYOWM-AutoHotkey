; Kyrlian 2024

; https://www.autohotkey.com/docs/v2/howto/SendKeys.htm

; https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols
; #:win, !:Alt, ^:Ctrl, +:Shift
; <:left key, >:right key
; <^>!:AltGr (because in windows Left Ctrl + Right Alt = AltGr ; https://en.wikipedia.org/wiki/AltGr_key)

; Note, I have a French AZERTY keyboard

; Reload script
^!r::{ ; AltGr + r
    MsgBox "Reloading"
    Reload
}

; Copy/Paste
#c::^c ; Win C to Ctrl C (Copy)
#v::^v ; Win V to Ctrl V (Paste)

; Mac like (use target string instead of key combo)
<^>!n::SendText "~" ; AltGr n to tilde ~ (On mac it's on 'n', but I use AltGr N for } )
<^>!l::SendText "|" ; AltGr l to pipe |
<^>!SC034::SendText "\" ; AltGr : (using the scan code for colon : 034) to backslash \
; {} on AltGr (or Ctrl+Alt) + Shift + ()
^!+(::SendText "{"
^!+)::SendText "}"

; Brackets on AltGr and t/y for () ; g/h for [] ; and shift g/h for {}
; Note: Also managed on my keychron with left fn + t/y:() ; g/h:[] ; b/n:{}
<^>!t::SendText "("
<^>!y::SendText ")"
<^>!g::SendText "["
<^>!h::SendText "]"
<^>!+g::SendText "{" ; I had those on b/n, but I use AltGr n for tilde ~, so moving {} to AltGr Shift g/h
<^>!+h::SendText "}" ; Note 'Send' doesnt work for {  and }

; Symbols on AltGr + similar char
<^>!a::SendText "@"
; <^>!s::Send "$" ; Removed as I use Ctrl Alt s for split in wezterm
<^>!c::SendText "ç"
<^>!d::SendText "#" ; Hash is 'Diese' in French, so it's easy to remember :) 

; backtick ` on Altgr ² (left of 1) - it's on AltGr 7 on French keyboard, but I always forget
<^>!+"::SendText '``' ; Note the backtick needs to be doubled ``
; also on Altgr + shift + 3 or 4 (" and ' )
<^>!+'::SendText '``' ; Note the backtick needs to be doubled ``


; quick type my email with AltGr (or Ctrl+Alt) + M
; <^>!m::SendText "kyrlian@gmail.com"
^!m::SendText 'kyrlian@gmail.com'
