# 手机截图

请在此目录放置手机截图。

## 要求
- 至少 2 张
- 建议 6-8 张
- 推荐尺寸：1080x1920 或 1080x2340
- 格式：PNG 或 JPG

## 建议截图内容

1. `01_home_screen.png` - 主页面
2. `02_record_dialog.png` - 记录对话框
3. `03_statistics_week.png` - 周统计图
4. `04_statistics_month.png` - 月统计图
5. `05_advice_top.png` - 健康建议页面（上部）
6. `06_advice_bottom.png` - 健康建议页面（下部）
7. `07_recent_records.png` - 最近记录列表
8. `08_stats_overview.png` - 统计卡片总览

## 如何生成

参考 `SCREENSHOT_GUIDE.md` 获取详细说明。

快速步骤：
```bash
# 启动模拟器
flutter emulators --launch <emulator_id>

# 运行应用（release 模式）
flutter run --release

# 在模拟器中截图（Ctrl+S 或 Cmd+S）
```
