# Google Play 发布材料

本目录包含用于 Google Play 商店发布的所有必要材料和资源。

## 目录结构

```
play_store/
├── metadata/              # 商店列表元数据
│   ├── title.txt         # 应用标题
│   ├── short_description.txt  # 简短描述（80字符）
│   ├── full_description.txt   # 完整描述（4000字符）
│   ├── release_notes.txt      # 版本发布说明
│   ├── privacy_policy.md      # 隐私政策
│   ├── content_rating.md      # 内容分级信息
│   └── store_listing_details.md  # 商店列表详细信息
├── screenshots/           # 应用截图
│   ├── phone/            # 手机截图（至少2张）
│   ├── tablet/           # 平板截图（可选）
│   └── wear/             # 穿戴设备截图（可选）
└── graphics/             # 图形资源
    ├── feature_graphic/  # 功能图片（1024x500）
    ├── icon/             # 高分辨率图标（512x512）
    └── promo/            # 宣传图片（可选）
```

## 已完成项目

- ✅ 应用标题
- ✅ 简短描述
- ✅ 完整描述  
- ✅ 版本发布说明
- ✅ 隐私政策文档
- ✅ 内容分级信息
- ✅ 商店列表详细规划
- ✅ 应用图标（位于 `assets/icon/`）

## 待完成项目

### 必需项
- [ ] **功能图片** (1024x500 像素)
  - 展示应用主要功能
  - JPG或24位PNG格式
  - 建议包含：应用截图 + 品牌元素 + 标语

- [ ] **手机截图** (至少2张，建议8张)
  - 推荐尺寸：1080x1920 或 1080x2340
  - 建议截图内容：
    1. 主页面 - 展示快速记录功能
    2. 统计页面 - 展示周趋势图
    3. 统计页面 - 展示月统计
    4. 健康建议页面
    5. 记录对话框
    6. 统计卡片总览
    7. 最近记录列表
    8. 健康洞察

- [ ] **应用配置更新**
  - 更改 applicationId（从 com.example.myapp）
  - 配置签名密钥
  - 更新版本信息

- [ ] **构建发布版本**
  - 生成签名的 AAB（推荐）或 APK
  - 测试发布版本

### 可选项
- [ ] 宣传视频
- [ ] 平板截图
- [ ] Wear OS 截图

## 如何生成截图

### 方法1：使用模拟器

```bash
# 启动模拟器
flutter emulators --launch <emulator_id>

# 运行应用
flutter run

# 在模拟器中截图（Ctrl+S 或通过工具栏）
```

### 方法2：使用真实设备

```bash
# 连接设备并运行
flutter run

# 使用设备截图功能
# Android: 电源键 + 音量下键
```

### 方法3：使用 Flutter 截图工具

可以使用 `screenshot` 包或自定义工具自动生成截图。

## 如何创建功能图片

功能图片是用户在 Google Play 商店看到的第一个视觉元素。建议包含：

1. **应用截图**：展示主要界面
2. **品牌元素**：应用图标、名称
3. **标语**：突出核心价值（如"完全私密的健康追踪"）
4. **视觉设计**：与应用主题一致的配色

工具推荐：
- Figma（在线设计）
- Canva（模板丰富）
- Adobe Photoshop
- GIMP（开源免费）

## 应用配置更新

### 1. 更新 Package Name

编辑 `android/app/build.gradle.kts`：

```kotlin
defaultConfig {
    applicationId = "com.p1gd0g.luleme"  // 改为实际的包名
    // ...
}
```

### 2. 配置签名

创建 `android/key.properties`：

```properties
storePassword=<密码>
keyPassword=<密码>
keyAlias=<别名>
storeFile=<密钥库文件路径>
```

然后在 `android/app/build.gradle.kts` 中配置签名。

### 3. 构建发布版本

```bash
# 构建 AAB（推荐用于 Google Play）
flutter build appbundle --release

# 或构建 APK
flutter build apk --release
```

## 发布流程

1. **准备材料**
   - 完成所有必需的图形资源
   - 确保应用配置正确
   - 构建签名的发布版本

2. **Google Play Console**
   - 登录 Google Play Console
   - 创建应用
   - 上传 AAB/APK
   - 填写商店列表信息
   - 完成内容分级问卷
   - 设置定价和分发

3. **测试**
   - 内部测试
   - 封闭测试
   - 开放测试（可选）

4. **正式发布**
   - 审核通过后发布
   - 监控用户反馈
   - 及时更新维护

## 注意事项

1. **隐私政策**：已包含完整的隐私政策，强调本地存储和隐私保护
2. **内容分级**：建议18+，因涉及性健康教育内容
3. **年龄限制**：在商店列表中明确标注使用年龄要求
4. **持续更新**：定期更新发布说明和截图以反映新功能

## 参考资源

- [Google Play Console 帮助](https://support.google.com/googleplay/android-developer)
- [应用审核准则](https://support.google.com/googleplay/android-developer/answer/9904549)
- [图形资源规范](https://support.google.com/googleplay/android-developer/answer/9866151)
- [内容分级指南](https://support.google.com/googleplay/android-developer/answer/9898843)

## 联系方式

如有问题，请通过 GitHub Issues 联系：
https://github.com/p1gd0g/luleme/issues
