import 'package:hive/hive.dart';

part 'habit.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String id;
  
  @HiveField(1)
  String name;
  
  @HiveField(2)
  String description;
  
  @HiveField(3)
  HabitCategory category;
  
  @HiveField(4)
  HabitFrequency frequency;
  
  @HiveField(5)
  DateTime createdAt;
  
  @HiveField(6)
  DateTime? reminderTime;
  
  @HiveField(7)
  List<DateTime> completedDates;
  
  @HiveField(8)
  int currentStreak;
  
  @HiveField(9)
  int longestStreak;
  
  @HiveField(10)
  bool isActive;
  
  @HiveField(11)
  String color;
  
  @HiveField(12)
  String icon;

  Habit({
    required this.id,
    required this.name,
    this.description = '',
    required this.category,
    required this.frequency,
    required this.createdAt,
    this.reminderTime,
    List<DateTime>? completedDates,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.isActive = true,
    this.color = '#6366F1',
    this.icon = '🎯',
  }) : completedDates = completedDates ?? [];

  bool get isCompletedToday {
    final today = DateTime.now();
    return completedDates.any((date) => 
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day
    );
  }

  double get completionRate {
    if (completedDates.isEmpty) return 0.0;
    
    final daysSinceCreated = DateTime.now().difference(createdAt).inDays + 1;
    return completedDates.length / daysSinceCreated;
  }

  void markCompleted() {
    final today = DateTime.now();
    final todayDate = DateTime(today.year, today.month, today.day);
    
    if (!completedDates.any((date) => 
        date.year == today.year &&
        date.month == today.month &&
        date.day == today.day)) {
      completedDates.add(todayDate);
      _updateStreak();
      save();
    }
  }

  void markIncomplete() {
    final today = DateTime.now();
    completedDates.removeWhere((date) => 
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day
    );
    _updateStreak();
    save();
  }

  void _updateStreak() {
    if (completedDates.isEmpty) {
      currentStreak = 0;
      return;
    }

    completedDates.sort((a, b) => b.compareTo(a));
    
    int streak = 0;
    DateTime currentDate = DateTime.now();
    currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

    for (DateTime completedDate in completedDates) {
      if (completedDate.isAtSameMomentAs(currentDate)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (completedDate.isBefore(currentDate)) {
        break;
      }
    }

    currentStreak = streak;
    if (currentStreak > longestStreak) {
      longestStreak = currentStreak;
    }
  }
}

@HiveType(typeId: 1)
enum HabitCategory {
  @HiveField(0)
  health,
  @HiveField(1)
  fitness,
  @HiveField(2)
  productivity,
  @HiveField(3)
  learning,
  @HiveField(4)
  mindfulness,
  @HiveField(5)
  social,
  @HiveField(6)
  creativity,
  @HiveField(7)
  finance,
  @HiveField(8)
  other,
}

@HiveType(typeId: 2)
enum HabitFrequency {
  @HiveField(0)
  daily,
  @HiveField(1)
  weekly,
  @HiveField(2)
  custom,
}

extension HabitCategoryExtension on HabitCategory {
  String get displayName {
    switch (this) {
      case HabitCategory.health:
        return 'Health';
      case HabitCategory.fitness:
        return 'Fitness';
      case HabitCategory.productivity:
        return 'Productivity';
      case HabitCategory.learning:
        return 'Learning';
      case HabitCategory.mindfulness:
        return 'Mindfulness';
      case HabitCategory.social:
        return 'Social';
      case HabitCategory.creativity:
        return 'Creativity';
      case HabitCategory.finance:
        return 'Finance';
      case HabitCategory.other:
        return 'Other';
    }
  }

  String get emoji {
    switch (this) {
      case HabitCategory.health:
        return '🏥';
      case HabitCategory.fitness:
        return '💪';
      case HabitCategory.productivity:
        return '⚡';
      case HabitCategory.learning:
        return '📚';
      case HabitCategory.mindfulness:
        return '🧘';
      case HabitCategory.social:
        return '👥';
      case HabitCategory.creativity:
        return '🎨';
      case HabitCategory.finance:
        return '💰';
      case HabitCategory.other:
        return '📝';
    }
  }
}

