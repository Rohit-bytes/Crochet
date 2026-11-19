import 'package:TrustLens/auth/choose_role.dart';
import 'package:TrustLens/auth/login.dart';
import 'package:TrustLens/auth/splash_screen.dart';
import 'package:TrustLens/auth/register.dart';
import 'package:TrustLens/view/add_class/add_classess.dart';
import 'package:TrustLens/view/add_class/attendance_widgets.dart/start_attendance_screen.dart';
import 'package:TrustLens/view/add_class/class_add_succesfully.dart';
import 'package:TrustLens/view/add_class/enter_student_manually.dart';
import 'package:TrustLens/view/add_class/upload_excel_sheet.dart';
import 'package:TrustLens/view/add_subject/add_subject_manually.dart';
import 'package:TrustLens/view/generate_qr/generate_qr_screen.dart';
import 'package:TrustLens/view/landing_page.dart';
import 'package:TrustLens/view/view_all_classes.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.chooserole,
      page: () => const ChooseRole(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.teacherlogin,
      page: () => const TeacherLogin(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const TeacherRegister(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.landingpage,
      page: () => const LandingPage(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.addclass,
      page: () => const AddClassess(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.addclasssuccesful,
      page: () => const ClassAddSuccesfully(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.viewallclasses,
      page: () => const ViewAllClasses(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.uploadexcelsheet,
      page: () => const UploadExcelSheet(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.enterStudentManually,
      page: () => const EnterStudentManually(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.enterSubjectManually,
      page: () => const EnterSubjectManually(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.StartAttendanceScreen,
      page: () => const StartAttendanceScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: AppRoutes.GenerateQrScreen,
      page: () => const GenerateQrScreen(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
