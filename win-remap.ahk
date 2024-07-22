; https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols
; #:win, !:Alt, ^:Ctrl, +:Shift
; <:left key, >:right key
; <^>!:AltGr (because in windows Ctrl+Alt = AltGr ; https://en.wikipedia.org/wiki/AltGr_key)

; Note, I have an AZERTY keyboard

; Reload script :
^!r::{ ; AltGr + r
    MsgBox "Reloading"
    Reload
}

; Copy/Paste
#c::^c ; Win C to Ctrl C (Copy)
#v::^v ; Win V to Ctrl V (Paste)

; Mac like (use target string instead of key combo)
<^>!,::~ ; AltGr , to tilde ~ (On mac it's on 'n', but I use AltGr N for } )
<^>!l::| ; AltGr l to pipe |
; {} on AltGr (or Ctrl+Alt) + Shift + ()
^!+(::SendText "{"
^!+)::SendText "}"

; Brackets on AltGr +: t/y:() ; g/h:[] ; b/n:{}
; Note: Also managed on my keychron with left fn + t/y:() ; g/h:[] ; b/n:{}
<^>!t::Send "("
<^>!y::Send ")"
<^>!g::Send "["
<^>!h::Send "]"
<^>!b::SendText "{" ; <^>!b::<^>!' ;  for { Send string doesnt work
<^>!n::SendText "}" ; <^>!n::<^>!= ;  for } Send string doesnt work

; Symbols on AltGr + similar char
<^>!a::Send "@"
<^>!s::Send "$"

; quick type my email with AltGr (or Ctrl+Alt) + M
<^>!m::SendText "kyrlian@gmail.com"
^!m::SendText "kyrlian@gmail.com"