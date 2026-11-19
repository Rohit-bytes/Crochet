import 'package:get/get.dart';
import '../../modules/splash/splash_screen.dart';
import '../../modules/auth/login_screen.dart';
import '../../modules/auth/register_screen.dart';
import '../../modules/home/home_screen.dart';

class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
