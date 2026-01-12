# Google Play 发布检查清单

使用此清单确保在发布到 Google Play 之前完成所有必要的准备工作。

## 📋 准备阶段

### 代码和配置
- [x] 应用标题已更新为"撸了么"
- [x] Package name 已从 `com.example.myapp` 改为 `com.p1gd0g.luleme`
- [x] AndroidManifest.xml 中的 android:label 已更新
- [x] pubspec.yaml 中的版本号正确（当前：1.0.0+1）
- [ ] 已配置签名密钥（参考 `SIGNING_GUIDE.md`）
- [ ] 已测试发布版本 APK/AAB
- [ ] 已删除或注释调试代码和日志
- [ ] 已验证所有功能正常工作

### 图形资源
- [x] 应用图标已准备（512x512 PNG）- 位于 `assets/icon/`
- [x] 自适应图标已配置（前景和背景）
- [ ] 功能图片已创建（1024x500）- 参考 `graphics/FEATURE_GRAPHIC_GUIDE.md`
- [ ] 至少 2 张手机截图已准备 - 参考 `screenshots/SCREENSHOT_GUIDE.md`
- [ ] 截图展示应用的核心功能
- [ ] 所有图片符合 Google Play 规格要求

### 文本内容
- [x] 应用标题（30字符以内）
- [x] 简短描述（80字符以内）
- [x] 完整描述（4000字符以内）
- [x] 版本发布说明
- [x] 隐私政策文档
- [x] 内容分级信息已准备

## 🔒 隐私和安全

### 隐私政策
- [x] 隐私政策已创建（`metadata/privacy_policy.md`）
- [ ] 隐私政策已发布到可访问的 URL
  - 建议：发布到 GitHub Pages
  - 或：托管到自己的服务器
- [x] 隐私政策说明数据收集情况（本应用：不收集任何数据）
- [x] 隐私政策说明数据存储方式（本应用：仅本地存储）

### 权限
- [x] 已审查应用所需权限
- [x] AndroidManifest.xml 中没有不必要的权限
- [x] 本应用不需要网络权限
- [x] 本应用不需要定位权限
- [x] 不收集个人信息

### 安全性
- [ ] 已使用 ProGuard/R8 进行代码混淆（可选）
- [ ] 已测试发布版本的安全性
- [ ] 没有硬编码的密钥或密码
- [ ] 已检查第三方库的安全性

## 📱 应用质量

### 功能测试
- [ ] 在至少 2 个不同的 Android 设备上测试
- [ ] 在不同 Android 版本上测试（最低和目标版本）
- [ ] 测试所有核心功能：
  - [ ] 快速记录功能
  - [ ] 添加备注和评分
  - [ ] 查看统计数据
  - [ ] 查看趋势图表
  - [ ] 查看健康建议
  - [ ] 删除记录
- [ ] 测试应用在不同屏幕尺寸下的显示
- [ ] 测试横屏和竖屏模式
- [ ] 测试应用安装、卸载、更新流程

### 性能测试
- [ ] 应用启动速度快（< 3秒）
- [ ] 界面响应流畅，无卡顿
- [ ] 内存使用合理
- [ ] 电池消耗正常
- [ ] 本地数据库读写性能良好

### UI/UX 测试
- [ ] 所有文字清晰可读
- [ ] 按钮和交互元素足够大（至少 48dp）
- [ ] 颜色对比度符合可访问性标准
- [ ] 深色模式和浅色模式都正常显示
- [ ] 所有图标和图片显示正确
- [ ] 没有文字截断或重叠

## 🏪 Google Play Console 设置

### 应用信息
- [ ] 创建 Google Play Console 账号（需支付 $25 注册费）
- [ ] 创建新应用
- [ ] 选择默认语言：中文（简体）
- [ ] 填写应用标题
- [ ] 填写简短描述
- [ ] 填写完整描述

### 图形资源上传
- [ ] 上传应用图标（512x512）
- [ ] 上传功能图片（1024x500）
- [ ] 上传手机截图（至少 2 张）
- [ ] 上传平板截图（如有）

### 分类和标签
- [ ] 选择应用类别：健康与健身
- [ ] 选择应用类型：应用
- [ ] 添加标签（如：健康追踪、隐私、本地存储）
- [ ] 设置目标年龄：18+（或根据内容分级结果）

### 联系信息
- [ ] 提供开发者网站（GitHub 项目页面）
- [ ] 提供开发者电子邮件（或 GitHub Issues 链接）
- [ ] 提供隐私政策 URL

### 内容分级
- [ ] 完成内容分级问卷
- [ ] 确认分级结果（建议：成人 17+）
- [ ] 了解各地区的分级要求

### 定价和分发
- [ ] 设置应用为免费
- [ ] 选择发布的国家/地区
  - 建议：先选择中国大陆
  - 或：全球发布
- [ ] 确认不包含广告
- [ ] 确认不包含应用内购买

