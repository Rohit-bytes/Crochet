import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  final List<String> loadingSlogans = [
    "Gathering the Latest Headlines",
    "Exploring Today’s News",
    "Fetching News Stories",
    "Preparing Your News Feed",
    "Discovering New Perspectives",
    "Checking Article Sources",
    "Bringing Stories Into Focus",
    "Uncovering Different Perspectives",
    "Measuring News Credibility",
    "Exploring the Source of Truth",
    "Preparing Your Reading Experience",
    "Organizing News Stories",
    "Comparing Different Perspectives",
    "Examining News Credibility",
    "Understanding Your Trust in News",
    "Preparing the Next Headline",
    "Revealing the Story Behind the Story",
    "Discovering What Shapes Trust",
    "Analyzing News Perceptions",
    "Every Story Has a Source",
    "Looking Beyond the Headlines",
    "Separating Source from Story",
    "Building a Clearer News Experience",
    "Almost Ready to Explore",
    "Your Perspective Matters",
    "See the Source, Measure the Trust",
    "Bringing Transparency to News",
    "Understanding How News Shapes Trust",
    "One Moment, Finding Your Stories",
    "TrustLens Is Getting Things Ready",
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
