/*
https://github.com/suryavip/flutter_utils
version 1
*/

import 'package:flutter/material.dart';

class SliverMaxWidthCenter extends StatelessWidget
    implements PreferredSizeWidget {
  /// [BoxConstraints] from the nearest [LayoutBuilder].
  /// Allowing to know how much width is given.
  final Size constraints;

  final Widget sliver;

  /// Define how much [padding] outside the constrained box.
  /// Allowing [child] to reach all the [maxWidths]'s point
  /// while still be able to show [padding] to the parent.
  final EdgeInsets padding;

  /// Define how much [child] can grow horizontally more than constrained
  /// width defined on [maxWidths].
  final double horizontalEdgeOverrun;

  /// [child] will grow until touching the first [maxWidths].
  /// Then stay constrained until parent is larger than next [maxWidths]'s point,
  /// then snap to that next point.
  final List<double> maxWidths;

  const SliverMaxWidthCenter({
    super.key,
    required this.constraints,
    required this.sliver,
    this.padding = EdgeInsets.zero,
    this.horizontalEdgeOverrun = 0,
    required this.maxWidths,
  });

  @override
  Widget build(BuildContext context) {
    final availableWidth = constraints.width;
    final maxWidth =
        maxWidths.lastWhere(
          (element) => element < availableWidth,
          orElse: () => maxWidths.first,
        ) +
        (horizontalEdgeOverrun * 2);
    final leftPush =
        (constraints.width - maxWidth - padding.horizontal).clamp(
          0,
          double.maxFinite,
        ) /
        2;

    return SliverPadding(
      padding: padding,
      sliver: SliverPadding(
        padding: EdgeInsets.only(left: leftPush),
        sliver: SliverConstrainedCrossAxis(maxExtent: maxWidth, sliver: sliver),
      ),
    );
  }

  @override
  Size get preferredSize {
    assert(sliver is PreferredSizeWidget);
    final childSize = (sliver as PreferredSizeWidget).preferredSize;
    return Size(childSize.width, childSize.height + padding.vertical);
  }
}
