import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:platform_layout/layout.dart';

void main() {
  test('Width Value', () {
    final LayoutValue<double> responsiveValue =
        LayoutValue.builder((layout) {
      return layout.width;
    });
    final context = LayoutPlatformContext(
      size: Size(100, 0),
      breakpoint: LayoutPlatformBreakpoint.tablet,
      devicePixelRatio: 1,
    );
    final value = responsiveValue.resolveForLayout(context);
    expect(value, context.width);
  });

  test('Layout Value - breakpointBuilder', () {
    final LayoutValue<LayoutPlatformBreakpoint> responsiveValue =
        LayoutValue.builder((layout) {
      return layout.breakpoint;
    });
    // Check validity for all breakpoints
    for (final breakpoint in LayoutPlatformBreakpoint.values) {
      final context = LayoutPlatformContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Breakpoint Value - builder', () {
    final LayoutValue<LayoutPlatformBreakpoint> responsiveValue =
        LayoutValue.builder((context) {
      return context.breakpoint;
    });

    // Check validity for all breakpoints
    for (final breakpoint in LayoutPlatformBreakpoint.values) {
      final context = LayoutPlatformContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Const value', () {
    final ConstantLayoutValue<double> responsiveValue = ConstantLayoutValue(0);
    // Check validity for all breakpoints
    final context = LayoutPlatformContext(
      size: Size(100, 0),
      breakpoint: LayoutPlatformBreakpoint.watch,
      devicePixelRatio: 1,
    );
    expect(responsiveValue.resolveForLayout(context), 0);
  });
  test('LayoutValue.fromBreakpoint', () {
    final LayoutValue<LayoutPlatformBreakpoint> responsiveValue = LayoutValue(
      watch: LayoutPlatformBreakpoint.watch,
      phone: LayoutPlatformBreakpoint.phone,
      tablet: LayoutPlatformBreakpoint.tablet,
      desktop: LayoutPlatformBreakpoint.desktop,
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutPlatformBreakpoint.values) {
      final context = LayoutPlatformContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('BreakpointValue.all', () {
    final BreakpointValue<LayoutPlatformBreakpoint> responsiveValue =
        BreakpointValue.all(
      watch: LayoutPlatformBreakpoint.watch,
      phone: LayoutPlatformBreakpoint.phone,
      tablet: LayoutPlatformBreakpoint.tablet,
      desktop: LayoutPlatformBreakpoint.desktop,
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutPlatformBreakpoint.values) {
      final context = LayoutPlatformContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });

  test('Breakpoint Value - map', () {
    final BreakpointValue<LayoutPlatformBreakpoint> responsiveValue =
        BreakpointValue.fromMap(
      Map.fromIterable(LayoutPlatformBreakpoint.values,
          key: (value) => value, value: (value) => value),
    );
    // Check validity for all breakpoints
    for (final breakpoint in LayoutPlatformBreakpoint.values) {
      final context = LayoutPlatformContext(
        size: Size(100, 0),
        breakpoint: breakpoint,
        devicePixelRatio: 1,
      );
      final value = responsiveValue.resolveForLayout(context);
      expect(value, breakpoint);
    }
  });
}
