import 'package:flutter/material.dart';

/// Responsive layout helper that adapts screen presentation across
/// mobile phones, tablets, and desktop/web browser windows.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;
  final double maxWidth;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
    this.maxWidth = 1100,
  });

  /// Mobile breakpoint (< 600 dp)
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  /// Tablet breakpoint (600 to 1024 dp)
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1024;

  /// Desktop / Wide Web breakpoint (>= 1024 dp)
  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1024;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget child;
        if (constraints.maxWidth >= 1024) {
          child = desktop;
        } else if (constraints.maxWidth >= 600) {
          child = tablet ?? desktop;
        } else {
          child = mobile;
        }

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: child,
          ),
        );
      },
    );
  }
}
