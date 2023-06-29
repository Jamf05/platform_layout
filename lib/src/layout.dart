import 'package:flutter/material.dart';
import 'package:platform_layout/src/format.dart';
import 'package:platform_layout/src/formats/portrait_layout_format.dart';
import 'package:platform_layout/src/value.dart';
import 'breakpoint.dart';

class LayoutPlatformContext {
  final Size size;
  double get width => size.width;

  final LayoutPlatformBreakpoint breakpoint;
  final double devicePixelRatio;
  final VisualDensity visualDensity;

  LayoutPlatformContext({
    required this.size,
    required this.breakpoint,
    required this.devicePixelRatio,
    VisualDensity? visualDensity,
  }) : this.visualDensity =
            visualDensity ?? VisualDensity.adaptivePlatformDensity;
}

/// A widget that generates the responsive layout data for its children.
///
/// It calculates a [LayoutPlatformData] according to the max width of this widget and
/// the `format` definded.
///
/// This layout `format` is [MaterialFormat] by default, but it is possible to
/// use [BoostrapFormat] or build your own [LayoutPlatformFormat]
/// that defines how the layout should behave for different width sizes.
///
/// This [LayoutPlatformData] it is accesible from any widget down the tree through
/// `Layout.of(context)` or `context.layout`
///
/// To generate responsive values for different sizes, use the following method
/// `context.layout.value(watch: 1, s:2, m: 3, l:4, xl:5)`
///
/// See also:
///   - [Margin] A widget that adds a responsive padding to its child. This
///     padding is calculated by `Layout`
class LayoutPlatform extends StatefulWidget {
  const LayoutPlatform({
    Key? key,
    required this.child,
    this.format,
  }) : super(key: key);

  final Widget child;

  final LayoutPlatformFormat? format;

  static LayoutPlatformData of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_LayoutPlatformInheritedWidget>()!
      .data;

  static LayoutPlatformData? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_LayoutPlatformInheritedWidget>()
      ?.data;

  @override
  _LayoutPlatformState createState() => _LayoutPlatformState();
}

class LayoutPlatformData extends LayoutPlatformContext {
  LayoutPlatformData({
    Key? key,
    required Size size,
    required double devicePixelRatio,
    required VisualDensity visualDensity,
    required this.margin,
    required this.format,
    required this.gutter,
    required this.breakpoint,
    required this.columns,
    required this.maxWidth,
  })  : fluidMargin = (size.width - maxWidth) / 2,
        super(
          size: size,
          breakpoint: breakpoint,
          devicePixelRatio: devicePixelRatio,
          visualDensity: visualDensity,
        );

  /// Breakpoint screen size for the given context
  final LayoutPlatformBreakpoint breakpoint;

  /// Layout format that defines the properties for the given context
  final LayoutPlatformFormat format;

  /// Spacing value between items. For example, space between cells in a grid
  final double gutter;

  /// Padding between the edge of the screens and the content
  final double margin;

  /// Number of columns in a grid layout for the given context
  final int columns;

  /// Responsive margin to constraint the content to a max width
  final double fluidMargin;

  /// Constrained width for the content inside fluid layouts.
  final double maxWidth;

  /// Total margin based on the relative margin and the fluid margin
  double get fullMargin => fluidMargin + margin;

  /// Total margin based on the relative margin and the fluid margin
  EdgeInsets get horizontalMargin =>
      EdgeInsets.symmetric(horizontal: fullMargin);

  T value<T>({required T watch, T? phone, T? tablet, T? desktop, T? xl}) {
    return LayoutValue(watch: watch, phone: phone, tablet: tablet, desktop: desktop)
        .resolveForLayout(this);
  }

  T resolve<T>(LayoutValue<T> value) {
    return value.resolveForLayout(this);
  }

  double get width => size.width;
  double get height => size.height;
}

class _LayoutPlatformState extends State<LayoutPlatform> {
  final Key _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    final LayoutPlatformFormat format = widget.format ?? PortraitLayoutFormat();
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size size = constraints.biggest;

        final MediaQueryData mediaQuery = MediaQuery.maybeOf(context) ??
            MediaQueryData.fromView(
              View.of(context),
            );
        final visualDensity = format.visualDensity(context);
        final LayoutPlatformData data = format.resolve(size, mediaQuery, visualDensity);
        return _LayoutPlatformInheritedWidget(
          key: _key,
          child: widget.child,
          data: data,
        );
      },
    );
  }
}

class _LayoutPlatformInheritedWidget extends InheritedWidget {
  final LayoutPlatformData data;

  _LayoutPlatformInheritedWidget({
    Key? key,
    required this.data,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_LayoutPlatformInheritedWidget oldWidget) {
    return oldWidget.data.size != data.size;
  }
}

extension LayoutBuildContext on BuildContext {
  LayoutPlatformData get layout => LayoutPlatform.of(this);
  LayoutPlatformBreakpoint get breakpoint => LayoutPlatform.of(this).breakpoint;
}
