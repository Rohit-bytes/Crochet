import 'package:get/get.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _auth = AuthService();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 2), () {
      if (_auth.currentUser != null) {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });
  }
}
