import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class FloatingActionMenu extends StatefulWidget {
  final VoidCallback? onAddHabit;
  final VoidCallback? onViewStats;
  final VoidCallback? onSettings;

  const FloatingActionMenu({
    super.key,
    this.onAddHabit,
    this.onViewStats,
    this.onSettings,
  });

  @override
  State<FloatingActionMenu> createState() => _FloatingActionMenuState();
}

class _FloatingActionMenuState extends State<FloatingActionMenu>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;

  bool _isExpanded = false;

  final List<_MenuItem> _menuItems = [
    _MenuItem(
      icon: Icons.add_rounded,
      label: 'Add Habit',
      color: AppTheme.primaryColor,
    ),
    _MenuItem(
      icon: Icons.analytics_rounded,
      label: 'View Stats',
      color: AppTheme.accentColor,
    ),
    _MenuItem(
      icon: Icons.settings_rounded,
      label: 'Settings',
      color: AppTheme.secondaryColor,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.125, // 45 degrees
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
      _rotationController.forward();
    } else {
      _animationController.reverse();
      _rotationController.reverse();
    }

    HapticFeedback.lightImpact();
  }

  void _onMenuItemTap(int index) {
    _toggleMenu();
    
    switch (index) {
      case 0:
        widget.onAddHabit?.call();
        break;
      case 1:
        widget.onViewStats?.call();
        break;
      case 2:
        widget.onSettings?.call();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        // Backdrop
        if (_isExpanded)
          GestureDetector(
            onTap: _toggleMenu,
            child: AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black.withOpacity(0.3 * _fadeAnimation.value),
                );
              },
            ),
          ),

        // Menu Items
        ...List.generate(_menuItems.length, (index) {
          return AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              final offset = (index + 1) * 70.0;
              return Transform.translate(
                offset: Offset(0, -offset * _scaleAnimation.value),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Opacity(
                    opacity: _fadeAnimation.value,
                    child: _buildMenuItem(_menuItems[index], index),
                  ),
                ),
              );
            },
          );
        }).reversed.toList(),

        // Main FAB
        AnimatedBuilder(
          animation: _rotationController,
          builder: (context, child) {
            return Transform.rotate(
              angle: _rotationAnimation.value * 2 * 3.14159,
              child: FloatingActionButton(
                onPressed: _toggleMenu,
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 8,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _isExpanded ? Icons.close_rounded : Icons.add_rounded,
                    key: ValueKey(_isExpanded),
                    size: 28,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(_MenuItem item, int index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            item.label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),

        const SizedBox(width: 12),

        // Button
        GestureDetector(
          onTap: () => _onMenuItemTap(index),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: item.color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              item.icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;

  _MenuItem({
    required this.icon,
    required this.label,
    required this.color,
  });
}

