import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_layout/layout.dart';

typedef LayoutWidgetBuilder = Widget Function(
  BuildContext context,
  LayoutPlatformContext layout,
  Widget? child,
);

class PlatformBuilder extends StatelessWidget {
  final LayoutValue<WidgetBuilder> child;

  PlatformBuilder({
    Key? key,
    required WidgetBuilder watch,
    WidgetBuilder? phone,
    WidgetBuilder? tablet,
    WidgetBuilder? desktop,
    WidgetBuilder? xl,
  })  : this.child = BreakpointValue(
            watch: watch, phone: phone, tablet: tablet, desktop: desktop),
        super(key: key);

  PlatformBuilder.builder({
    Key? key,
    required LayoutWidgetBuilder builder,
    Widget? child,
  })  : this.child = LayoutValue.builder((layoutContext) {
          return (context) => builder(context, layoutContext, child);
        }),
        super(key: key);

  const PlatformBuilder.raw({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.layout.resolve(child)(context);
  }
}
