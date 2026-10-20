import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class ResponsiveBody extends StatelessWidget {
  final Widget child;

  final bool centerVertically;

  final double verticalPadding;

  const ResponsiveBody({
    super.key,
    required this.child,
    this.centerVertically = false,
    this.verticalPadding = 20,
  });

  @override
  Widget build(BuildContext context) {
    final double horizontal = context.screenWidth * 0.06;
    final double vertical = context.sz(verticalPadding);

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double minHeight =
              math.max(0.0, constraints.maxHeight - vertical * 2);

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: minHeight),
              child: Align(
                alignment: centerVertically
                    ? Alignment.center
                    : Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: Responsive.maxContentWidth,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
