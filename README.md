# 撸了么 (LuleMo)

一款私密的个人健康追踪应用，用于记录和管理个人健康数据，提供统计分析和健康建议。

## 功能特性

### 核心功能
- **快速记录**：一键记录新的事件，支持添加时长、感受和备注
- **统计分析**：
  - 本周趋势图表（柱状图）
  - 本月趋势图表（折线图）
  - 感受分布图（饼图）
  - 实时统计：周、月、总计数据
- **健康建议**：专属的健康提示和自我管理建议板块
- **隐私安全**：所有数据存储在本地，保护隐私

### 技术栈
- **框架**：Flutter 3.9+
- **状态管理**：GetX
- **本地存储**：SharedPreferences
- **图表库**：FL Chart
- **UI组件**：Forui、FlexColorScheme
- **目标平台**：Android（计划上架Google Play）

## 项目结构

```
lib/
├── main.dart                 # 应用入口和导航
├── models/
│   └── event_model.dart      # 事件数据模型
├── controllers/
│   └── event_controller.dart # GetX状态管理
├── services/
│   └── storage_service.dart  # 本地存储服务
└── screens/
    ├── home_screen.dart          # 首页（快速记录）
    ├── statistics_screen.dart    # 统计页面
    └── health_advice_screen.dart # 健康建议页面
```

## 开始使用

### 环境要求
- Flutter SDK: ^3.9.0
- Dart SDK: ^3.9.0

### 安装依赖

```bash
flutter pub get
```

### 运行应用

```bash
# 运行调试版本
flutter run

# 构建Android APK
flutter build apk

# 构建Android App Bundle (用于Google Play)
flutter build appbundle
```

## build

```
$ENV:build_vsn='0.1.0'
flutter build web --build-name=$ENV:build_vsn --dart-define=vsn=$ENV:build_vsn --output=public
```

## generate icon

1. Setup the config file

Run the following command to create a new config automatically:

```shell
dart run flutter_launcher_icons:generate
```

This will create a new file called `flutter_launcher_icons.yaml` in your `flutter` project's root directory.

2. Run the package

After setting up the configuration, all that is left to do is run the package.

```shell
flutter pub get
dart run flutter_launcher_icons
```

## 隐私声明

本应用所有数据均存储在用户设备本地，不会上传到任何服务器。应用尊重用户隐私，所有记录仅供个人使用。

## 免责声明

本应用提供的健康建议仅供参考，不能替代专业医疗建议。如有健康问题，请咨询专业医疗人员。

## 许可证

详见 [LICENSE](LICENSE) 文件。
