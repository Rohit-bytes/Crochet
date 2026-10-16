import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  final List<String> loadingSlogans = [
    "Arranging Your Sheets",
    "Getting Classroom Ready",
    "Preparing Your Classroom",
    "Setting Up Attendance",
    "Checking Your Schedule",
    "Loading Your Classes",
    "Organizing Your Classes",
    "Preparing Today’s Session",
    "Getting Things Ready",
    "Setting Up Class",
    "Fetching Class Details",
    "Syncing Your Attendance",
    "Preparing Your Dashboard",
    "Loading Student Details",
    "Getting Students Ready",
    "Starting Your Class",
    "Almost Ready Now",
    "Making Things Simple",
    "Keeping Classes Organized",
    "Building Better Attendance",
  ];

  Timer? _timer;
  int currentIndex = 0;

  String currentSlogan = "";

  @override
  void onInit() {
    super.onInit();

    currentSlogan = loadingSlogans[0];

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      currentIndex++;

      if (currentIndex >= loadingSlogans.length) {
        currentIndex = 0;
      }

      currentSlogan = loadingSlogans[currentIndex];

      update(); // Rebuilds GetBuilder
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  bool rememberMe = false;

  void rememberMecheck() {
    rememberMe = !rememberMe;
    update();
  }
}
