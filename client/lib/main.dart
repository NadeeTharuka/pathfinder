import 'package:client/screens/home.dart';
import 'package:client/screens/navigation.dart';
import 'package:client/screens/roam.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart'; // Add this line

void main() {
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, // Enables it only in debug mode
      builder: (context) => const MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pathfinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      useInheritedMediaQuery: true, // Necessary for DevicePreview
      locale: DevicePreview.locale(context), // Adds locale preview
      builder: DevicePreview.appBuilder, // Wraps app with DevicePreview
      home: const HomeScreen(),
      routes: {
        '/roam_mode': (context) => const RoamScreen(),
        '/navigation_mode': (context) => Navigation(),
      },
    );
  }
}
