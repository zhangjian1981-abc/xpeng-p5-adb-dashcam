#!/system/bin/sh
# 方案 B：循环录屏 + 自动删旧
# 依赖：ADB 已连接、360 影像全屏常驻、屏幕常亮

BASE=/sdcard/p5dashcam
. "$BASE/config.sh"

mkdir -p "$DIR"
echo "[$(date)] START dir=$DIR keep=$KEEP dur=$DURATION bitrate=$BITRATE" >> "$BASE/run.log"

i=0
while [ ! -f "$BASE/STOP" ]; do
  TS=$(date +%Y%m%d_%H%M%S)
  OUT="$DIR/$TS.mp4"
  echo "[$(date)] REC $OUT" >> "$BASE/run.log"
  screenrecord --time-limit "$DURATION" --bit-rate "$BITRATE" "$OUT"
  echo "[$(date)] DONE $OUT" >> "$BASE/run.log"

  # 只保留最近 KEEP 段：按时间倒序，删掉第 KEEP+1 个及之后的
  COUNT=$(ls -1 "$DIR"/*.mp4 2>/dev/null | wc -l)
  if [ "$COUNT" -gt "$KEEP" ]; then
    ls -t "$DIR"/*.mp4 2>/dev/null | tail -n +$((KEEP+1)) | xargs rm -f 2>/dev/null
  fi
  i=$((i+1))
  sleep 1
done

rm -f "$BASE/STOP"
echo "[$(date)] STOPPED after $i clips" >> "$BASE/run.log"
