; https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols
; #:win, !:Alt, ^:Ctrl, +:Shift
; <: left key, >: right key
; <^>!:AltGr (because in windows Ctrl+Alt = AltGr ; https://en.wikipedia.org/wiki/AltGr_key)

; Note, I have an AZERTY keyboard

; Copy/Paste
#c::^c ; Win C to Ctrl C (Copy)
#v::^v ; Win V to Ctrl V (Paste)

; Mac like (use target string instead of key combo)
<^>!,::~ ; <^>!é ; AltGr , to AltGr é (tilde ~) (On mac it's on 'n', but I use AltGr N for } )
<^>!l::| ; <^>!- ; AltGr l to AltGr - (pipe |)

; Brackets on : t/y:() ; g/h:[] ; b/n:{}
; Note: Also managed on my keychron with left fn + t/y:() ; g/h:[] ; b/n:{}
<^>!t::(
<^>!y::)
<^>!g::[
<^>!h::]
<^>!b::<^>!' ;  for { the string doesnt work, use the combination key : AltGR '
<^>!n::<^>!= ;  for } the string doesnt work, use the combination key : AltGR =