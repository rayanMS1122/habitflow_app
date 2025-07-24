import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();
  PageController _pageController = PageController();
  
  // Sample habits for demonstration
  final List<Habit> _habits = [
    Habit(
      id: '1',
      name: 'Morning Meditation',
      category: HabitCategory.mindfulness,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      color: '#8B5CF6',
      icon: '🧘',
      completedDates: _generateSampleCompletedDates(DateTime.now().subtract(const Duration(days: 30))),
    ),
    Habit(
      id: '2',
      name: 'Drink Water',
      category: HabitCategory.health,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 25)),
      color: '#06B6D4',
      icon: '💧',
      completedDates: _generateSampleCompletedDates(DateTime.now().subtract(const Duration(days: 25))),
    ),
    Habit(
      id: '3',
      name: 'Read Books',
      category: HabitCategory.learning,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 20)),
      color: '#10B981',
      icon: '📚',
      completedDates: _generateSampleCompletedDates(DateTime.now().subtract(const Duration(days: 20))),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    ));
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  static List<DateTime> _generateSampleCompletedDates(DateTime startDate) {
    final List<DateTime> dates = [];
    final random = DateTime.now().millisecondsSinceEpoch % 100;
    
    for (int i = 0; i < 30; i++) {
      final date = startDate.add(Duration(days: i));
      // Simulate 70% completion rate
      if ((i + random) % 10 < 7) {
        dates.add(DateTime(date.year, date.month, date.day));
      }
    }
    return dates;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.today_rounded),
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
                _focusedDate = DateTime.now();
              });
              HapticFeedback.lightImpact();
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Month Navigation
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: () {
                      setState(() {
                        _focusedDate = DateTime(
                          _focusedDate.year,
                          _focusedDate.month - 1,
                        );
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                  
                  Text(
                    _getMonthYearString(_focusedDate),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: () {
                      setState(() {
                        _focusedDate = DateTime(
                          _focusedDate.year,
                          _focusedDate.month + 1,
                        );
                      });
                      HapticFeedback.lightImpact();
                    },
                  ),
                ],
              ),
            ),
            
            // Calendar Grid
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCalendarGrid(),
                    const SizedBox(height: 16),
                    _buildHabitsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0).day;
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final firstWeekday = firstDayOfMonth.weekday % 7;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          // Weekday Headers
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) {
                return Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Calendar Days
          ...List.generate(6, (weekIndex) {
            return Row(
              children: List.generate(7, (dayIndex) {
                final dayNumber = weekIndex * 7 + dayIndex - firstWeekday + 1;
                
                if (dayNumber < 1 || dayNumber > daysInMonth) {
                  return const Expanded(child: SizedBox(height: 50));
                }
                
                final date = DateTime(_focusedDate.year, _focusedDate.month, dayNumber);
                final isSelected = _isSameDay(date, _selectedDate);
                final isToday = _isSameDay(date, DateTime.now());
                final completedHabits = _getCompletedHabitsForDate(date);
                
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                      HapticFeedback.lightImpact();
                    },
                    child: Container(
                      height: 50,
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryColor
                            : isToday
                                ? AppTheme.primaryColor.withOpacity(0.1)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            dayNumber.toString(),
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : isToday
                                      ? AppTheme.primaryColor
                                      : null,
                              fontWeight: isSelected || isToday
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                          
                          if (completedHabits.isNotEmpty)
                            Container(
                              margin: const EdgeInsets.only(top: 2),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: completedHabits.take(3).map((habit) {
                                  final color = Color(int.parse(habit.color.replaceFirst('#', '0xFF')));
                                  return Container(
                                    width: 4,
                                    height: 4,
                                    margin: const EdgeInsets.symmetric(horizontal: 1),
                                    decoration: BoxDecoration(
                                      color: isSelected ? Colors.white : color,
                                      shape: BoxShape.circle,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            );
          }).where((row) {
            // Only show rows that have at least one valid day
            return true;
          }).toList(),
          
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildHabitsList() {
    final selectedDateHabits = _getCompletedHabitsForDate(_selectedDate);
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Habits on ${_getDateString(_selectedDate)}',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          
          const SizedBox(height: 16),
          
          if (selectedDateHabits.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.event_busy_rounded,
                    size: 48,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No habits completed on this day',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          else
            ...selectedDateHabits.map((habit) {
              final color = Color(int.parse(habit.color.replaceFirst('#', '0xFF')));
              
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          habit.icon,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 16),
                    
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            habit.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            habit.category.displayName,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppTheme.successColor,
                      size: 24,
                    ),
                  ],
                ),
              );
            }).toList(),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<Habit> _getCompletedHabitsForDate(DateTime date) {
    return _habits.where((habit) {
      return habit.completedDates.any((completedDate) =>
          _isSameDay(completedDate, date));
    }).toList();
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _getDateString(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}

