import 'package:flutter_test/flutter_test.dart';
import 'package:platform_layout/layout.dart';

void main() {
  group('Breakpoints: ', () {
    test('watch is smaller than phone', () {
      expect(LayoutPlatformBreakpoint.watch < LayoutPlatformBreakpoint.phone, true);
      expect(LayoutPlatformBreakpoint.watch > LayoutPlatformBreakpoint.phone, false);
    });
    test('phone is smaller than tablet', () {
      expect(LayoutPlatformBreakpoint.phone < LayoutPlatformBreakpoint.tablet, true);
      expect(LayoutPlatformBreakpoint.phone > LayoutPlatformBreakpoint.tablet, false);
    });
    test('tablet is smaller than desktop', () {
      expect(LayoutPlatformBreakpoint.tablet < LayoutPlatformBreakpoint.desktop, true);
      expect(LayoutPlatformBreakpoint.tablet > LayoutPlatformBreakpoint.desktop, false);
    });
    test('tablet is smaller than desktop', () {
      expect(LayoutPlatformBreakpoint.desktop < LayoutPlatformBreakpoint.watch, true);
      expect(LayoutPlatformBreakpoint.desktop > LayoutPlatformBreakpoint.watch, false);
    });
    test('bool getters', () {
      expect(LayoutPlatformBreakpoint.watch.isWatch, true);
      expect(LayoutPlatformBreakpoint.phone.isPhone, true);
      expect(LayoutPlatformBreakpoint.tablet.isTablet, true);
      expect(LayoutPlatformBreakpoint.desktop.isDesktop, true);
    });

    test('bool getters', () {
      expect(LayoutPlatformBreakpoint.watch.isWatch, true);
      expect(LayoutPlatformBreakpoint.phone.isPhone, true);
      expect(LayoutPlatformBreakpoint.tablet.isTablet, true);
      expect(LayoutPlatformBreakpoint.desktop.isDesktop, true);
    });

    test('bigger method', () {
      LayoutPlatformBreakpoint breakpoint = LayoutPlatformBreakpoint.watch;
      while (breakpoint.bigger != null) {
        expect(breakpoint < breakpoint.bigger!, true);
        breakpoint = breakpoint.bigger!;
      }
    });
    test('smaller method', () {
      LayoutPlatformBreakpoint breakpoint = LayoutPlatformBreakpoint.watch;
      while (breakpoint.smaller != null) {
        expect(breakpoint > breakpoint.smaller!, true);
        breakpoint = breakpoint.smaller!;
      }
    });

    test('enum is sorted', () {
      final breakpoints = LayoutPlatformBreakpoint.values;
      final reversed = LayoutPlatformBreakpoint.values.reversed.toList();
      for (int index = 0; index < breakpoints.length - 1; index++) {
        expect(breakpoints[index] < breakpoints[index + 1], true);
      }
      for (int index = 0; index < reversed.length - 1; index++) {
        expect(reversed[index] > reversed[index + 1], true);
      }
    });
  });
}
