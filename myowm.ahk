#Requires AutoHotkey v2.0

; Kyrlian 2024
; https://github.com/kyrlian/MYOWM-AutoHotkey

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
    mon := get_win_monitor(WinGetID())
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        screenh := screeny2 - screeny
        if (winx > screenx) {
            ; MsgBox("go_left: Snap left to " screenx)
            WinMove(screenx, , winw + winx - screenx,) ; snap left and widden
        } else if (winw > screenw / 2) {
            ; MsgBox("go_left: Resize to " screenw / 2)
            WinMove(, , screenw / 2,) ; resize to half
        } else if (winh < screenh) {
            ; MsgBox("go_left: Maximize vertically to " screenh)
            WinMove(, screeny, , screenh) ; maximize vertically
        } else {
            leftmon := get_side_monitor(mon, "left")
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
    mon := get_win_monitor(WinGetID())
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
            rightmon := get_side_monitor(mon, "right")
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
    WinWait "A"
    WinGetPos(&winx, &winy, &winw, &winh)
    winx2 := winx + winw
    winy2 := winy + winh
    mon := get_win_monitor(WinGetID())
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        screenh := screeny2 - screeny
        MsgBox("TODO go_up")
        ; TODO
    }
}

go_down() {
    WinWait "A"
    WinGetPos(&winx, &winy, &winw, &winh)
    winx2 := winx + winw
    winy2 := winy + winh
    mon := get_win_monitor(WinGetID())
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        screenh := screeny2 - screeny
        MsgBox("TODO go_down")
        ; TODO
    }
}

go_full() {
    ; https://www.autohotkey.com/docs/v2/lib/WinMaximize.htm
    ; https://www.autohotkey.com/docs/v2/lib/WinRestore.htm
    WinWait "A"
    WinGetPos(&winx, &winy, &winw, &winh)
    mon := get_win_monitor(WinGetID())
    if (mon >= 0) {
        MonitorGetWorkArea(mon, &screenx, &screeny, &screenx2, &screeny2)
        screenw := screenx2 - screenx
        ; MsgBox("winw: " winw ", screenw:" screenw)
        if (winw < screenw ) {
            WinMaximize("A")
        } else {
            WinRestore("A")
        }
    }
}

switch_window(direction) {
    ; https://www.autohotkey.com/docs/v2/lib/WinGetList.htm
    ; MsgBox("switch_window " direction)
    activeid := WinGetID("A")
    winids := WinGetList(, , "Program Manager")
    cleaned := drop_unnamed_wins(winids)
    sortedids := array_sort(cleaned)
    ; MsgBox("current: " activeid)
    ; get_win_info(sortedids)
    shift := 1
    if (direction == "left") {
        shift := -1
    }
    for (id, winid in sortedids) {
        if (winid == activeid) {
            targetid := id + shift
            if (targetid < 1) { ; array index starts at 1
                targetid := sortedids.Length
            } else if (targetid >= sortedids.Length) {
                targetid := 1
            }
            WinActivate { Hwnd: sortedids[targetid] }
            break
        }
    }
}

drop_unnamed_wins(winids) {
    ; https://www.autohotkey.com/docs/v2/lib/WinGetTitle.htm
    clean := []
    for (id, winid in winids) {
        t := WinGetTitle({ Hwnd: winid })
        if (t != "") {
            clean.push(winid)
        }
    }
    return clean
}

get_win_info(winids) {
    s := ""
    for (id, winid in winids) {
        s := s ", " WinGetTitle({ Hwnd: winid })
    }
    MsgBox(s)
    return s
}

;=========================================
;============== array utils ==============
;=========================================

array_get_min_id(a) {
    mid := 1 ; array index starts at 1
    mval := a[mid]
    for (index, val in a) {
        if (val < mval) {
            mval := val
            mid := index
        }
    }
    return mid
}

array_sort(a) {
    copy := a.Clone()
    sorted := []
    while (copy.Length > 0) {
        mid := array_get_min_id(copy)
        sorted.push(copy[mid])
        copy.RemoveAt(mid)
    }
    return sorted
}


;===========================================
;============== monitor utils ==============
;===========================================

get_side_monitor(monindex, direction) {
    MonitorGet(monindex, &monx, &mony, &monx2, &mony2)
    ; MsgBox("get_side_monitor(" direction ") : " monindex ", " MonitorGetName(monindex) " info: x:" monx ", y:" mony ", x2:" monx2 ", y2:" mony2)
    MonitorCount := MonitorGetCount()
    Loop MonitorCount {
        if (A_Index != monindex) {
            MonitorGet(A_Index, &sidemonx, &sidemony, &sidemonx2, &sidemony2)
            ; MsgBox("get_side_monitor(" direction ") : " A_Index ", " MonitorGetName(A_Index) " info: x:" sidemonx ", y:" sidemony ", x2:" sidemonx2 ", y2:" sidemony2)
            ;MonitorGetWorkArea(A_Index, &wax, &way, &wax2, &way2)
            if (direction == "left" and sidemonx2 < monx) {
                ; MsgBox("get_side_monitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "right" and sidemonx > monx2) {
                ; MsgBox("get_side_monitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "up" and sidemony2 < mony) {
                ; MsgBox("get_side_monitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            } else if (direction == "down" and sidemony > mony) {
                ; MsgBox("get_side_monitor(" direction ") : " A_Index ", " MonitorGetName(A_Index))
                return A_Index
            }
        }
    }
    ; MsgBox("get_side_monitor(" direction ") not found, returning -1")
    return -1
}

get_win_monitor(winid) {
    ; https://www.autohotkey.com/docs/v2/lib/WinGetPos.htm
    WinGetPos(&winx, &winy, &winw, &winh, { Hwnd: winid })
    x := winx + winw / 2
    y :=  winy + winh / 2
    MonitorCount := MonitorGetCount()
    Loop MonitorCount {
        ; MonitorGet(A_Index, &monx, &mony, &monx2, &mony2)
        MonitorGetWorkArea(A_Index, &wax, &way, &wax2, &way2)
        if (x >= wax and x <= wax2 and y >= way and y <= way2) {
            return A_Index
        }
    }
    MsgBox("get_win_monitor(" winid ") not found, returning -1")
    return -1
}

; MsgBox "Reloaded!"
