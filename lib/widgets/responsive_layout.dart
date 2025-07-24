import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.responsiveBuilder(
      context: context,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}

class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? maxWidth;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.maxWidth,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding =
        padding ?? ResponsiveHelper.getScreenPadding(context);
    final effectiveMaxWidth =
        maxWidth ?? ResponsiveHelper.getMaxContentWidth(context);

    return Container(
      width: double.infinity,
      padding: effectivePadding,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: effectiveMaxWidth),
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double? childAspectRatio;
  final double? crossAxisSpacing;
  final double? mainAxisSpacing;
  final EdgeInsets? padding;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.childAspectRatio,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = ResponsiveHelper.getCrossAxisCount(context);
    final effectivePadding =
        padding ?? ResponsiveHelper.getContentPadding(context);

    return Padding(
      padding: effectivePadding,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: childAspectRatio ?? 1.0,
          crossAxisSpacing: crossAxisSpacing ??
              ResponsiveHelper.responsiveValue(
                context: context,
                mobile: 12,
                tablet: 16,
                desktop: 20,
              ),
          mainAxisSpacing: mainAxisSpacing ??
              ResponsiveHelper.responsiveValue(
                context: context,
                mobile: 12,
                tablet: 16,
                desktop: 20,
              ),
        ),
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
    );
  }
}

class ResponsiveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;
  final double? elevation;
  final BorderRadius? borderRadius;
  final Border? border;

  const ResponsiveCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.elevation,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectivePadding = padding ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: const EdgeInsets.all(16),
          tablet: const EdgeInsets.all(20),
          desktop: const EdgeInsets.all(24),
        );

    final effectiveMargin = margin ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: const EdgeInsets.all(8),
          tablet: const EdgeInsets.all(12),
          desktop: const EdgeInsets.all(16),
        );

    final effectiveElevation = elevation ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: 2.0,
          tablet: 4.0,
          desktop: 6.0,
        );

    final effectiveBorderRadius =
        borderRadius ?? ResponsiveHelper.getCardBorderRadius(context);

    return Container(
      margin: effectiveMargin,
      child: Material(
        color: color ?? theme.cardColor,
        elevation: effectiveElevation!,
        borderRadius: effectiveBorderRadius,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: effectiveBorderRadius,
            border: border,
          ),
          padding: effectivePadding,
          child: child,
        ),
      ),
    );
  }
}

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? scaleFactor;

  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseStyle = style ?? theme.textTheme.bodyMedium;
    final baseFontSize = baseStyle?.fontSize ?? 14.0;

    final responsiveFontSize = ResponsiveHelper.getFontSize(
      context,
      baseFontSize * (scaleFactor ?? 1.0),
    );

    return Text(
      text,
      style: baseStyle?.copyWith(fontSize: responsiveFontSize),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

class ResponsiveIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;
  final double? scaleFactor;

  const ResponsiveIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final baseSize = size ?? 24.0;
    final responsiveSize = ResponsiveHelper.getIconSize(
      context,
      baseSize * (scaleFactor ?? 1.0),
    );

    return Icon(
      icon,
      size: responsiveSize,
      color: color,
    );
  }
}

class ResponsiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsets? padding;
  final double? minWidth;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;

  const ResponsiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding,
    this.minWidth,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          tablet: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          desktop: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        );

    final effectiveHeight = height ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: 48.0,
          tablet: 52.0,
          desktop: 56.0,
        );

    final effectiveBorderRadius = borderRadius ??
        ResponsiveHelper.responsiveValue(
          context: context,
          mobile: BorderRadius.circular(12),
          tablet: BorderRadius.circular(14),
          desktop: BorderRadius.circular(16),
        );

    return SizedBox(
      width: minWidth,
      height: effectiveHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: effectivePadding,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          elevation: elevation,
          // shape: RoundedRectangleBorder(
          //   borderRadius: effectiveBorderRadius,
          // ),
        ),
        child: child,
      ),
    );
  }
}

class ResponsiveSpacer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? scaleFactor;

  const ResponsiveSpacer({
    super.key,
    this.height,
    this.width,
    this.scaleFactor,
  });

  @override
  Widget build(BuildContext context) {
    final factor = scaleFactor ?? 1.0;

    final responsiveHeight = height != null
        ? ResponsiveHelper.responsiveValue(
            context: context,
            mobile: height! * factor,
            tablet: height! * factor * 1.2,
            desktop: height! * factor * 1.4,
          )
        : null;

    final responsiveWidth = width != null
        ? ResponsiveHelper.responsiveValue(
            context: context,
            mobile: width! * factor,
            tablet: width! * factor * 1.2,
            desktop: width! * factor * 1.4,
          )
        : null;

    return SizedBox(
      height: responsiveHeight,
      width: responsiveWidth,
    );
  }
}

class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;
  final double? elevation;
  final bool centerTitle;

  const ResponsiveAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.backgroundColor,
    this.elevation,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      toolbarHeight: ResponsiveHelper.getAppBarHeight(context),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        ResponsiveHelper.getAppBarHeight(
          // Note: We can't access context here, so we use a default value
          // This is a limitation of PreferredSizeWidget
          // In practice, the actual height will be set in build()
          WidgetsBinding.instance.rootElement?.context ??
              WidgetsBinding.instance.focusManager.rootScope.context!,
        ),
      );
}

extension on Element? {
  get context => null;
}
