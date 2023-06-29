enum LayoutPlatformBreakpoint {
  watch,
  phone,
  tablet,
  desktop,
}

extension PlatformBreakpointExtension on LayoutPlatformBreakpoint {
  LayoutPlatformBreakpoint? get smaller {
    return {
      LayoutPlatformBreakpoint.watch: null,
      LayoutPlatformBreakpoint.phone: LayoutPlatformBreakpoint.watch,
      LayoutPlatformBreakpoint.tablet: LayoutPlatformBreakpoint.phone,
      LayoutPlatformBreakpoint.desktop: LayoutPlatformBreakpoint.tablet,
    }[this];
  }

  LayoutPlatformBreakpoint? get bigger {
    return {
      LayoutPlatformBreakpoint.watch: LayoutPlatformBreakpoint.phone,
      LayoutPlatformBreakpoint.phone: LayoutPlatformBreakpoint.tablet,
      LayoutPlatformBreakpoint.tablet: LayoutPlatformBreakpoint.desktop,
      LayoutPlatformBreakpoint.desktop: null,
    }[this];
  }

  bool get isWatch => LayoutPlatformBreakpoint.watch == this;

  bool get isPhone => LayoutPlatformBreakpoint.phone == this;

  bool get isTablet => LayoutPlatformBreakpoint.tablet == this;

  bool get isDesktop => LayoutPlatformBreakpoint.desktop == this;

  bool operator <(LayoutPlatformBreakpoint breakpoint) =>
      this.index < breakpoint.index;
  bool operator >(LayoutPlatformBreakpoint breakpoint) =>
      this.index > breakpoint.index;
  bool operator <=(LayoutPlatformBreakpoint breakpoint) =>
      this.index <= breakpoint.index;
  bool operator >=(LayoutPlatformBreakpoint breakpoint) =>
      this.index >= breakpoint.index;
}
