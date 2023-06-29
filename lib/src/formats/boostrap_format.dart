import 'package:platform_layout/src/breakpoint.dart';
import 'package:platform_layout/src/format.dart';
import 'package:platform_layout/src/value.dart';

class BoostrapLayoutFormat extends LayoutPlatformFormat {
  BoostrapLayoutFormat({
    LayoutValue<double>? margin,
  }) : this.margin = margin ?? const ConstantLayoutValue(0);

  @override
  final LayoutValue<double> gutter = const ConstantLayoutValue(30.0);

  @override
  final LayoutValue<double> margin;

  @override
  Map<LayoutPlatformBreakpoint, double> get breakpoints => {
        LayoutPlatformBreakpoint.watch: 0,
        LayoutPlatformBreakpoint.phone: 576,
        LayoutPlatformBreakpoint.tablet: 768,
        LayoutPlatformBreakpoint.desktop: 992,
      };

  @override
  final LayoutValue<double> maxWidth = BreakpointValue.all(
    watch: 576, // Always maxWitdh == width
    phone: 540,
    tablet: 720,
    desktop: 960,
  );
}
