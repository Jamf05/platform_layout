import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:platform_layout/src/layout.dart';

import 'breakpoint.dart';

mixin LayoutValueMixin<T> {
  T resolveForLayout(LayoutPlatformContext layout);

  T resolve(BuildContext context) {
    final layout = LayoutPlatform.of(context);
    return resolveForLayout(layout);
  }
}

typedef LayoutValueBuilder<T> = T Function(LayoutPlatformContext layout);

/// A responsive value that adapts dynamically to the width of the screen.
///
/// The `valueBuilder` callback returns the responsive value for a given container
/// width.
///
/// ```
/// final isTablet = FluidValue.fromWidth((containerWidth) {
///     return containerWidth >= 600;
/// });
/// ```
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given width screen use the method `resolveForWidth`.
/// If there is a [Layout] inside the widget you can also use `resolveForContext`
/// that will automatically calulate the value for the container width provided by
/// the closest Layout inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
abstract class LayoutValue<T> with LayoutValueMixin<T> {
  factory LayoutValue({
    required T watch,
    T? phone,
    T? tablet,
    T? desktop,
  }) = BreakpointValue<T>;
  factory LayoutValue.builder(LayoutValueBuilder<T> builder) =
      _DefaultLayoutValue<T>;
  factory LayoutValue.value(T value) = ConstantLayoutValue<T>;

  static const screenWidth = _ScreenWidthValue();
}

abstract class BaseLayoutValue<T> implements LayoutValue<T> {
  const BaseLayoutValue();

  T resolve(BuildContext context) {
    final layout = LayoutPlatform.of(context);
    return resolveForLayout(layout);
  }
}

class _DefaultLayoutValue<T> extends BaseLayoutValue<T> {
  final LayoutValueBuilder<T> builder;
  const _DefaultLayoutValue(this.builder);

  @override
  T resolveForLayout(LayoutPlatformContext layout) => builder(layout);
}

/// A responsive value that adapts dynamically dinamically to relative width
/// screen breakpoints
///
/// ```
/// final cellCount = BreakpointValue(watch: 1, s: 2, phone: 4, desktop: 20);
/// ```
///
/// This class is not usually used directly and if you are using [Layout],
/// it is recommended to use the `context.layout.value(watch: 1, s: 2, phone: 4, desktop: 20);`
/// to get directly the responsive value.
///
/// Calculating the responsive values is usually done by this library automatically
/// but it can also be calculated with the following methods:
/// To get the value for a given breakpoint use the method `resolveForBreakpoint`.
/// If there is a [Layout] inside the widget you can also use `resolve(context)`
/// that will automatically calulate the value for the container width provided by
/// the closest `Layout` inside the upper widget tree from the `context` referenced
/// provided as param.
///
/// See also:
///   - [BreakpointValue], a value that adapts dinamically to relative width
///     screen breakpoints
class BreakpointValue<T> extends BaseLayoutValue<T> {
  final T watch;
  final T? phone;
  final T? tablet;
  final T? desktop;

  const BreakpointValue({
    required this.watch,
    this.phone,
    this.tablet,
    this.desktop,
  });

  const BreakpointValue.all({
    required T watch,
    required T phone,
    required T tablet,
    required T desktop,
  })  : this.watch = watch,
        this.phone = phone,
        this.tablet = tablet,
        this.desktop = desktop;

  BreakpointValue.fromMap(Map<LayoutPlatformBreakpoint, T> values, [T? defaultValue])
      : assert(
            values.length == LayoutPlatformBreakpoint.values.length ||
                defaultValue != null,
            'A default value is required if there is not a value asigned to a breakpoint inside the map'),
        this.watch = values[LayoutPlatformBreakpoint.watch] ?? defaultValue!,
        this.phone = values[LayoutPlatformBreakpoint.phone],
        this.tablet = values[LayoutPlatformBreakpoint.tablet],
        this.desktop = values[LayoutPlatformBreakpoint.desktop];

  T resolveForBreakpoint(LayoutPlatformBreakpoint breakpoint) {
    switch (breakpoint) {
      case LayoutPlatformBreakpoint.watch:
        return watch;
      case LayoutPlatformBreakpoint.phone:
        return phone ?? watch;
      case LayoutPlatformBreakpoint.tablet:
        return tablet ?? phone ?? watch;
      case LayoutPlatformBreakpoint.desktop:
        return desktop ?? tablet ?? phone ?? watch;
    }
  }

  @override
  T resolveForLayout(LayoutPlatformContext layout) {
    return resolveForBreakpoint(layout.breakpoint);
  }
}

class ConstantLayoutValue<T> extends BaseLayoutValue<T> {
  final T value;

  const ConstantLayoutValue(this.value);

  @override
  T resolveForLayout(LayoutPlatformContext layout) => value;
}

class _ScreenWidthValue extends BaseLayoutValue<double> {
  const _ScreenWidthValue();

  @override
  double resolveForLayout(LayoutPlatformContext layout) => layout.width;
}
