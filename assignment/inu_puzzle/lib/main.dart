import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inu_puzzle/core/service/audio_service.dart';
import 'package:inu_puzzle/view/home/home_screen.dart';
import 'package:inu_puzzle/viewmodel/puzzlecontroller.dart';

void main() {
  Get.put(Puzzlecontroller());
  Get.put(AudioService(), permanent: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      title: 'Pawzle',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}
