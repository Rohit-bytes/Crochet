import 'package:TrustLens/auth/custom_widgets/custom_button_two.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/main.dart';
import 'package:TrustLens/viewmodel/auth_controller.dart';
import 'package:TrustLens/viewmodel/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authController) {
        final user = authController.userDetails;
        final bool student = authController.isStudent == true;

        // -----------------------------------------
        // Loading state
        // -----------------------------------------

        if (user == null) {
          return Scaffold(
            backgroundColor: ColorPalette.background,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          backgroundColor: ColorPalette.background,

          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =====================================================
                  // PROFILE HEADER
                  // =====================================================
                  Center(
                    child: Column(
                      children: [
                        // Profile image
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 105.w,
                              height: 105.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: student
                                    ? ColorPalette.success.withOpacity(0.10)
                                    : ColorPalette.primary.withOpacity(0.10),
                              ),
                              child: Center(
                                child: Icon(
                                  student
                                      ? Icons.person_rounded
                                      : Icons.school_rounded,
                                  size: 52.sp,
                                  color: student
                                      ? ColorPalette.success
                                      : ColorPalette.primary,
                                ),
                              ),
                            ),

                            // Camera button
                            Positioned(
                              right: -2.w,
                              bottom: 2.h,
                              child: Container(
                                width: 34.w,
                                height: 34.w,
                                decoration: BoxDecoration(
                                  color: ColorPalette.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorPalette.background,
                                    width: 3,
                                  ),
                                ),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  size: 17.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 14.h),

                        // Name
                        Text(
                          user.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 23.sp,
                            fontWeight: FontWeight.w800,
                            color: ColorPalette.textPrimary,
                          ),
                        ),

                        SizedBox(height: 5.h),

                        // Email
                        Text(
                          user.email,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: ColorPalette.textSecondary,
                          ),
                        ),

                        SizedBox(height: 11.h),

                        // Role
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            color: student
                                ? ColorPalette.success.withOpacity(0.12)
                                : ColorPalette.primary.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                student
                                    ? Icons.person_rounded
                                    : Icons.school_rounded,
                                size: 17.sp,
                                color: student
                                    ? ColorPalette.success
                                    : ColorPalette.primary,
                              ),

                              SizedBox(width: 7.w),

                              Text(
                                student ? 'Student' : 'Teacher',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: student
                                      ? ColorPalette.success
                                      : ColorPalette.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // =====================================================
                  // PERSONAL INFORMATION
                  // =====================================================
                  _sectionCard(
                    title: 'Personal Information',
                    icon: Icons.person_outline_rounded,
                    children: [
                      _infoRow(
                        icon: Icons.person_outline_rounded,
                        title: 'Full Name',
                        value: user.name,
                      ),

                      _divider(),

                      _infoRow(
                        icon: Icons.email_outlined,
                        title: 'Email Address',
                        value: user.email,
                      ),

                      _divider(),

                      if (student) ...[
                        // -------------------------
                        // STUDENT
                        // -------------------------

                        _infoRow(
                          icon: Icons.badge_outlined,
                          title: 'Enrollment No',
                          value: _valueOrFallback(user.enrollmentNumber),
                        ),
                      ] else ...[
                        // -------------------------
                        // TEACHER
                        // -------------------------

                        _infoRow(
                          icon: Icons.badge_outlined,
                          title: 'Employee ID',
                          value: _valueOrFallback(user.enrollmentNumber),
                        ),
                      ],

                      _divider(),

                      _infoRow(
                        icon: Icons.phone_outlined,
                        title: 'Phone Number',
                        value: 'Not available',
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),

                  // =====================================================
                  // ACCOUNT SETTINGS
                  // =====================================================
                  _sectionCard(
                    title: 'Account Settings',
                    icon: Icons.settings_outlined,
                    children: [
                      _settingTile(
                        icon: Icons.edit_outlined,
                        title: 'Edit Profile',
                        onTap: () {
                          // TODO
                        },
                      ),

                      _divider(),

                      _settingTile(
                        icon: Icons.lock_outline_rounded,
                        title: 'Change Password',
                        onTap: () {
                          // TODO
                        },
                      ),

                      _divider(),

                      _settingTile(
                        icon: Icons.palette_outlined,
                        title: 'App Theme',
                        onTap: () {
                          // TODO
                        },
                      ),

                      _divider(),

                      _settingTile(
                        icon: Icons.help_outline_rounded,
                        title: 'Help & Support',
                        onTap: () {
                          // TODO
                        },
                      ),

                      _divider(),

                      _settingTile(
                        icon: Icons.info_outline_rounded,
                        title: 'About App',
                        onTap: () {
                          // TODO
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // =====================================================
                  // LOGOUT
                  // =====================================================
                  CustomButtonTwo(
                    prefixwidget: Icon(
                      Icons.logout_rounded,
                      color: ColorPalette.error,
                      size: 19.sp,
                    ),
                    radius: 15,
                    title: ' Logout',
                    callback: () async {
                      await _logout();
                    },
                    textColor: ColorPalette.error,
                    color: Color.lerp(ColorPalette.error, Colors.white, 0.8),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // LOGOUT
  // ============================================================

  static Future<void> _logout() async {
    try {
      await supabase.auth.signOut();

      if (Get.isRegistered<HomeController>()) {
        final homeController = Get.find<HomeController>();

        homeController.changeIndex(0);
      }

      Get.offAllNamed(AppRoutes.chooserole);
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        'Something went wrong while logging out.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorPalette.error,
        colorText: Colors.white,
        margin: EdgeInsets.all(15.r),
      );
    }
  }

  // ============================================================
  // SAFE VALUE
  // ============================================================

  static String _valueOrFallback(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Not available';
    }

    return value;
  }

  // ============================================================
  // CIRCLE BUTTON
  // ============================================================

  static Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50.r),
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(icon, size: 20.sp, color: ColorPalette.textPrimary),
      ),
    );
  }

  // ============================================================
  // SECTION CARD
  // ============================================================

  static Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(17.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 23.sp, color: ColorPalette.primary),

              SizedBox(width: 10.w),

              Text(
                title,
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.textPrimary,
                ),
              ),
            ],
          ),

          SizedBox(height: 14.h),

          ...children,
        ],
      ),
    );
  }

  // ============================================================
  // INFORMATION ROW
  // ============================================================

  static Widget _infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 9.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30.w,
            child: Icon(icon, size: 20.sp, color: ColorPalette.textSecondary),
          ),

          SizedBox(width: 8.w),

          Expanded(
            flex: 4,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13.sp,
                color: ColorPalette.textSecondary,
              ),
            ),
          ),

          SizedBox(width: 8.w),

          Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.right,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w600,
                color: ColorPalette.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SETTING TILE
  // ============================================================

  static Widget _settingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 13.h),
        child: Row(
          children: [
            Icon(icon, size: 21.sp, color: ColorPalette.textSecondary),

            SizedBox(width: 13.w),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: ColorPalette.textPrimary,
                ),
              ),
            ),

            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 15.sp,
              color: ColorPalette.textSecondary,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================

  static Widget _divider() {
    return Divider(height: 1, thickness: 0.7, color: Colors.grey.shade200);
  }
}
