@echo off
chcp 65001 >nul
set BASE=/sdcard/p5dashcam

echo 请先在车机上打开 360 影像全屏，确认界面不会自动退出。
echo 准备好后按任意键开始循环录屏...
pause >nul
adb shell "rm -f %BASE%/STOP"
adb shell "nohup sh %BASE%/screenrecord_loop.sh >%BASE%/console.log 2>&1 &"
echo.
echo Started. Log: adb shell tail -f %BASE%/run.log
echo Stop: run 03_stop.bat
pause
