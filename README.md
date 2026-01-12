# 撸了么 (Luleme)

一款私密的个人健康追踪应用，用于记录时间、频率和感受，并提供健康建议。

## 功能特点

### 核心功能
- **一键记录**：快速记录事件，支持添加备注和感受评分
- **统计分析**：直观展示周、月、总频率的统计图表
- **健康建议**：专属的健康和自我管理建议板块
- **完全私密**：所有数据仅存储在本地设备，完全保护隐私

### 技术栈
- **框架**：Flutter 3.x
- **状态管理**：GetX
- **本地存储**：Hive (NoSQL数据库)
- **UI框架**：Material Design 3 with FlexColorScheme
- **图表**：FL Chart

## 项目结构

```
lib/
├── main.dart                 # 应用入口
├── controllers/
│   └── event_controller.dart # GetX状态管理控制器
├── models/
│   ├── event_record.dart     # 事件记录数据模型
│   └── event_record.g.dart   # Hive适配器
├── screens/
│   ├── home_screen.dart      # 主页面
│   ├── statistics_screen.dart # 统计页面
│   └── advice_screen.dart    # 健康建议页面
└── services/
    └── storage_service.dart  # 数据存储服务
```

## 安装依赖

```bash
flutter pub get
```

## 构建应用

### Web
```bash
flutter build web --build-name=0.1.0 --dart-define=vsn=0.1.0 --output=public
```

### Android
```bash
flutter build apk --release
```

或构建 App Bundle (用于 Google Play)：
```bash
flutter build appbundle --release
```

## Google Play 发布

如需发布到 Google Play，请查看 [play_store](./play_store/) 目录：
- [发布检查清单](./play_store/PUBLISHING_CHECKLIST.md)
- [签名配置指南](./play_store/SIGNING_GUIDE.md)
- [截图指南](./play_store/screenshots/SCREENSHOT_GUIDE.md)
- [商店列表详情](./play_store/metadata/store_listing_details.md)

## 开发

### 运行应用
```bash
flutter run
```

### 生成图标
```bash
flutter pub get
dart run flutter_launcher_icons
```

## 隐私说明

本应用高度重视用户隐私：
- 所有数据仅存储在用户本地设备
- 不上传任何数据到云端
- 不收集任何个人信息
- 不需要网络连接即可使用

## 健康提示

本应用仅供个人健康追踪使用，不构成医疗建议。如有健康问题，请咨询专业医生。

## License

MIT License
