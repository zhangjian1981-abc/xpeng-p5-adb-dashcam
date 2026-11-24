#!/system/bin/sh
# 方案 A：定时模拟点击原生录像键 + 删相册旧文件
# 风险：360 界面一旦退出，点击会误触其他应用；稳定性低于方案 B

BASE=/sdcard/p5dashcam
. "$BASE/config.sh"

if [ "$TAP_X" = "0" ] || [ "$TAP_Y" = "0" ]; then
  echo "ERROR: TAP_X / TAP_Y not set. Use uiautomator dump to find record button."
  exit 1
fi

mkdir -p "$BASE"
rm -f "$BASE/STOP"

while [ ! -f "$BASE/STOP" ]; do
  input tap "$TAP_X" "$TAP_Y"
  sleep "$REC_SECONDS"
  input tap "$TAP_X" "$TAP_Y"
  sleep "$GAP"
  COUNT=$(ls -1 "$ALBUM"/*.mp4 2>/dev/null | wc -l)
  if [ "$COUNT" -gt "$KEEP" ]; then
    ls -t "$ALBUM"/*.mp4 2>/dev/null | tail -n +$((KEEP+1)) | xargs rm -f 2>/dev/null
  fi
done
