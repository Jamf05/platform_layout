import 'package:platform_layout/src/breakpoint.dart';
import 'package:platform_layout/src/format.dart';
import 'package:platform_layout/src/value.dart';

class PortraitLayoutFormat extends LayoutPlatformFormat {
  PortraitLayoutFormat({
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
    LayoutPlatformBreakpoint.watch: 150,
    LayoutPlatformBreakpoint.phone: 300,
    LayoutPlatformBreakpoint.tablet: 600,
    LayoutPlatformBreakpoint.desktop: 1200,
  };

  @override
  final LayoutValue<double> maxWidth = BreakpointValue.all(
    watch: 150,
    phone: 300,
    tablet: 600,
    desktop: 1200,
  );
}
