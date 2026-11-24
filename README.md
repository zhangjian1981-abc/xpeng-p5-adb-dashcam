# XPeng P5 ADB Dashcam

中文 | [English](README_EN.md)

用已开通 ADB 的小鹏 P5 车机，把 360 影像显示在屏幕上并循环录制、自动覆盖旧片段。这是一个社区驱动的实验性项目，不是小鹏官方功能。

> 一句话：ADB 让车机能跑 shell，于是可以用系统自带的 `screenrecord` 循环录屏 + 脚本自动删旧文件，绕开原生相册"不自动循环覆盖"的限制。

## 为什么需要它

P5 的十几个摄像头在行驶中只为辅助驾驶和 360 影像显示服务，不会写入存储；360 界面虽然能手动录一段（最长 5 分钟），但**录完即停、不循环、不覆盖**。本项目的目标是用软件方式补上"循环录像"这一环。

详细技术背景见 [docs/BACKGROUND.md](docs/BACKGROUND.md)。

## 两种方案

| | 方案 B：`screenrecord` 循环录屏（推荐） | 方案 A：模拟点击原生录像键 |
|---|---|---|
| 录制内容 | 屏幕上显示的 360 画面，含车机 UI、竖屏 | 摄像头原生录像，画面干净 |
| 单段时长 | 上限 180 秒，脚本自动续接 | 上限 5 分钟，需定时点击 |
| 循环覆盖 | 脚本自动删旧，完全可控 | 需删相册文件，路径要先探测 |
| 稳定性 | 高，纯脚本 | 较低，360 界面一退出就点错 |
| 代价 | 中控屏被占、耗电发热、无碰撞锁定 | 同上，且误触风险更高 |

两者都**不是真正的行车记录仪**：没有碰撞自动锁定、没有 G-sensor 触发、取证效力弱。关键事故证据仍建议外接专车专用记录仪。

## 前置条件

- 小鹏 P5，车机**已开通 ADB**（早期漏洞机型，通常为 Xmart OS 3.5.0 及以前）
- 电脑与车机在同一 WiFi，能 `adb connect <车机IP>:<端口>`（端口常见 5555 / 5050，以实际为准）
- 电脑已安装 `adb`（Android platform-tools）并加入 PATH
- 车机上能打开 360 影像全屏，且行驶中不会自动退出

## 快速开始

```bat
:: 1. 探测环境，确认 adb / screenrecord / 分辨率 / 存储
scripts\00_probe.bat

:: 2. 按探测结果编辑 config.sh（保留段数、时长、码率等）

:: 3. 推送脚本到车机
scripts\01_install.bat

:: 4. 车机打开 360 影像全屏，然后启动循环录屏
scripts\02_start.bat

:: 5. 停止
scripts\03_stop.bat
```

视频保存在车机 `/sdcard/p5dashcam/videos/`，取回：

```bat
adb pull /sdcard/p5dashcam/videos ./videos
```

查看日志：`adb shell tail -f /sdcard/p5dashcam/run.log`

## 配置项

所有参数集中在 `config.sh`，改完重新执行 `01_install.bat` 推送即可：

| 变量 | 含义 | 默认 |
|---|---|---|
| `DIR` | 视频保存目录 | `/sdcard/p5dashcam/videos` |
| `KEEP` | 保留最近几段 | `10` |
| `DURATION` | 每段秒数（≤180） | `170` |
| `BITRATE` | 码率 bps | `6000000` |
| `ALBUM` | 原生相册路径（方案 A 用） | `/sdcard/DCIM/Camera` |
| `TAP_X` / `TAP_Y` | 录像按钮坐标（方案 A 用） | `0` |

## 长期运行

`adb shell ... &` 起的后台进程在车机重启或 ADB 断开后可能消失。要"上车就录"，建议用车机上已装的 **MacroDroid / 自动任务** 设置触发器（开机完成 / 蓝牙连接手机）执行：

```
sh /sdcard/p5dashcam/screenrecord_loop.sh
```

## 参与开发

这个项目需要真车验证：不同系统版本、分辨率、存储空间下的表现差异很大。欢迎提交测试报告、适配补丁和新方案。详见 [CONTRIBUTING.md](CONTRIBUTING.md) 与 [docs/TESTING.md](docs/TESTING.md)。

## 安全声明

- 行驶中让中控屏常驻 360 影像会遮挡导航、分散注意力。请在停车时设置，行驶中不要手动操作。
- 长时间亮屏 + 持续编码会增加耗电和发热。
- 录像涉及车内对话、路人车牌等他人隐私，请勿随意传播或商用。
- 本项目与小鹏汽车无关，任何改装都可能影响质保，使用者自行承担风险。

## License

[MIT](LICENSE)
