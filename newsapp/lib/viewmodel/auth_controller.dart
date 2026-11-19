import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/main.dart';
import 'package:TrustLens/model/userDetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  User? get user => supabase.auth.currentUser;

  // ================= LOGIN =================

  String? emailError;
  String? passwordError;

  bool isobsecure = true;

  void isobsecurecheck() {
    isobsecure = !isobsecure;
    update();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading = true;
      update();

      final response = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user != null) {
        await getUserDetails();

        Get.offAllNamed(AppRoutes.landingpage);
      }
    } on AuthException catch (e) {
      print(e);
      Get.snackbar(
        "Login Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loginCheck(String email, String password) async {
    emailError = null;
    passwordError = null;

    bool isValid = true;

    // Email
    if (email.trim().isEmpty) {
      emailError = "Email is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email.trim())) {
      emailError = "Enter a valid email address";
      isValid = false;
    }

    // Password
    if (password.isEmpty) {
      passwordError = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      passwordError = "Password must be at least 6 characters";
      isValid = false;
    }

    update();

    if (!isValid) {
      return;
    }

    await loginUser(email, password);
  }

  // ================= SIGNUP CONTROLLERS =================

  TextEditingController regnamecontrol = TextEditingController();
  TextEditingController regEnrollNumcontrol = TextEditingController();
  TextEditingController regEmailcontrol = TextEditingController();
  TextEditingController regaddcontrol = TextEditingController();
  TextEditingController regpasscontrol = TextEditingController();
  TextEditingController regreppasscontrol = TextEditingController();
  String gender = '';

  void toggleGender(String value) {
    gender = value;
    update();
  }
  // ================= SIGNUP ERRORS =================

  String? nameError;
  String? enrollNoError;
  String? signupEmailError;
  String? signupPasswordError;
  String? confirmPasswordError;
  String? gendererror;

  // ================= SIGNUP VALIDATION =================

  Future<void> signupCheck(
    String name,
    String enrollno,
    String email,
    String password,
    String repPassword,
    String gender,
  ) async {
    // Clear previous errors
    nameError = null;
    enrollNoError = null;
    signupEmailError = null;
    signupPasswordError = null;
    confirmPasswordError = null;
    gendererror = null;

    bool isValid = true;

    // Name validation
    if (name.trim().isEmpty) {
      nameError = "Name is required";
      isValid = false;
    } else if (name.trim().length < 3) {
      nameError = "Name must be at least 3 characters";
      isValid = false;
    }

    // Enrollment number validation
    if (enrollno.trim().isEmpty) {
      enrollNoError = "Enrollment number is required";
      isValid = false;
    }
    // gender nvalidation
    if (gender.trim().isEmpty) {
      enrollNoError = "Gender is required";
      isValid = false;
    }

    // Email validation
    if (email.trim().isEmpty) {
      signupEmailError = "Email is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email.trim())) {
      signupEmailError = "Enter a valid email address";
      isValid = false;
    } else if (!email.trim().toLowerCase().endsWith('@bvicam.in')) {
      signupEmailError = "Use your BVICAM email address";
      isValid = false;
    }

    // Password validation
    if (password.isEmpty) {
      signupPasswordError = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      signupPasswordError = "Password must be at least 6 characters";
      isValid = false;
    }

    // Confirm password validation
    if (repPassword.isEmpty) {
      confirmPasswordError = "Please confirm your password";
      isValid = false;
    } else if (password != repPassword) {
      confirmPasswordError = "Passwords do not match";
      isValid = false;
    }

    // Update UI
    update();

    // Don't signup if validation failed
    if (!isValid) {
      return;
    }

    await signUpUser(name, email, password, repPassword, gender);
  }

  String get enrollmentNumber {
    return user?.userMetadata?['enrollNumber']?.toString() ?? '';
  }

  // ================= SUPABASE TEACHER SIGNUP =================

  Future<void> signUpUser(
    String name,
    String email,
    String password,
    String repPassword,
    String gender,
  ) async {
    try {
      isLoading = true;
      update();

      // Create Auth user
      final response = await supabase.auth.signUp(
        email: email.trim(),
        password: password,
      );

      final user = response.user;

      if (user == null) {
        return;
      }

      // Create profile separately
      await supabase.from("profiles").insert({
        'id': user.id,
        'name': name.trim(),
        'email': email.trim(),
        'gender': gender,
      });
      await getUserDetails();

      Get.offAllNamed(AppRoutes.landingpage);
    } on AuthException catch (e) {
      Get.snackbar(
        "Signup Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
    } catch (e) {
      print(e);
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  //get user data
  UserDetails? userDetails;

  Future<void> getUserDetails() async {
    final user = supabase.auth.currentUser;

    if (user == null) return;

    try {
      // First check student profile
      final studentResponse = await supabase
          .from('student_profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (studentResponse != null) {
        userDetails = UserDetails.fromMap(studentResponse);
        update();
        return;
      }

      // If not student, check teacher profile
      final teacherResponse = await supabase
          .from('teacher_profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (teacherResponse != null) {
        userDetails = UserDetails.fromMap(teacherResponse);
        update();
        return;
      }

      print("Profile not found");
      // Get.toNamed(AppRoutes.chooserole);
    } catch (e) {
      print("Error getting user details: $e");
    }
  }
}
