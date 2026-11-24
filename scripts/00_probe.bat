@echo off
chcp 65001 >nul
set OUT=%~dp0probe_result.txt
(
echo ===== P5 ADB Dashcam probe %date% %time% =====
echo.
echo [1] adb devices
adb devices
echo.
echo [2] Android version
adb shell getprop ro.build.version.release
echo.
echo [3] screenrecord binary
adb shell which screenrecord
echo.
echo [4] screen size / density
adb shell wm size
adb shell wm density
echo.
echo [5] free space
adb shell df -h /sdcard
echo.
echo [6] camera related packages
adb shell pm list packages | findstr /i "camera xpeng 360"
echo.
echo [7] current focused activity
adb shell dumpsys window | findstr /i "mCurrentFocus"
echo.
echo [8] existing mp4 files
adb shell find /sdcard -name "*.mp4" -type f 2>nul
echo.
echo ===== done =====
) > "%OUT%"
type "%OUT%"
echo.
echo Result saved to: %OUT%
pause
