# MYOWM-AutoHotkey

## My Own Windows Mover

An [AutoHotkey](https://www.autohotkey.com/) script to snap and move windows with hotkeys, inspired by [rectangle](https://rectangleapp.com/). 

See also [MYOWM.spoon](https://github.com/kyrlian/MYOWM.spoon) to use on mac with [hammerspoon](https://www.hammerspoon.org/).

It uses the current position & size of the window to decide how to move/resize it.

For exemple the 'left' move will:
- snap the windows left, keeping the right border in place - hence widening the windows
- if already snapped left, will resize to half screen width
- if already snapped left and less of half screen width, will snap to top and maximize vertically
- if all the above, will move to next screen on the left

## Install

- Get [AutoHotkey](https://www.autohotkey.com/)

- Clone:

```sh
git clone https://github.com/kyrlian/MYOWM-AutoHotkey
```

- Create a shortcut to `myowm.ahk` in windows startup directory 
`%appdata%\Microsoft\Windows\Start Menu\Programs\Startup`
to run at startup

## Additional stuff

- [win-remap.ahk](./win-remap.ahk) remaps `Win+C` and `Win+V` to `Ctrl+C` and `Ctrl+V`
- [all.ahk](./all.ahk) just loads both `myowm.ahk` and `win-remap.ahk`