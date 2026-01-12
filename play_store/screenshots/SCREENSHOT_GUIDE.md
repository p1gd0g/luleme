# 截图指南

本指南帮助创建高质量的 Google Play 商店截图。

## 截图要求

### 手机截图
- **数量**：至少2张，建议6-8张
- **尺寸**：
  - 推荐：1080x1920（9:16）或 1080x2340（9:19.5）
  - 最小：320px
  - 最大：3840px
  - 最大宽高比：2:1
- **格式**：PNG或JPG
- **质量**：高清，无模糊

## 建议截图列表

### 1. 主页面（首屏）
**文件名**: `01_home_screen.png`

**展示内容**：
- 应用标题和顶部栏
- 快速记录按钮（Hero Section）
- 统计概览卡片（周、月、总计、统计入口）
- 部分导航按钮

**重点突出**：
- 快速记录功能的便捷性
- 统计数据的清晰展示
- Material Design 3 美观设计

### 2. 记录对话框
**文件名**: `02_record_dialog.png`

**展示内容**：
- 打开的记录对话框
- 备注输入框
- 感受评分星星
- 保存和取消按钮

**重点突出**：
- 简单易用的记录界面
- 可选的备注和评分功能

### 3. 统计页面 - 周趋势
**文件名**: `03_statistics_week.png`

**展示内容**：
- 顶部统计卡片（周、月、总计）
- 最近7天趋势柱状图
- 图表互动提示

**重点突出**：
- 直观的数据可视化
- 清晰的趋势展示
- 每日数据对比

### 4. 统计页面 - 月统计
**文件名**: `04_statistics_month.png`

**展示内容**：
- 月度统计柱状图（按周）
- 健康洞察卡片
- 不同状态的健康提示

**重点突出**：
- 月度数据汇总
- 智能健康评估
- 专业的健康建议

### 5. 健康建议页面（上部）
**文件名**: `05_advice_top.png`

**展示内容**：
- 渐变背景头部
- "健康生活指南"标题
- 前3个建议卡片（保持适度、规律作息、健康饮食）

**重点突出**：
- 专业的健康建议
- 精美的卡片设计
- 不同颜色主题

### 6. 健康建议页面（下部）
**文件名**: `06_advice_bottom.png`

**展示内容**：
- 后3个建议卡片（适度运动、心理健康、私密保护）
- 注意事项警告区域
- 更多资源信息

**重点突出**：
- 全面的健康指导
- 重要的注意事项
- 完整的功能展示

### 7. 最近记录列表
**文件名**: `07_recent_records.png`

**展示内容**：
- 主页面滚动到最近记录区域
- 显示多条历史记录
- 记录的时间、备注
- 删除操作按钮

**重点突出**：
- 清晰的历史记录
- 易于管理的数据
- 用户友好的界面

### 8. 统计卡片总览
**文件名**: `08_stats_overview.png`

**展示内容**：
- 主页面的统计卡片特写
- 四张统计卡片完整展示
- 数据的直观呈现

**重点突出**：
- 多维度统计
- 一目了然的数据
- 美观的卡片设计

## 截图拍摄技巧

### 1. 准备测试数据
在拍摄前，确保应用中有足够的测试数据：
- 添加多条记录（不同日期）
- 确保有本周和本月的数据
- 让图表有数据显示

### 2. 选择合适的主题
- 优先展示浅色主题（更明亮）
- 或展示深色主题（更现代）
- 保持所有截图主题一致

### 3. 截图时机
- 选择数据完整的界面状态
- 避免空白或错误状态
- 确保所有元素正确加载

### 4. 使用模拟器还是真机
- **模拟器优势**：
  - 标准化的屏幕尺寸
  - 容易控制截图质量
  - 可以配置理想的系统UI
  
- **真机优势**：
  - 真实的显示效果
  - 更准确的色彩
  - 实际的性能表现

推荐使用：**Pixel 5 模拟器**（1080x2340）

