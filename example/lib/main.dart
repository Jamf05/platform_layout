import 'package:example/layout_bar.dart';
import 'package:flutter/material.dart';
import 'package:platform_layout/layout.dart';

import 'example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      return LayoutPlatform(
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                color: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.grey[200],
              primarySwatch: Colors.blue,
            ),
            builder: (context, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: child!),
                  LayoutBar(),
                ],
              );
            },
            home: MyHomePage(title: 'Layout')),
      );
    });
  }
}
