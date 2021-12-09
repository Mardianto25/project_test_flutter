import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:project_belajar/page/home_page.dart';

void main() {
  // BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
