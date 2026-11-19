import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/constants/app_text.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';

final supabase = Supabase.instance.client;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: AppText.supabaseUrl,
    anonKey: AppText.supabasePublishableKey,
  );
  runApp(const TrustApp());
}

class TrustApp extends StatelessWidget {
  const TrustApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
