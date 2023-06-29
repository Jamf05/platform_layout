import 'dart:math';

import 'package:platform_layout/src/breakpoint.dart';
import 'package:platform_layout/src/value.dart';

import '../format.dart';

class FluidLayoutFormat extends LayoutPlatformFormat {
  FluidLayoutFormat({
    LayoutValue<double>? margin,
  }) : this.margin = margin ?? _defaultMargin;

  @override
  LayoutValue<double> get maxWidth {
    return LayoutValue.builder(
      (layout) {
        final width = layout.width;
        final breakpoint = breakpointForWidth(width);
        switch (breakpoint) {
          case LayoutPlatformBreakpoint.watch:
            return min(width, maxFluidWidth[breakpoint]!);
          case LayoutPlatformBreakpoint.phone:
          case LayoutPlatformBreakpoint.tablet:
          case LayoutPlatformBreakpoint.desktop:
            return calculateFluidWidth(breakpoint, width);
        }
      },
    );
  }

  double calculateFluidWidth(LayoutPlatformBreakpoint breakpoint, double layoutWidth) {
    //Distance to next width breakpoint
    final width = breakpoints[breakpoint] ?? layoutWidth;

    final currentDistance = width - layoutWidth;

    final totalDistance = width - breakpoints[breakpoint.smaller]!;

    final totalFluidDistance =
        maxFluidWidth[breakpoint]! - maxFluidWidth[breakpoint.smaller]!;
    final progress = currentDistance / totalDistance;
    final maxFluid =
        maxFluidWidth[breakpoint.bigger]! - totalFluidDistance * progress;
    return maxFluid;
  }

  @override
  LayoutValue<double> get gutter {
    const double _spacer = 16;
    return BreakpointValue<double>.all(
      watch: _spacer * 1,
      phone: _spacer * 1.25,
      tablet: _spacer * 1.5,
      desktop: _spacer * 2,
    );
  }

  @override
  LayoutValue<int> get columns => ConstantLayoutValue(12);

  @override
  final LayoutValue<double> margin;

  static final LayoutValue<double> _defaultMargin = LayoutValue.builder(
    (layout) {
      return layout.width <= 719 ? 16 : 24;
    },
  );

  @override
  Map<LayoutPlatformBreakpoint, double> get breakpoints => {
        LayoutPlatformBreakpoint.watch: 0,
        LayoutPlatformBreakpoint.phone: 576,
        LayoutPlatformBreakpoint.tablet: 768,
        LayoutPlatformBreakpoint.desktop: 992,
      };

  Map<LayoutPlatformBreakpoint, double> get maxFluidWidth => {
        LayoutPlatformBreakpoint.watch: 540,
        LayoutPlatformBreakpoint.phone: 540,
        LayoutPlatformBreakpoint.tablet: 720,
        LayoutPlatformBreakpoint.desktop: 960,
      };
}
