#Requires AutoHotkey v2.0

; https://www.autohotkey.com/docs/v2/Hotkeys.htm#Symbols
; #:win, !:Alt, ^:Ctrl, +:Shift
^!Left:: go_left ; Ctrl Alt Left
^!Right:: go_right
^!Up:: go_up
^!Down:: go_down
^!Space:: go_full
^!Tab:: switch_window("right")
^!+Tab:: switch_window("left") ; Ctrl Alt Shift Tab

go_left() {
    WinWait "A"
    WinGetPos(&winx, &winy, &winw, &winh)
    winx2 := winx + winw
    winy2 := winy + winh
    mon := GetMonitorAt(winx, winy)
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        screenh := screeny2 - screeny
        if (winx > screenx) {
            ; MsgBox("go_left: Snap left to " screenx)
            WinMove(screenx, , winw + screenx - winx,) ; snap left and widden
        } else if (winw > screenw / 2) {
            ; MsgBox("go_left: Resize to " screenw / 2)
            WinMove(, , screenw / 2,) ; resize to half
        } else if (winh < screenh) {
            ; MsgBox("go_left: Maximize vertically to " screenh)
            WinMove(, screeny, , screenh) ; maximize vertically
        } else {
            leftmon := GetSideMonitor(mon, "left")
            if (leftmon >= 0) {
                leftmonname := MonitorGetName(leftmon)
                MonitorGetWorkArea(leftmon, &leftscreenx, &leftscreeny, &leftscreenx2, &leftscreeny2)
                ; MsgBox("go_left: Move to left monitor " leftmonname " at " leftscreenx)
                WinMove(leftscreenx) ; move to left monitor
            }
        }
    }
}

go_right() {
    WinWait "A"
    WinGetPos(&winx, &winy, &winw, &winh)
    winx2 := winx + winw
    winy2 := winy + winh
    mon := GetMonitorAt(winx, winy)
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        screenh := screeny2 - screeny
        if (winx2 < screenx2) {
            ; MsgBox("go_right: Widden right to " winw + screenw - winx2)
            WinMove(, , winw + screenx2 - winx2,)  ; widden to reach right screen border
        } else if (winw > screenw / 2) {
            ; MsgBox("go_right: Resize right to " screenw / 2)
            WinMove(screenx + screenw / 2, , screenw / 2,) ; resize to half
        } else if (winh < screenh) {
            ; MsgBox("go_right: Maximize vertically to " screenh)
            WinMove(, screeny, , screenh)  ; maximize vertically
        } else {
            rightmon := GetSideMonitor(mon, "right")
            if (rightmon >= 0) {
                rightmonname := MonitorGetName(rightmon)
                MonitorGetWorkArea(rightmon, &rightscreenx, &rightscreeny, &rightscreenx2, &rightscreeny2)
                ; MsgBox("go_right: Move to right monitor " rightmonname " at " rightscreenx)
                WinMove(rightscreenx) ; move to right monitor
            }
        }
    }
}

go_up() {
    MsgBox("TODO go_up")
    ; TODO
}
go_down(){
    MsgBox("TODO go_down")
    ; TODO
}
go_full(){
    MsgBox("TODO go_full")
    ; TODO
}
switch_window(direction){
    MsgBox("TODO switch_window " direction)
    ; TODO
}

;===================================
;============== utils ==============
;===================================

GetSideMonitor(monindex, direction) {
    MonitorGet(monindex, &monx, &mony, &monx2, &mony2)
    ; MsgBox("GetSideMonitor(" direction ") : " monindex ", " MonitorGetName(monindex) " info: x:" monx ", y:" mony ", x2:" monx2 ", y2:" mony2)
    MonitorCount := MonitorGetCount()
    Loop MonitorCount {
        if (A_Index != monindex) {
            MonitorGet(A_Index, &sidemonx, &sidemony, &sidemonx2, &sidemony2)
            ; MsgBox("GetSideMonitor(" direction ") : " A_Index ", " MonitorGetName(A_Index) " info: x:" sidemonx ", y:" sidemony ", x2:" sidemonx2 ", y2:" sidemony2)
            ;MonitorGetWorkArea(A_Index, &wax, &way, &wax2, &way2)
            if (direction == "left" and sidemonx2 < monx) {
                ; MsgBox("GetSideMonitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "right" and sidemonx > monx2) {
                ; MsgBox("GetSideMonitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "up" and sidemony2 < mony) {
                ; MsgBox("GetSideMonitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "down" and sidemony > mony) {
                ; MsgBox("GetSideMonitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            }
        }
    }
    ; MsgBox("GetSideMonitor(" direction ") not found, returning -1")
    return -1
}

GetMonitorAt(winx, winy) {
    MonitorCount := MonitorGetCount()
    Loop MonitorCount {
        ; MonitorGet(A_Index, &monx, &mony, &monx2, &mony2)
        MonitorGetWorkArea(A_Index, &wax, &way, &wax2, &way2)
        if (winx >= wax and winx <= wax2 and winy >= way and winy <= way2) {
            return A_Index
        }
    }
    MsgBox("GetMonitorAt(" winx ", " winy ") not found, returning -1")
    return -1
}

; MsgBox "Reloaded!"
