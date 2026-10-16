import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:TrustLens/viewmodel/subject_controller.dart';
import 'package:get/get.dart';

import '../viewmodel/splash_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SplashController>(SplashController(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<HomeController>(HomeController(), permanent: true);
    Get.put<SubjectController>(SubjectController(), permanent: true);
  }
}
