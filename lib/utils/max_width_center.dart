/*
https://github.com/suryavip/flutter_utils
version 1
*/

import 'package:flutter/material.dart';

class MaxWidthCenter extends StatelessWidget implements PreferredSizeWidget {
  final Widget Function(BuildContext context, double width, bool isLimiting)?
  builder;
  final Widget? child;

  /// Define how much [padding] outside the constrained box.
  /// Allowing [child] to reach all the [maxWidths]'s point
  /// while still be able to show [padding] to the parent.
  final EdgeInsets padding;

  /// Define how much [child] can grow horizontally more than constrained
  /// width defined on [maxWidths].
  final double horizontalEdgeOverrun;

  final Alignment alignment;

  /// [child] will grow until touching the first [maxWidths].
  /// Then stay constrained until parent is larger than next [maxWidths]'s point,
  /// then snap to that next point.
  final List<double> maxWidths;

  const MaxWidthCenter({
    super.key,
    this.builder,
    this.child,
    this.padding = EdgeInsets.zero,
    this.horizontalEdgeOverrun = 0,
    this.alignment = Alignment.center,
    required this.maxWidths,
  }) : assert(
         !(builder != null && child != null),
         'Don\'t define both child and builder because builder will be used and child will be ignored.',
       );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.biggest.width;
        final maxWidth =
            maxWidths.lastWhere(
              (element) => element < availableWidth,
              orElse: () => maxWidths.first,
            ) +
            (horizontalEdgeOverrun * 2);
        final double drawWidth = (availableWidth - padding.horizontal).clamp(
          0,
          maxWidth,
        );

        return Container(
          alignment: alignment,
          padding: padding,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child:
                builder != null
                    ? builder!(context, drawWidth, drawWidth == maxWidth)
                    : child,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize {
    assert(child is PreferredSizeWidget);
    final childSize = (child as PreferredSizeWidget).preferredSize;
    return Size(childSize.width, childSize.height + padding.vertical);
  }
}
