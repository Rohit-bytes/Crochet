import 'package:TrustLens/core/app_binding.dart';
import 'package:TrustLens/core/app_pages.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/app_text.dart';
import 'package:TrustLens/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Supabase.initialize(
    url: AppText.supabaseUrl,
    publishableKey: AppText.supabasePublishableUrl,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,

          title: 'Trust Lens',
          initialRoute: AppRoutes.splash,
          getPages: AppPages.pages,
          theme: AppTheme.lightTheme,
          initialBinding: AppBindings(),
        );
      },
    ),
  );
}
