@echo off
chcp 65001 >nul
set ROOT=%~dp0..
set BASE=/sdcard/p5dashcam

adb shell "mkdir -p %BASE%/videos"
adb push "%ROOT%\config.sh" "%BASE%/config.sh"
adb push "%ROOT%\scripts\screenrecord_loop.sh" "%BASE%/screenrecord_loop.sh"
adb push "%ROOT%\scripts\tap_loop.sh" "%BASE%/tap_loop.sh"
adb shell "chmod 755 %BASE%/config.sh %BASE%/screenrecord_loop.sh %BASE%/tap_loop.sh"
echo.
echo Installed to %BASE%
echo Next: edit config.sh then run 02_start.bat
pause
