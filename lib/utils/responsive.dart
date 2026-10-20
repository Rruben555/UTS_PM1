import 'package:flutter/widgets.dart';

class Responsive {
  Responsive._();

  static const double maxContentWidth = 600;

  static const double _designWidth = 360;
  static const double _minScale = 0.85;
  static const double _maxScale = 1.3;

  static double scaleOf(BuildContext context) {
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    return (shortest / _designWidth).clamp(_minScale, _maxScale).toDouble();
  }
}

extension ResponsiveContext on BuildContext {
  double sp(double size) => size * Responsive.scaleOf(this);

  double sz(double size) => size * Responsive.scaleOf(this);

  double get screenWidth => MediaQuery.sizeOf(this).width;
}
