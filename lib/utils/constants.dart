class AppConstants {
  // App Information
  static const String appName = 'HabitFlow';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Build Better Habits';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);
  static const Duration extraLongAnimation = Duration(milliseconds: 1000);

  // Spacing
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;

  // Border Radius
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;

  // Icon Sizes
  static const double iconXS = 16.0;
  static const double iconS = 20.0;
  static const double iconM = 24.0;
  static const double iconL = 32.0;
  static const double iconXL = 48.0;

  // Font Sizes
  static const double fontXS = 10.0;
  static const double fontS = 12.0;
  static const double fontM = 14.0;
  static const double fontL = 16.0;
  static const double fontXL = 18.0;
  static const double fontXXL = 20.0;
  static const double fontHeadingS = 24.0;
  static const double fontHeadingM = 28.0;
  static const double fontHeadingL = 32.0;
  static const double fontHeadingXL = 36.0;

  // Elevation
  static const double elevationS = 2.0;
  static const double elevationM = 4.0;
  static const double elevationL = 8.0;
  static const double elevationXL = 12.0;

  // Opacity
  static const double opacityDisabled = 0.38;
  static const double opacityMedium = 0.6;
  static const double opacityHigh = 0.87;

  // Habit Constants
  static const int maxHabitNameLength = 50;
  static const int maxHabitDescriptionLength = 200;
  static const int defaultStreakGoal = 30;
  static const int maxStreakDisplay = 999;

  // Notification IDs
  static const int baseNotificationId = 1000;
  static const int achievementNotificationId = 2000;
  static const int reminderNotificationId = 3000;

  // Storage Keys
  static const String habitsBoxKey = 'habits';
  static const String settingsBoxKey = 'settings';
  static const String userPreferencesKey = 'user_preferences';
  static const String themeKey = 'theme_mode';
  static const String notificationsEnabledKey = 'notifications_enabled';
  static const String firstLaunchKey = 'first_launch';

  // Default Values
  static const String defaultUserName = 'User';
  static const String defaultHabitIcon = '🎯';
  static const String defaultHabitColor = '#6366F1';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxEmailLength = 254;

  // URLs
  static const String privacyPolicyUrl = 'https://habitflow.app/privacy';
  static const String termsOfServiceUrl = 'https://habitflow.app/terms';
  static const String supportUrl = 'https://habitflow.app/support';
  static const String feedbackUrl = 'https://habitflow.app/feedback';

  // Error Messages
  static const String genericErrorMessage = 'Something went wrong. Please try again.';
  static const String networkErrorMessage = 'Please check your internet connection.';
  static const String validationErrorMessage = 'Please check your input and try again.';
  static const String permissionErrorMessage = 'Permission required to continue.';

  // Success Messages
  static const String habitCreatedMessage = 'Habit created successfully!';
  static const String habitUpdatedMessage = 'Habit updated successfully!';
  static const String habitDeletedMessage = 'Habit deleted successfully!';
  static const String habitCompletedMessage = 'Great job! Habit completed!';

  // Achievement Messages
  static const String firstHabitAchievement = 'First Step!';
  static const String firstHabitDescription = 'You created your first habit!';
  static const String streakAchievement = 'On Fire!';
  static const String weekStreakDescription = 'You completed a 7-day streak!';
  static const String monthStreakDescription = 'Amazing! 30-day streak achieved!';

  // Time Constants
  static const int millisecondsPerSecond = 1000;
  static const int secondsPerMinute = 60;
  static const int minutesPerHour = 60;
  static const int hoursPerDay = 24;
  static const int daysPerWeek = 7;
  static const int daysPerMonth = 30;
  static const int daysPerYear = 365;

  // Chart Constants
  static const int maxChartDataPoints = 30;
  static const double chartAnimationDuration = 1.5;
  static const double chartLineWidth = 3.0;
  static const double chartDotRadius = 4.0;

  // Grid Constants
  static const int mobileGridColumns = 1;
  static const int tabletGridColumns = 2;
  static const int desktopGridColumns = 3;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
  static const int maxCacheSize = 100;

  // Limits
  static const int maxHabitsPerUser = 50;
  static const int maxCategoriesPerUser = 20;
  static const int maxRemindersPerHabit = 5;

  // Feature Flags
  static const bool enableAnalytics = false;
  static const bool enableCrashReporting = false;
  static const bool enableBetaFeatures = false;
  static const bool enableOfflineMode = true;
  static const bool enableDarkMode = true;
  static const bool enableNotifications = true;

  // Development
  static const bool isDebugMode = true;
  static const bool enableLogging = true;
  static const String logLevel = 'DEBUG';
}

