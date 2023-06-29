import 'package:platform_layout/src/breakpoint.dart';
import 'package:platform_layout/src/format.dart';
import 'package:platform_layout/src/value.dart';

class LandscapeLayoutFormat extends LayoutPlatformFormat {
  LandscapeLayoutFormat({
    LayoutValue<double>? margin,
    LayoutValue<double>? gutter,
  })  : this.margin = margin ?? const ConstantLayoutValue(0),
        this.gutter = gutter ?? const ConstantLayoutValue(0);

  @override
  final LayoutValue<double> gutter;

  @override
  final LayoutValue<double> margin;

  @override
  final Map<LayoutPlatformBreakpoint, double> breakpoints = {
    LayoutPlatformBreakpoint.watch: 0,
    LayoutPlatformBreakpoint.phone: 0,
    LayoutPlatformBreakpoint.tablet: 0,
    LayoutPlatformBreakpoint.desktop: 0,
  };

  @override
  final LayoutValue<double> maxWidth = BreakpointValue.all(
    watch: 0,
    phone: 0,
    tablet: 0,
    desktop: 0,
  );
}
