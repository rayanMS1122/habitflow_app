# HabitFlow - Advanced Flutter Habit Tracker

A modern, beautifully designed habit tracking application built with Flutter, featuring advanced UI animations, responsive design, and an intuitive user experience.

## 🌟 Features

### Core Functionality
- **Habit Management**: Create, edit, and track daily habits with customizable icons and colors
- **Progress Tracking**: Visual progress indicators with animated circular progress rings
- **Streak Tracking**: Monitor current and longest streaks with motivational feedback
- **Calendar View**: Visual calendar showing habit completion history
- **Statistics Dashboard**: Comprehensive analytics with charts and insights
- **Categories**: Organize habits by categories (Health, Fitness, Productivity, etc.)

### Advanced UI/UX
- **Splash Screen**: Animated app launch experience
- **Responsive Design**: Optimized for mobile, tablet, and desktop
- **Dark/Light Theme**: Automatic theme switching based on system preferences
- **Smooth Animations**: Fluid transitions and micro-interactions
- **Haptic Feedback**: Enhanced user experience with tactile responses
- **Achievement Popups**: Celebratory notifications for milestones

### Technical Features
- **Local Storage**: Offline-first approach using Hive database
- **Notifications**: Local push notifications for habit reminders
- **State Management**: Efficient state handling with Riverpod
- **Material Design 3**: Modern design language implementation

## 🏗️ Architecture

### Project Structure
```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── habit.dart           # Habit model with Hive annotations
│   └── habit.g.dart         # Generated Hive adapters
├── screens/                  # Main app screens
│   ├── home_screen.dart     # Main dashboard
│   ├── add_habit_screen.dart # Habit creation flow
│   ├── calendar_screen.dart  # Calendar view
│   └── stats_screen.dart    # Analytics dashboard
├── widgets/                  # Reusable UI components
│   ├── habit_card.dart      # Habit display card
│   ├── motivational_header.dart # Dashboard header
│   ├── animated_progress_ring.dart # Custom progress indicator
│   ├── floating_action_menu.dart # Expandable FAB
│   ├── splash_screen.dart   # App launch screen
│   ├── achievement_popup.dart # Success notifications
│   └── responsive_layout.dart # Responsive components
├── theme/                    # App theming
│   └── app_theme.dart       # Theme definitions
├── services/                 # Business logic
│   └── notification_service.dart # Local notifications
└── utils/                    # Helper utilities
    ├── constants.dart       # App constants
    ├── date_helper.dart     # Date utilities
    └── responsive_helper.dart # Responsive design helpers
```

### Key Technologies
- **Flutter 3.10+**: Cross-platform UI framework
- **Riverpod**: State management solution
- **Hive**: Local NoSQL database
- **FL Chart**: Beautiful charts and graphs
- **Animations**: Custom animations and transitions
- **Local Notifications**: Reminder system

## 🎨 Design System

### Color Palette
- **Primary**: Indigo (#6366F1)
- **Secondary**: Purple (#8B5CF6)
- **Accent**: Cyan (#06B6D4)
- **Success**: Green (#10B981)
- **Warning**: Amber (#F59E0B)
- **Error**: Red (#EF4444)

### Typography
- **Font Family**: Inter
- **Heading Large**: 32px, Bold
- **Heading Medium**: 24px, SemiBold
- **Body Large**: 16px, Regular
- **Body Medium**: 14px, Regular

### Spacing System
- **XS**: 4px
- **S**: 8px
- **M**: 16px
- **L**: 24px
- **XL**: 32px
- **XXL**: 48px

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.10.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd habitflow_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (if needed)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK**
```bash
flutter build apk --release
```

**iOS IPA**
```bash
flutter build ios --release
```

**Web**
```bash
flutter build web --release
```

## 📱 Screenshots

### Home Screen
- Motivational header with daily progress
- Habit cards with completion status
- Animated progress indicators
- Floating action button for quick actions

### Add Habit Flow
- Multi-step form with smooth transitions
- Category selection with visual icons
- Color and icon customization
- Reminder time configuration

### Calendar View
- Monthly calendar with completion indicators
- Habit details for selected dates
- Smooth navigation between months
- Visual progress tracking

### Statistics Dashboard
- Completion trend charts
- Category distribution pie chart
- Habit leaderboard with streaks
- Responsive card layouts

## 🎯 Key Features Breakdown

### Habit Cards
- **Visual Progress**: Circular progress rings with animations
- **Streak Display**: Current streak with fire icon
- **Quick Actions**: Tap to complete, long press for options
- **Category Indicators**: Color-coded by habit category

### Motivational System
- **Dynamic Greetings**: Time-based welcome messages
- **Progress Feedback**: Encouraging messages based on completion rate
- **Achievement Celebrations**: Popup notifications for milestones
- **Streak Motivation**: Special messages for maintaining streaks

### Responsive Design
- **Mobile First**: Optimized for phone usage
- **Tablet Support**: Enhanced layouts for larger screens
- **Desktop Ready**: Full desktop experience
- **Orientation Aware**: Adapts to landscape/portrait modes

### Animation System
- **Micro-interactions**: Button presses, card taps
- **Page Transitions**: Smooth navigation between screens
- **Loading States**: Elegant loading indicators
- **Success Feedback**: Celebration animations

## 🔧 Customization

### Adding New Habit Categories
1. Update `HabitCategory` enum in `models/habit.dart`
2. Add display name and emoji in the extension
3. Update the category selection UI

### Modifying Themes
1. Edit color values in `theme/app_theme.dart`
2. Adjust typography scales
3. Update component themes

### Custom Animations
1. Create new animation controllers
2. Define animation curves and durations
3. Implement in widget build methods

## 🧪 Testing

### Running Tests
```bash
flutter test
```

### Widget Tests
- Test individual components
- Verify UI behavior
- Check responsive layouts

### Integration Tests
- End-to-end user flows
- Database operations
- Notification handling

## 📦 Dependencies

### Core Dependencies
- `flutter_riverpod`: State management
- `hive_flutter`: Local database
- `animations`: UI animations
- `fl_chart`: Charts and graphs
- `percent_indicator`: Progress indicators

### Development Dependencies
- `flutter_test`: Testing framework
- `build_runner`: Code generation
- `hive_generator`: Hive adapters

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Material Design team for design guidelines
- Open source community for packages and inspiration



---

**Built with ❤️ using Flutter**

