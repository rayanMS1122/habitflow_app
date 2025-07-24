import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/habit.dart';
import '../widgets/motivational_header.dart';
import '../widgets/habit_card.dart';
import '../theme/app_theme.dart';
import 'add_habit_screen.dart';
import 'calendar_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fabAnimationController;
  late Animation<double> _fabScaleAnimation;
  late Animation<double> _fabRotationAnimation;
  
  int _selectedIndex = 0;
  
  // Sample data - in a real app this would come from a provider/state management
  List<Habit> sampleHabits = [
    Habit(
      id: '1',
      name: 'Morning Meditation',
      description: 'Start the day with mindfulness',
      category: HabitCategory.mindfulness,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      currentStreak: 5,
      longestStreak: 12,
      color: '#8B5CF6',
      icon: '🧘',
    ),
    Habit(
      id: '2',
      name: 'Drink 8 Glasses of Water',
      description: 'Stay hydrated throughout the day',
      category: HabitCategory.health,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 14)),
      currentStreak: 3,
      longestStreak: 8,
      color: '#06B6D4',
      icon: '💧',
    ),
    Habit(
      id: '3',
      name: 'Read for 30 Minutes',
      description: 'Expand knowledge through reading',
      category: HabitCategory.learning,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 21)),
      currentStreak: 7,
      longestStreak: 15,
      color: '#10B981',
      icon: '📚',
    ),
    Habit(
      id: '4',
      name: 'Exercise',
      description: 'Stay fit and healthy',
      category: HabitCategory.fitness,
      frequency: HabitFrequency.daily,
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      currentStreak: 2,
      longestStreak: 6,
      color: '#F59E0B',
      icon: '💪',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.elasticOut,
    ));
    
    _fabRotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.25,
    ).animate(CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    HapticFeedback.lightImpact();
  }

  void _toggleHabitCompletion(Habit habit) {
    setState(() {
      if (habit.isCompletedToday) {
        habit.markIncomplete();
      } else {
        habit.markCompleted();
      }
    });
    HapticFeedback.mediumImpact();
  }

  void _addNewHabit() {
    _fabAnimationController.forward().then((_) {
      _fabAnimationController.reverse();
    });
    
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const AddHabitScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedToday = sampleHabits.where((h) => h.isCompletedToday).length;
    final maxStreak = sampleHabits.isNotEmpty 
        ? sampleHabits.map((h) => h.currentStreak).reduce((a, b) => a > b ? a : b)
        : 0;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(completedToday, maxStreak),
          const CalendarScreen(),
          const StatsScreen(),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? AnimatedBuilder(
              animation: _fabAnimationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _fabScaleAnimation.value,
                  child: Transform.rotate(
                    angle: _fabRotationAnimation.value * 2 * 3.14159,
                    child: FloatingActionButton.extended(
                      onPressed: _addNewHabit,
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add Habit'),
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 8,
                      extendedPadding: const EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                );
              },
            )
          : null,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: AppTheme.primaryColor,
          unselectedItemColor: theme.colorScheme.onSurface.withOpacity(0.6),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today_rounded),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics_outlined),
              activeIcon: Icon(Icons.analytics_rounded),
              label: 'Stats',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeTab(int completedToday, int maxStreak) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 0,
          floating: true,
          pinned: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
                ],
              ),
            ),
          ),
        ),
        
        SliverToBoxAdapter(
          child: MotivationalHeader(
            userName: 'Rayan',
            totalHabits: sampleHabits.length,
            completedToday: completedToday,
            currentStreak: maxStreak,
          ),
        ),
        
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Today\'s Habits',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$completedToday/${sampleHabits.length} completed',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final habit = sampleHabits[index];
              return HabitCard(
                habit: habit,
                onComplete: () => _toggleHabitCompletion(habit),
                onTap: () {
                  // Navigate to habit details
                },
              );
            },
            childCount: sampleHabits.length,
          ),
        ),
        
        const SliverToBoxAdapter(
          child: SizedBox(height: 100), // Space for FAB
        ),
      ],
    );
  }
}

