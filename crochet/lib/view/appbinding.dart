import 'package:crochet/viewmodel/homecontrollers/homepage_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomepageController());
  }
}
