import 'package:flutter/material.dart';
import 'package:platform_layout/layout.dart';

class LayoutBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final layout = context.layout;
    return Theme(
      data: ThemeData.dark(),
      child: Material(
        child: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  '${layout.size}',
                  maxLines: 1,
                ),
              ),
              Expanded(
                child: Text(
                  'Breakpoint: ${layout.breakpoint.name}',
                  maxLines: 1,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