### 5. 清理界面
- 隐藏调试信息
- 使用发布版本
- 清理通知栏
- 确保系统时间合理

## 截图流程

### 方法1：使用模拟器（推荐）

```bash
# 1. 启动指定尺寸的模拟器
flutter emulators --launch pixel_5

# 2. 运行应用（release模式）
flutter run --release

# 3. 在模拟器中操作到目标界面

# 4. 截图
# - macOS: Cmd+S
# - Windows/Linux: Ctrl+S
# 或使用模拟器工具栏的相机图标

# 5. 截图保存位置：
# - macOS: ~/Desktop
# - Windows: C:\Users\<用户名>\Desktop
```

### 方法2：使用真实设备

```bash
# 1. 连接设备
adb devices

# 2. 运行应用
flutter run --release

# 3. 使用设备截图
# Android: 电源键 + 音量下键

# 4. 从设备导出截图
adb pull /sdcard/Pictures/Screenshots/<filename>.png ./
```

### 方法3：使用 ADB 命令

```bash
# 在应用运行时，使用 adb 截图
adb shell screencap -p /sdcard/screenshot.png
adb pull /sdcard/screenshot.png ./screenshots/phone/
adb shell rm /sdcard/screenshot.png
```

## 截图后处理

### 调整尺寸
如果截图尺寸不符合要求，可以使用工具调整：

```bash
# 使用 ImageMagick
convert input.png -resize 1080x1920\! output.png
```

### 添加边框（可选）
为截图添加设备边框，使其更美观：

- 使用在线工具：
  - [Device Art Generator](https://developer.android.com/distribute/marketing-tools/device-art-generator)
  - [MockUPhone](https://mockuphone.com/)
  - [Smartmockups](https://smartmockups.com/)

### 压缩优化
减小文件大小，但保持质量：

```bash
# 使用 pngquant
pngquant --quality=80-95 screenshot.png

# 或使用在线工具
# - TinyPNG.com
# - Squoosh.app
```

## 截图检查清单

在提交截图前，确保：

- [ ] 所有截图尺寸一致
- [ ] 截图清晰，无模糊
- [ ] 截图展示应用的真实状态
- [ ] 没有敏感信息（如个人数据）
- [ ] 截图内容符合 Google Play 政策
- [ ] 文件名清晰有序
- [ ] 截图顺序讲述应用使用故事
- [ ] 所有截图使用相同主题（浅色或深色）

## 注意事项

1. **隐私保护**：确保截图中不包含真实的个人数据
2. **真实性**：展示应用的真实功能，不夸大
3. **一致性**：保持所有截图的视觉风格一致
4. **时效性**：更新应用后及时更新截图
5. **本地化**：如果支持多语言，准备对应语言的截图

## 高级技巧

### 自动化截图
可以使用 Flutter 集成测试自动生成截图：

```dart
// 使用 integration_test 包
testWidgets('Screenshot home screen', (tester) async {
  await tester.pumpWidget(MyApp());
  await tester.pumpAndSettle();
  
  // 截图代码
  await takeScreenshot(tester, 'home_screen');
});
```

### 添加文字说明
在截图上添加简短的功能说明（可选）：
- 使用图片编辑软件
- 保持文字简洁
- 确保文字清晰可读
- 不要遮挡重要内容

## 示例命名规范

```
screenshots/phone/
├── zh-CN/
│   ├── 01_home_screen.png
│   ├── 02_record_dialog.png
│   ├── 03_statistics_week.png
│   ├── 04_statistics_month.png
│   ├── 05_advice_top.png
│   ├── 06_advice_bottom.png
│   ├── 07_recent_records.png
│   └── 08_stats_overview.png
└── en-US/ (如需要)
    └── ...
```

## 参考资源

- [Google Play 截图指南](https://support.google.com/googleplay/android-developer/answer/9866151)
- [Material Design 截图最佳实践](https://material.io/design/communication/imagery.html)
- [Android 开发者设备艺术生成器](https://developer.android.com/distribute/marketing-tools/device-art-generator)
