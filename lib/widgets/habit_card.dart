import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/habit.dart';
import '../theme/app_theme.dart';

class HabitCard extends StatefulWidget {
  final Habit habit;
  final VoidCallback? onTap;
  final VoidCallback? onComplete;
  final VoidCallback? onEdit;

  const HabitCard({
    super.key,
    required this.habit,
    this.onTap,
    this.onComplete,
    this.onEdit,
  });

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color get habitColor => Color(
    int.parse(widget.habit.color.replaceFirst('#', '0xFF')),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = widget.habit.isCompletedToday;
    
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Transform.rotate(
            angle: _rotationAnimation.value,
            child: GestureDetector(
              onTapDown: (_) => _animationController.forward(),
              onTapUp: (_) => _animationController.reverse(),
              onTapCancel: () => _animationController.reverse(),
              onTap: widget.onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isCompleted
                      ? AppTheme.successGradient
                      : LinearGradient(
                          colors: [
                            habitColor.withOpacity(0.1),
                            habitColor.withOpacity(0.05),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isCompleted
                        ? AppTheme.successColor
                        : habitColor.withOpacity(0.3),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: habitColor.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      // Habit Icon and Progress
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 30,
                            lineWidth: 4,
                            percent: isCompleted ? 1.0 : widget.habit.completionRate,
                            progressColor: isCompleted
                                ? AppTheme.successColor
                                : habitColor,
                            backgroundColor: habitColor.withOpacity(0.2),
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            animationDuration: 1000,
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppTheme.successColor
                                  : habitColor,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                widget.habit.icon,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Habit Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.habit.name,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: isCompleted
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            
                            const SizedBox(height: 4),
                            
                            Text(
                              widget.habit.category.displayName,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isCompleted
                                    ? Colors.white.withOpacity(0.8)
                                    : theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // Streak Info
                            Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department,
                                  size: 16,
                                  color: isCompleted
                                      ? Colors.white
                                      : AppTheme.warningColor,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${widget.habit.currentStreak} day streak',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isCompleted
                                        ? Colors.white.withOpacity(0.9)
                                        : theme.colorScheme.onSurface.withOpacity(0.7),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Complete Button
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          widget.onComplete?.call();
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? Colors.white
                                : habitColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: habitColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            isCompleted
                                ? Icons.check_rounded
                                : Icons.radio_button_unchecked,
                            color: isCompleted
                                ? AppTheme.successColor
                                : Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

