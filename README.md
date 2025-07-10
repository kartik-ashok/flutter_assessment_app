# Flutter Assessment App

A comprehensive healthcare assessment and appointment booking application built with Flutter, featuring offline-first architecture, Firebase integration, and responsive design.

## 🏗️ Architecture Decisions

### **Clean Architecture Pattern**
The app follows a clean architecture approach with clear separation of concerns:

```
lib/
├── presentation/          # UI Layer (Screens & Widgets)
├── domain/               # Business Logic Layer
│   └── repository/       # Data Access Layer
├── model/                # Data Models
├── provider/             # State Management
├── localStorage/         # Local Data Persistence
├── utils/               # Utility Classes
└── common/              # Shared Components
```

**Key Architectural Decisions:**

1. **Offline-First Approach**: The app prioritizes cached data over network requests, ensuring functionality even without internet connectivity.

2. **Repository Pattern**: Data access is abstracted through repository classes, making it easy to switch data sources and test business logic.

3. **Responsive Design**: Uses the `sizer` package with custom responsive utilities for consistent UI across different screen sizes.

4. **Firebase Integration**: Leverages Firebase Firestore for real-time data synchronization with offline persistence.

## 📱 State Management Choices

### **Provider Pattern**
The app uses the `provider` package for state management, specifically:

- **ChangeNotifierProvider**: For reactive state updates
- **MultiProvider**: For managing multiple providers at the app level

**State Management Structure:**

```dart
class AssessmentCardProvider with ChangeNotifier {
  // Core data
  List<AssessmentCardModel> _cards = [];
  List<AppointmentModel> _appointmentCards = [];
  List<WorkoutRoutine> _workoutRoutins = [];
  
  // UI state
  bool _isLoading = false;
  Set<String> _bookingAppointments = {};
  String? _bookingMessage;
  bool _isUsingCachedData = false;
  Set<String> _favoriteAssessments = {};
}
```

**Key Features:**
- **Offline State Tracking**: Tracks when data is from cache vs server
- **Loading States**: Manages loading indicators across the app
- **Error Handling**: Centralized error message management
- **Favorites Management**: Local persistence of user preferences

### **Local Storage Strategy**
- **SharedPreferences**: For user authentication tokens and app preferences
- **Firebase Offline Cache**: For data persistence and offline functionality
- **Custom Favorite Service**: For managing user favorites locally

## 🚧 Challenges Faced & Solutions

### **1. Offline-First Implementation**
**Challenge**: Ensuring the app works seamlessly without internet connectivity.

**Solution**: 
- Implemented Firebase Firestore offline persistence
- Created a dual-source data fetching strategy (cache-first, server-fallback)
- Added visual indicators for offline state

```dart
// Cache-first approach with server fallback
try {
  snapshot = await FirebaseFirestore.instance
      .collection('assessmentCards')
      .get(const GetOptions(source: Source.cache));
  _isUsingCachedData = true;
} catch (e) {
  if (forceRefresh) {
    snapshot = await FirebaseFirestore.instance
        .collection('assessmentCards')
        .get(const GetOptions(source: Source.server));
    _isUsingCachedData = false;
  }
}
```

### **2. Responsive Design**
**Challenge**: Creating a consistent UI across different screen sizes and orientations.

**Solution**:
- Implemented custom responsive utilities using the `sizer` package
- Created base dimensions and scaling functions
- Used extension methods for cleaner responsive code

```dart
class ResponsiveSize {
  static const double baseWidth = 375.0;
  static const double baseHeight = 812.0;
  
  static double width(double px) {
    return (px / baseWidth) * 100.w;
  }
}
```

### **3. State Synchronization**
**Challenge**: Keeping local favorites in sync with the main state.

**Solution**:
- Created a dedicated `FavoriteService` for local storage
- Integrated favorites loading into the provider initialization
- Implemented proper state updates when favorites change

### **4. Authentication Flow**
**Challenge**: Managing user authentication state and token persistence.

**Solution**:
- Implemented Firebase Authentication
- Created `AppPreferences` for token storage
- Added splash screen with authentication check
- Proper navigation flow based on auth state

### **5. Complex UI Components**
**Challenge**: Building complex appointment booking and calendar interfaces.

**Solution**:
- Used `table_calendar` package for calendar functionality
- Implemented custom appointment booking flow
- Created reusable UI components in the `common` directory

## 🚀 How to Run the App

### **Prerequisites**
- Flutter SDK (3.5.3 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### **Setup Instructions**

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd flutter_assessment_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Configuration**
   - Create a Firebase project
   - Add your app to Firebase
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate platform directories
   - Update `firebase_options.dart` with your Firebase configuration

4. **Run the App**
   ```bash
   # For development
   flutter run
   
   # For release build
   flutter build apk
   ```

### **Platform Support**
- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ Windows
- ✅ macOS
- ✅ Linux

### **Key Features to Test**

1. **Authentication**
   - Sign up with email/password
   - Login with existing credentials
   - Token persistence across app restarts

2. **Offline Functionality**
   - Load app without internet
   - View cached data
   - Pull-to-refresh to update data

3. **Assessment Management**
   - View assessment cards
   - Add/remove favorites
   - Navigate through different assessment types

4. **Appointment Booking**
   - Browse available appointments
   - Book appointments
   - View booking confirmations

5. **Responsive Design**
   - Test on different screen sizes
   - Verify UI scaling
   - Check orientation changes

## 📦 Dependencies

### **Core Dependencies**
- `flutter`: UI framework
- `firebase_core`: Firebase initialization
- `firebase_auth`: User authentication
- `cloud_firestore`: Database and offline persistence
- `provider`: State management
- `shared_preferences`: Local storage

### **UI/UX Dependencies**
- `google_fonts`: Typography
- `sizer`: Responsive design
- `shimmer`: Loading animations
- `awesome_snackbar_content`: Enhanced notifications
- `table_calendar`: Calendar functionality
- `lottie`: Animated assets

### **Development Dependencies**
- `flutter_lints`: Code quality
- `flutter_test`: Testing framework

## 🔧 Configuration Files

- `pubspec.yaml`: Dependencies and assets
- `firebase_options.dart`: Firebase configuration
- `analysis_options.yaml`: Linting rules
- `devtools_options.yaml`: Development tools configuration

## 📱 App Structure

The app follows a modular structure with clear separation of concerns:

- **Authentication**: Firebase Auth with local token storage
- **Data Layer**: Firestore with offline persistence
- **State Management**: Provider pattern with ChangeNotifier
- **UI Layer**: Responsive design with custom components
- **Local Storage**: SharedPreferences for user data

This architecture ensures maintainability, testability, and scalability while providing a smooth user experience across different network conditions and device sizes.
