#!/system/bin/sh
# 统一配置 —— 改完重新运行 scripts/01_install.bat 推送到车机

# 视频保存目录
DIR=/sdcard/p5dashcam/videos

# 保留最近几段（防止写满车机存储）
KEEP=10

# 每段时长（秒），screenrecord 上限 180
DURATION=170

# 码率 bps，画质与体积的平衡，6M 约每分钟 45MB
BITRATE=6000000

# ---- 方案 A（模拟点击）专用 ----
# 原生相册路径：先用 00_probe.bat 探测实际路径，常见 /sdcard/DCIM/Camera
ALBUM=/sdcard/DCIM/Camera
# 录像按钮坐标：用 uiautomator dump 获取，未设置则方案 A 拒绝启动
TAP_X=0
TAP_Y=0
REC_SECONDS=285
GAP=2
