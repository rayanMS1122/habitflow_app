import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MotivationalHeader extends StatefulWidget {
  final String userName;
  final int totalHabits;
  final int completedToday;
  final int currentStreak;

  const MotivationalHeader({
    super.key,
    required this.userName,
    required this.totalHabits,
    required this.completedToday,
    required this.currentStreak,
  });

  @override
  State<MotivationalHeader> createState() => _MotivationalHeaderState();
}

class _MotivationalHeaderState extends State<MotivationalHeader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String get motivationalMessage {
    final completionRate = widget.totalHabits > 0 
        ? widget.completedToday / widget.totalHabits 
        : 0.0;
    
    if (completionRate >= 1.0) {
      return "Perfect day! You're unstoppable! 🔥";
    } else if (completionRate >= 0.8) {
      return "Almost there! Finish strong! 💪";
    } else if (completionRate >= 0.5) {
      return "Great progress! Keep it up! ⚡";
    } else if (widget.currentStreak > 0) {
      return "Keep your ${widget.currentStreak}-day streak alive! 🎯";
    } else {
      return "Ready to build great habits? 🌟";
    }
  }

  String get greetingMessage {
    final hour = DateTime.now().hour;
    String greeting;
    
    if (hour < 12) {
      greeting = "Good morning";
    } else if (hour < 17) {
      greeting = "Good afternoon";
    } else {
      greeting = "Good evening";
    }
    
    return "$greeting, ${widget.userName}! 👋";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting
                  Text(
                    greetingMessage,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Motivational Message
                  Text(
                    motivationalMessage,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Progress Stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.today,
                          label: 'Today',
                          value: '${widget.completedToday}/${widget.totalHabits}',
                          theme: theme,
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.local_fire_department,
                          label: 'Streak',
                          value: '${widget.currentStreak} days',
                          theme: theme,
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      Expanded(
                        child: _buildStatCard(
                          icon: Icons.trending_up,
                          label: 'Rate',
                          value: widget.totalHabits > 0 
                              ? '${((widget.completedToday / widget.totalHabits) * 100).round()}%'
                              : '0%',
                          theme: theme,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required ThemeData theme,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withOpacity(0.8),
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

