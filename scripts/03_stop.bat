@echo off
chcp 65001 >nul
set BASE=/sdcard/p5dashcam
adb shell "mkdir -p %BASE%"
adb shell "touch %BASE%/STOP"
adb shell "pkill screenrecord"
echo.
echo Stop signal sent. The script exits after current clip finishes.
echo Pull videos: adb pull %BASE%/videos ./videos
pause