## 📦 构建和上传

### 构建发布版本
```bash
# 清理旧的构建文件
flutter clean

# 获取依赖
flutter pub get

# 构建 App Bundle（推荐）
flutter build appbundle --release

# 或构建 APK
flutter build apk --release
```

### 验证构建产物
- [ ] AAB 文件存在于 `build/app/outputs/bundle/release/`
- [ ] 或 APK 文件存在于 `build/app/outputs/flutter-apk/`
- [ ] 文件大小合理（预期：10-30 MB）
- [ ] 验证签名正确

### 上传到 Google Play
- [ ] 在 Google Play Console 创建新版本
- [ ] 上传 AAB 或 APK
- [ ] 填写版本发布说明
- [ ] 设置发布类型：
  - [ ] 内部测试（推荐先做）
  - [ ] 封闭测试
  - [ ] 开放测试
  - [ ] 正式发布

## 🧪 测试阶段

### 内部测试
- [ ] 创建内部测试版本
- [ ] 添加测试人员（Gmail 地址）
- [ ] 测试人员安装并测试应用
- [ ] 收集反馈并修复问题
- [ ] 测试至少 3-7 天

### 封闭测试（可选）
- [ ] 创建封闭测试版本
- [ ] 邀请有限数量的测试用户
- [ ] 收集用户反馈
- [ ] 测试至少 7-14 天

### 开放测试（可选）
- [ ] 创建开放测试版本
- [ ] 允许任何人加入测试
- [ ] 收集更广泛的反馈
- [ ] 测试至少 14 天

## 🚀 正式发布

### 发布前最后检查
- [ ] 所有测试问题已修复
- [ ] 所有必需的商店资源已上传
- [ ] 内容分级已完成
- [ ] 隐私政策 URL 可访问
- [ ] 版本号和发布说明正确
- [ ] 团队已批准发布

### 提交审核
- [ ] 在 Google Play Console 提交正式版本
- [ ] 等待 Google 审核（通常 1-7 天）
- [ ] 监控审核状态
- [ ] 如被拒绝，查看原因并修复

### 发布后
- [ ] 确认应用在 Google Play 上线
- [ ] 测试从 Play 商店安装
- [ ] 监控崩溃报告
- [ ] 监控用户评论
- [ ] 及时回复用户反馈
- [ ] 准备应对问题和更新

## 📊 发布后监控

### 第一周
- [ ] 每天检查崩溃报告
- [ ] 回复用户评论
- [ ] 监控下载量和评分
- [ ] 准备热修复（如需要）

### 第一个月
- [ ] 每周检查应用性能
- [ ] 分析用户反馈
- [ ] 计划功能改进
- [ ] 准备第一次更新

### 持续维护
- [ ] 定期更新应用
- [ ] 保持与新 Android 版本兼容
- [ ] 修复报告的问题
- [ ] 添加用户请求的功能
- [ ] 更新截图和商店列表（如有重大变化）

## 🔧 常见问题解决

### 审核被拒绝
1. 仔细阅读拒绝原因
2. 参考 [Google Play 政策](https://play.google.com/about/developer-content-policy/)
3. 修复问题
4. 重新提交

### 常见拒绝原因
- 隐私政策缺失或不可访问
- 内容分级不正确
- 图标或截图不符合规范
- 应用崩溃或严重问题
- 违反内容政策

### 获取帮助
- Google Play Console 帮助中心
- [Stack Overflow - google-play](https://stackoverflow.com/questions/tagged/google-play)
- [r/androiddev](https://www.reddit.com/r/androiddev/)
- 项目 GitHub Issues

## 📚 参考资源

### 官方文档
- [Google Play Console 帮助](https://support.google.com/googleplay/android-developer)
- [应用审核准则](https://support.google.com/googleplay/android-developer/answer/9904549)
- [图形资源规范](https://support.google.com/googleplay/android-developer/answer/9866151)
- [Flutter Android 部署](https://docs.flutter.dev/deployment/android)

### 项目文档
- `README.md` - 项目总体说明
- `play_store/README.md` - Play Store 材料说明
- `play_store/SIGNING_GUIDE.md` - 签名配置指南
- `play_store/screenshots/SCREENSHOT_GUIDE.md` - 截图指南
- `play_store/graphics/FEATURE_GRAPHIC_GUIDE.md` - 功能图片指南

## ✅ 发布完成确认

当以下所有项都完成时，你就可以正式发布了：

- [ ] 所有"准备阶段"项目已完成
- [ ] 所有"隐私和安全"项目已完成
- [ ] 所有"应用质量"测试通过
- [ ] 所有"Google Play Console"设置完成
- [ ] 构建产物已准备好并验证
- [ ] 至少完成内部测试
- [ ] 团队批准发布

**祝发布顺利！** 🎉

---

最后更新：2026年1月
项目：撸了么 (Luleme)
版本：1.0.0
