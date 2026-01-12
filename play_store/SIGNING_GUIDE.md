# Android 签名配置指南

本指南帮助配置 Android 应用的发布签名，这是发布到 Google Play 的必要步骤。

## 为什么需要签名？

- **身份验证**：证明应用来自可信来源
- **完整性**：确保应用未被篡改
- **更新控制**：只有使用相同密钥签名的应用才能更新

## 签名步骤

### 1. 生成密钥库（Keystore）

```bash
# 使用 keytool 生成密钥库
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 \
  -alias upload

# 或使用更安全的格式（推荐）
keytool -genkey -v -keystore ~/upload-keystore.jks \
  -storetype JKS -keyalg RSA -keysize 4096 -validity 10000 \
  -alias luleme
```

**提示回答示例**：
- 名字与姓氏：p1gd0g
- 组织单位：Development
- 组织：p1gd0g
- 城市：（你的城市）
- 州或省：（你的省份）
- 国家/地区代码：CN

**重要提醒**：
- 密码至少6个字符
- 记住密钥库密码和密钥密码
- 备份密钥库文件到安全位置
- **丢失密钥库将无法更新应用**

### 2. 创建 key.properties 文件

在 `android` 目录下创建 `key.properties` 文件：

```bash
cd android
touch key.properties
```

编辑 `android/key.properties`，添加以下内容：

```properties
storePassword=你的密钥库密码
keyPassword=你的密钥密码
keyAlias=luleme
storeFile=/home/你的用户名/upload-keystore.jks
```

**示例**：
```properties
storePassword=MySecureStorePassword123
keyPassword=MySecureKeyPassword456
keyAlias=luleme
storeFile=/Users/username/upload-keystore.jks
```

**安全提示**：
- 建议使用不同的密钥库密码和密钥密码以提供额外的安全层
- `key.properties` 文件已在 `.gitignore` 中，不会提交到 Git
- 不要分享密钥库文件和密码
- 将密钥库备份到安全位置（如加密的云存储）

### 3. 配置 Gradle

编辑 `android/app/build.gradle.kts`，添加签名配置。

在 `android {` 块之前添加：

```kotlin
// 读取密钥配置
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = java.util.Properties()

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(java.io.FileInputStream(keystorePropertiesFile))
}
```

在 `android {` 块内，添加 `signingConfigs`（在 `defaultConfig` 之前）：

```kotlin
android {
    // ... 其他配置

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            minifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}
```

### 4. 验证配置

```bash
# 构建发布版本 APK
flutter build apk --release

# 或构建 App Bundle（推荐用于 Google Play）
flutter build appbundle --release
```

如果构建成功，签名配置就完成了！

## Play App Signing（推荐）

Google Play 提供了 App Signing 服务，更安全方便：

### 优势
- Google 管理签名密钥
- 可以重置上传密钥
- 更好的密钥安全性

### 使用步骤

1. **首次上传**：
   - 使用你的上传密钥签名 AAB
   - 上传到 Google Play Console
   - 启用 Play App Signing

2. **后续上传**：
   - 使用上传密钥签名
   - Google 会用应用签名密钥重新签名

详见：[Play App Signing](https://support.google.com/googleplay/android-developer/answer/9842756)

## ProGuard 配置（可选）

如果启用了代码混淆，创建 `android/app/proguard-rules.pro`：

```proguard
# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Hive
-keep class * extends com.hivedb.** { *; }
-keepclassmembers class * extends com.hivedb.** { *; }

# Your models
-keep class com.p1gd0g.luleme.models.** { *; }
```

## 验证签名

验证 APK 是否正确签名：

```bash
# 安装 apksigner（Android SDK Build Tools）
# 验证签名
apksigner verify --verbose build/app/outputs/flutter-apk/app-release.apk

# 查看签名信息
keytool -printcert -jarfile build/app/outputs/flutter-apk/app-release.apk
```

## 常见问题

### 1. 找不到密钥库文件

**错误**：`Keystore file not found`

**解决**：
- 检查 `key.properties` 中的 `storeFile` 路径
- 使用绝对路径
- 确保文件存在

### 2. 密码错误

**错误**：`Keystore was tampered with, or password was incorrect`

**解决**：
- 检查密码是否正确
- 确保没有多余的空格
- 密码区分大小写

### 3. 密钥别名不存在

**错误**：`Key with alias 'xxx' not found`

**解决**：
```bash
# 列出密钥库中的所有别名
keytool -list -v -keystore ~/upload-keystore.jks
```

### 4. 首次构建失败

如果 `key.properties` 不存在，会回退到 debug 签名。这是正常的，用于开发阶段。

## 备份清单

必须安全备份的文件：

- [ ] 密钥库文件（`upload-keystore.jks`）
- [ ] `key.properties` 文件（或记录密码）
- [ ] 密钥库密码
- [ ] 密钥密码
- [ ] 密钥别名

**推荐备份位置**：
- 加密的云存储（如 1Password、LastPass）
- 离线加密硬盘
- 公司的密钥管理系统

**不要**：
- 提交到 Git
- 存储在未加密的位置
- 通过不安全的方式分享

## 密钥管理最佳实践

1. **使用强密码**：至少16个字符，包含字母、数字、符号
2. **定期备份**：至少每月备份一次
3. **限制访问**：只有必要的人员才能访问
4. **使用密码管理器**：如 1Password、Bitwarden
5. **文档记录**：记录密钥创建日期、用途等

## 团队协作

如果是团队开发：

1. **选项A：共享密钥**
   - 使用密码管理器共享
   - 限制访问权限
   - 定期更换密码

2. **选项B：CI/CD 管理**
   - 在 CI/CD 系统中配置密钥
   - 使用环境变量
   - 不在本地存储

3. **选项C：Play App Signing**（推荐）
   - Google 管理应用签名密钥
   - 团队只需要上传密钥
   - 更安全便捷

## 从头开始发布的完整流程

```bash
# 1. 生成密钥库
keytool -genkey -v -keystore ~/luleme-upload-key.jks \
  -storetype JKS -keyalg RSA -keysize 4096 -validity 10000 \
  -alias luleme

# 2. 创建 key.properties
cat > android/key.properties << EOF
storePassword=你的密码
keyPassword=你的密码
keyAlias=luleme
storeFile=$HOME/luleme-upload-key.jks
EOF

# 3. 配置 build.gradle.kts（手动编辑）

# 4. 构建发布版本
flutter build appbundle --release

# 5. 验证构建产物
ls -lh build/app/outputs/bundle/release/app-release.aab

# 6. 上传到 Google Play Console
```

## 参考资源

- [Android 官方签名文档](https://developer.android.com/studio/publish/app-signing)
- [Flutter 签名指南](https://docs.flutter.dev/deployment/android#signing-the-app)
- [Play App Signing](https://support.google.com/googleplay/android-developer/answer/9842756)
- [密钥管理最佳实践](https://developer.android.com/studio/publish/app-signing#secure-shared-keystore)

## 获取帮助

如果遇到问题：
1. 查看 [Stack Overflow](https://stackoverflow.com/questions/tagged/android-signing)
2. 参考 [Flutter 文档](https://docs.flutter.dev/)
3. 在项目 GitHub Issues 中提问
