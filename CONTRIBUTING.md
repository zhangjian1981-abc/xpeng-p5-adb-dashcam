# 贡献指南

感谢参与！这个项目最缺的是**真车实测数据**——纸面推论很容易错，不同车机版本差异也大。

## 你可以做什么

1. **提交兼容性报告**：你的车型年份、Xmart OS 版本、ADB 开启方式、屏幕分辨率、剩余存储、方案是否跑通。用 GitHub Issue 的 "Compatibility report" 模板。
2. **提交失败现场**：跑 `00_probe.bat` 把 `probe_result.txt` 贴到 Issue 里（注意脱敏 IP 等个人信息）。
3. **改进脚本**：更稳的循环覆盖、更低功耗的参数、碰撞事件触发、自动上传等。
4. **补充文档**：不同系统版本的 360 界面差异、保持影像常驻的设置路径。

## 开发前必读

- 本项目只针对**已自行开通 ADB** 的车机，不提供破解教程，也不鼓励绕过车辆安全机制。
- 任何改动都不得影响驾驶安全。测试请在停车状态或副驾协助下进行。
- 不要在脚本中写入个人 IP、车牌、VIN 等信息。

## 提交流程

1. Fork 仓库，建分支：`git checkout -b feature/your-idea`
2. 改动脚本后，至少在本机或车机上验证一次
3. 提交信息简洁明了：`git commit -m "fix: keep latest N clips on low storage"`
4. Push 并开 Pull Request，说明测试环境和结果

## 代码约定

- 车机端脚本用 `/system/bin/sh`，避免 bash 专属语法（Android 上是 toybox）
- 参数放 `config.sh`，不要硬编码在逻辑里
- 新增功能请同步更新 README 的参数表
- 中文文档为主，关键注释可中英双语

## 测试清单

见 [docs/TESTING.md](docs/TESTING.md)。至少完成"基础连通性 + 单段录制 + 循环覆盖验证"三项再提交 PR。
