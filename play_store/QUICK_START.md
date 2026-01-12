# 快速开始指南

本文档提供最精简的步骤，快速开始 Google Play 发布流程。

## 🚀 3 步快速开始

### 步骤 1: 生成截图（15-30分钟）

```bash
# 启动模拟器
flutter emulators --launch pixel_5

# 运行应用
flutter run --release

# 截图（在模拟器中按 Cmd+S 或 Ctrl+S）
# 至少截 2 张，建议 6-8 张
```

保存到：`play_store/screenshots/phone/`

详细说明：[截图指南](./screenshots/SCREENSHOT_GUIDE.md)

### 步骤 2: 创建功能图片（15-30分钟）

使用 [Canva](https://www.canva.com/)：
1. 创建 1024x500 像素画布
2. 添加深紫色渐变背景
3. 添加应用名称："撸了么"
4. 添加标语："私密的个人健康追踪"
5. 导出为 PNG

保存到：`play_store/graphics/feature_graphic.png`

详细说明：[功能图片指南](./graphics/FEATURE_GRAPHIC_GUIDE.md)

### 步骤 3: 配置签名（10分钟）

```bash
# 1. 生成密钥库
keytool -genkey -v -keystore ~/luleme-upload-key.jks \
  -storetype JKS -keyalg RSA -keysize 4096 -validity 10000 \
  -alias luleme

# 2. 创建 android/key.properties
# （根据 SIGNING_GUIDE.md 配置）

# 3. 构建发布版本
flutter build appbundle --release
```

详细说明：[签名指南](./SIGNING_GUIDE.md)

## ✅ 完成后

构建产物将在：
- `build/app/outputs/bundle/release/app-release.aab`

准备上传到 Google Play Console！

## 📋 完整流程

需要完整的发布检查清单？查看：
- [发布检查清单](./PUBLISHING_CHECKLIST.md) - 200+ 项详细检查

## 🆘 需要帮助？

- [总结文档](./SUMMARY.md) - 所有已完成和待完成工作的总览
- [主 README](./README.md) - Play Store 材料完整说明
- [项目 GitHub](https://github.com/p1gd0g/luleme) - 提交 Issue

---

**预计总时间**: 1-2 小时（首次发布）
