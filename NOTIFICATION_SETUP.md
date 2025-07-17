# 🔔 Flutter Notifications Setup Guide

This guide covers the complete setup for both **Local Notifications** and **Push Notifications** in your Flutter Health Assessment App.

## 📋 Table of Contents

1. [Dependencies](#dependencies)
2. [Local Notifications Setup](#local-notifications-setup)
3. [Push Notifications Setup](#push-notifications-setup)
4. [Android Configuration](#android-configuration)
5. [iOS Configuration](#ios-configuration)
6. [Testing](#testing)
7. [Troubleshooting](#troubleshooting)

## 📦 Dependencies

Add these dependencies to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_local_notifications: ^17.2.3
  firebase_messaging: ^15.2.9
  firebase_core: ^3.8.0
  timezone: ^0.9.4
  shared_preferences: ^2.3.3
```

## 🔔 Local Notifications Setup

### 1. Android Setup

#### `android/app/src/main/AndroidManifest.xml`

Add these permissions and configurations:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Notification Permissions -->
    <uses-permission android:name="android.permission.RECEIVE_BOOT_COMPLETED"/>
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    
    <!-- For exact alarms (Android 12+) -->
    <uses-permission android:name="android.permission.SCHEDULE_EXACT_ALARM" />
    <uses-permission android:name="android.permission.USE_EXACT_ALARM" />

    <application
        android:label="Health Assessment App"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        
        <!-- Main Activity -->
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <!-- Standard App Launch -->
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>

        <!-- Notification Click Handling -->
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationReceiver" />
        <receiver android:name="com.dexterous.flutterlocalnotifications.ScheduledNotificationBootReceiver">
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
                <action android:name="android.intent.action.MY_PACKAGE_REPLACED"/>
                <action android:name="android.intent.action.QUICKBOOT_POWERON" />
                <action android:name="com.htc.intent.action.QUICKBOOT_POWERON"/>
            </intent-filter>
        </receiver>
    </application>
</manifest>
```

### 2. iOS Setup

#### `ios/Runner/AppDelegate.swift`

```swift
import UIKit
import Flutter
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Request notification permissions
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
    }
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

## ☁️ Push Notifications Setup

### 1. Firebase Project Setup

1. **Create Firebase Project:**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create new project or select existing
   - Enable Cloud Messaging

2. **Add Android App:**
   - Click "Add app" → Android
   - Package name: `com.example.flutter_assessment_app`
   - Download `google-services.json`
   - Place in `android/app/`

3. **Add iOS App:**
   - Click "Add app" → iOS
   - Bundle ID: `com.example.flutterAssessmentApp`
   - Download `GoogleService-Info.plist`
   - Add to `ios/Runner/` in Xcode

### 2. Android Configuration

#### `android/build.gradle` (Project level)

```gradle
buildscript {
    ext.kotlin_version = '1.7.10'
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:7.3.0'
        classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        classpath 'com.google.gms:google-services:4.4.0'  // Add this
    }
}
```

#### `android/app/build.gradle`

```gradle
apply plugin: 'com.android.application'
apply plugin: 'kotlin-android'
apply plugin: 'dev.flutter.flutter-gradle-plugin'
apply plugin: 'com.google.gms.google-services'  // Add this

android {
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion

    defaultConfig {
        applicationId "com.example.flutter_assessment_app"
        minSdkVersion 21  // Minimum for FCM
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
    implementation 'com.google.firebase:firebase-messaging:23.4.0'  // Add this
}
```

### 3. iOS Configuration

#### `ios/Runner/Info.plist`

Add these keys:

```xml
<dict>
    <!-- Existing keys... -->
    
    <!-- Background Modes -->
    <key>UIBackgroundModes</key>
    <array>
        <string>fetch</string>
        <string>remote-notification</string>
    </array>
    
    <!-- Notification Settings -->
    <key>FirebaseAppDelegateProxyEnabled</key>
    <false/>
</dict>
```

#### Enable Push Notifications in Xcode

1. Open `ios/Runner.xcworkspace` in Xcode
2. Select Runner target
3. Go to "Signing & Capabilities"
4. Click "+ Capability"
5. Add "Push Notifications"
6. Add "Background Modes" → Check "Remote notifications"

### 4. APNs Certificate (iOS)

1. **Apple Developer Account:**
   - Go to [Apple Developer](https://developer.apple.com/)
   - Certificates, Identifiers & Profiles
   - Create APNs certificate for your app

2. **Upload to Firebase:**
   - Firebase Console → Project Settings
   - Cloud Messaging tab
   - iOS app configuration
   - Upload APNs certificate

## 🧪 Testing

### 1. Local Notifications Testing

```dart
// Test immediate notification
await NotificationService().showNotification(
  title: 'Test Local',
  body: 'This is a test local notification!',
);

// Test repeating notifications
await NotificationService().startRepeatingNotifications();
```

### 2. Push Notifications Testing

#### Using Firebase Console:

1. **Go to Firebase Console** → Cloud Messaging
2. **Click "Send your first message"**
3. **Fill details:**
   ```
   Title: Health Reminder
   Text: Time for your daily health check!
   ```
4. **Target Options:**
   - **Single device**: Use FCM token from test screen
   - **Topic**: Use `health_reminders` or `test_notifications`

#### Using Test Screen in App:

1. Open app → Profile → "Test Notifications (Dev)"
2. Copy FCM token
3. Use token in Firebase Console or testing tools
4. Subscribe to test topics for topic-based testing

### 3. Testing Commands

#### Send via cURL:

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "FCM_TOKEN_HERE",
    "notification": {
      "title": "Test Push",
      "body": "This is a test push notification!"
    },
    "data": {
      "screen": "health",
      "action": "reminder"
    }
  }'
```

## 🔧 Troubleshooting

### Common Issues:

#### 1. **Notifications not showing on Android:**
```
Solution: Check if notification permissions are granted
- Android 13+: App must request POST_NOTIFICATIONS permission
- Check notification channels are properly configured
```

#### 2. **iOS notifications not working:**
```
Solution: Verify APNs setup
- Ensure APNs certificate is uploaded to Firebase
- Check provisioning profile includes Push Notifications
- Verify app is signed with correct certificate
```

#### 3. **Background notifications not received:**
```
Solution: Check background modes
- Android: Ensure app is not battery optimized
- iOS: Verify Background App Refresh is enabled
```

#### 4. **FCM token is null:**
```
Solution: Check Firebase initialization
- Ensure google-services.json/GoogleService-Info.plist are added
- Verify Firebase is initialized before getting token
- Check internet connection
```

### Debug Commands:

```bash
# Check Android notification channels
adb shell dumpsys notification

# Check iOS device logs
xcrun simctl spawn booted log stream --predicate 'subsystem contains "com.apple.usernotifications"'

# Flutter logs
flutter logs
```

## 📱 App Usage

### User Controls:

1. **Profile Screen** → 4 notification toggles:
   - 🔔 **Local Notifications** - 10-second health reminders
   - ☁️ **Push Notifications** - Server-sent notifications  
   - 🏥 **Health Reminders** - Health tips and wellness
   - 📅 **Appointment Reminders** - Appointment notifications

2. **Test Screen** → Developer tools:
   - View and copy FCM token
   - Test local notifications
   - Subscribe/unsubscribe to topics

### Notification Topics:

- `health_reminders` - Health tips and wellness content
- `appointment_reminders` - Appointment notifications  
- `test_notifications` - Testing and development

## ✅ Verification Checklist

- [ ] Dependencies added to pubspec.yaml
- [ ] Android permissions in AndroidManifest.xml
- [ ] iOS capabilities enabled in Xcode
- [ ] Firebase project configured
- [ ] google-services.json added (Android)
- [ ] GoogleService-Info.plist added (iOS)
- [ ] APNs certificate uploaded (iOS)
- [ ] Local notifications working
- [ ] Push notifications working
- [ ] Background notifications working
- [ ] Topic subscriptions working

## 🎉 Success!

Your app now supports both local and push notifications! Users can:
- Receive health reminders every 10 seconds (local)
- Get push notifications from your server
- Control all notification types from profile
- Test functionality with developer tools

## 📋 Additional Configuration

### Environment Variables

Create `.env` file in project root:

```env
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
FIREBASE_APP_ID=your-app-id

# FCM Server Key (for backend)
FCM_SERVER_KEY=your-server-key
```

### Backend Integration

#### Node.js Example:

```javascript
const admin = require('firebase-admin');

// Initialize Firebase Admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

// Send notification function
async function sendNotification(token, title, body, data = {}) {
  const message = {
    notification: { title, body },
    data: data,
    token: token,
  };

  try {
    const response = await admin.messaging().send(message);
    console.log('Successfully sent message:', response);
  } catch (error) {
    console.log('Error sending message:', error);
  }
}

// Send to topic
async function sendToTopic(topic, title, body, data = {}) {
  const message = {
    notification: { title, body },
    data: data,
    topic: topic,
  };

  const response = await admin.messaging().send(message);
  console.log('Successfully sent to topic:', response);
}
```

### Notification Payload Examples

#### Health Reminder:
```json
{
  "notification": {
    "title": "💊 Medication Reminder",
    "body": "Time to take your evening medication"
  },
  "data": {
    "screen": "medications",
    "action": "reminder",
    "medication_id": "med_123",
    "time": "evening"
  },
  "topic": "health_reminders"
}
```

#### Appointment Reminder:
```json
{
  "notification": {
    "title": "📅 Appointment Tomorrow",
    "body": "Dr. Smith appointment at 2:00 PM"
  },
  "data": {
    "screen": "appointments",
    "action": "reminder",
    "appointment_id": "apt_456",
    "doctor": "Dr. Smith",
    "time": "14:00"
  },
  "topic": "appointment_reminders"
}
```

## 🔐 Security Best Practices

### 1. Token Management
- Store FCM tokens securely on your server
- Refresh tokens when they change
- Remove tokens when users uninstall app

### 2. Topic Security
- Use meaningful topic names
- Implement server-side topic validation
- Don't expose sensitive data in topic names

### 3. Data Protection
- Don't send sensitive data in notification payload
- Use notification data to trigger secure API calls
- Implement proper authentication for notification endpoints

## 📊 Analytics & Monitoring

### Firebase Analytics Integration

```dart
// Track notification events
await FirebaseAnalytics.instance.logEvent(
  name: 'notification_received',
  parameters: {
    'notification_type': 'health_reminder',
    'user_id': currentUserId,
    'timestamp': DateTime.now().millisecondsSinceEpoch,
  },
);
```

### Monitoring Delivery

```dart
// Check notification delivery status
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // Log successful delivery
  print('Notification delivered: ${message.messageId}');

  // Track in analytics
  FirebaseAnalytics.instance.logEvent(
    name: 'notification_delivered',
    parameters: {'message_id': message.messageId},
  );
});
```

For support, check the troubleshooting section or Flutter documentation.
