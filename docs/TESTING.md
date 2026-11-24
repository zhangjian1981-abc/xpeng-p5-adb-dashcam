# 测试清单

本项目高度依赖真车验证。请按下列清单测试，并在 Issue / PR 里报告结果。

## 环境信息（每次报告都请提供）

- 车型年款 / 提车时间
- Xmart OS 版本（设置 → 关于本机）
- ADB 开启方式（官方开发者选项 / hackXpeng / 售后维修模式）
- ADB 连接方式与端口（无线 IP:端口，脱敏处理）
- 屏幕分辨率（`adb shell wm size`）
- 剩余存储（`adb shell df -h /sdcard`）
- `screenrecord` 是否存在（`adb shell which screenrecord`）

## 基础连通性

- [ ] `adb devices` 能看到车机
- [ ] `adb shell wm size` 返回正常分辨率
- [ ] `adb shell which screenrecord` 有输出
- [ ] 确认存储剩余空间 ≥ 2GB

## 360 影像常驻（关键前提）

- [ ] 停车状态能打开 360 影像全屏
- [ ] 行驶中界面不会自动退出；若会退出，记录触发条件（车速阈值 / 换挡 / 计时）
- [ ] 「换挡时保持影像」设置项是否可用、在哪里

## 方案 B：screenrecord 循环

- [ ] 运行 `02_start.bat` 后 `run.log` 出现 `START` 与 `REC`
- [ ] 3 分钟后 `videos/` 出现 `.mp4` 文件
- [ ] `adb pull` 取回的视频能播放、画面确为 360 影像
- [ ] 连续录 4 段以上，`KEEP` 生效，旧文件被删除
- [ ] 期间车机无卡顿、无重启
- [ ] `03_stop.bat` 能正常停止，日志出现 `STOPPED`

## 方案 A：模拟点击

- [ ] `uiautomator dump` 能拿到界面 XML
- [ ] 找到录像按钮坐标并填入 `config.sh`
- [ ] 单次点击确实触发录像，相册出现新文件
- [ ] 定时点击能连续录多段
- [ ] 相册路径填写正确，旧文件被删除
- [ ] 未出现误触（点到导航、音乐等）

## 长期运行

- [ ] 用 MacroDroid / 自动任务设置开机触发，`sh /sdcard/p5dashcam/screenrecord_loop.sh` 能自启
- [ ] 车机重启后视频目录仍在、脚本可再次启动
- [ ] OTA 升级后 ADB 是否仍可用

## 报告格式

在 Issue 里按此结构写：

```
环境：P5 2022款 / Xmart OS 3.5.0 / hackXpeng / 1080x1920 / 剩余 24GB
方案：B
结果：基础连通 OK；360 在车速 > 40km/h 时自动退出（问题）
日志：[贴 run.log 关键片段]
建议：可尝试用 X 键保持常驻，或缩短 DURATION
```
