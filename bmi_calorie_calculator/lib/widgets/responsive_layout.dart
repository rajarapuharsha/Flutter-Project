import 'package:flutter/material.dart';

/// Breakpoint definitions for adaptive screen layouts.
class ResponsiveBreakpoints {
  static const double mobileMax = 700.0;
  static const double tabletMax = 1050.0;
  static const double maxContentWidth = 1200.0;
}

/// A responsive widget that builds different widget trees depending on available width.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  /// Checks if screen width corresponds to mobile.
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < ResponsiveBreakpoints.mobileMax;

  /// Checks if screen width corresponds to tablet.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= ResponsiveBreakpoints.mobileMax &&
        width < ResponsiveBreakpoints.tabletMax;
  }

  /// Checks if screen width corresponds to desktop/large displays.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= ResponsiveBreakpoints.tabletMax;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= ResponsiveBreakpoints.tabletMax) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: ResponsiveBreakpoints.maxContentWidth,
              ),
              child: desktop,
            ),
          );
        } else if (constraints.maxWidth >= ResponsiveBreakpoints.mobileMax) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: ResponsiveBreakpoints.tabletMax,
              ),
              child: tablet ?? mobile,
            ),
          );
        } else {
          return mobile;
        }
      },
    );
  }
}
