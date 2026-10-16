import 'dart:typed_data';

import 'package:TrustLens/auth/custom_widgets/custom_snackbar.dart';
import 'package:TrustLens/core/app_routes.dart';
import 'package:TrustLens/core/color_pallete.dart';
import 'package:TrustLens/main.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

class HomeController extends GetxController {
  //greeting
  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning ☀️';
    } else if (hour < 17) {
      return 'Good Afternoon 🌤️';
    } else if (hour < 21) {
      return 'Good Evening 🌇';
    } else {
      return 'Good Evening 🌙';
    }
  }

  int currentIndex = 0;

  List<Map<String, dynamic>> courses = [];
  List<Map<String, dynamic>> semester = [];
  List<Map<String, dynamic>> classes = [];

  @override
  void onInit() {
    super.onInit();
    getCourses();
    getSemester();
    getClasses();
    listenToClasses();
    fetchAllStudent();
  }

  @override
  void onClose() {
    supabase.removeChannel(classChannel);
    super.onClose();
  }

  PageController pageController = PageController();
  // Bottom navigation
  void changeIndex(int index) {
    currentIndex = index;

    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    update();
  }

  Future<void> getCourses() async {
    try {
      final response = await supabase.from('courses').select();

      courses = List<Map<String, dynamic>>.from(response);

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> getSemester() async {
    try {
      final response = await supabase.from('Semester').select();

      semester = List<Map<String, dynamic>>.from(response);

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  Future<void> getClasses() async {
    try {
      final response = await supabase
          .from('new_class')
          .select()
          .order('created_at', ascending: false);

      classes = List<Map<String, dynamic>>.from(response);
      print("class ${classes}");

      update();
    } catch (e) {
      print('ERROR: $e');
    }
  }

  late final RealtimeChannel classChannel;

  void listenToClasses() {
    classChannel = supabase
        .channel('new_class_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'new_class',
          callback: (payload) {
            print("Class table changed: ${payload.eventType}");

            getClasses();
          },
        )
        .subscribe();
  }

  bool isloading = false;
  String? finalcourseName, finalsemesterName;
  TextEditingController classNamecontrol = TextEditingController();
  Future<void> addnewclass(
    String courseName,
    String semesterName,
    String className,
  ) async {
    try {
      isloading = true;
      update();
      final newClass = await supabase
          .from('new_class')
          .insert({
            'course': courseName,
            'semester': semesterName,
            'class_name': className,
          })
          .select()
          .single();
      // CustomSnackbar.success(title: "Class created", message: "Succesfully");
      // finalcourseName = "";
      // finalsemesterName = "";
      // classNamecontrol.clear();

      Get.toNamed(AppRoutes.addclasssuccesful, arguments: newClass);
    } catch (e) {
      print(e);
      CustomSnackbar.error(
        title: "Class not created",
        message: "error while creating class",
      );
    } finally {
      isloading = false;
      update();
    }
  }

  String? courseError;
  String? semesterError;
  String? classNameError;

  void clearErrors() {
    courseError = null;
    semesterError = null;
    classNameError = null;
    update();
  }

  bool validateClassForm() {
    courseError = null;
    semesterError = null;
    classNameError = null;

    bool isValid = true;

    if (finalcourseName == null || finalcourseName!.isEmpty) {
      courseError = "Please select a course";
      isValid = false;
    }

    if (finalsemesterName == null || finalsemesterName!.isEmpty) {
      semesterError = "Please select a semester";
      isValid = false;
    }

    if (classNamecontrol.text.trim().isEmpty) {
      classNameError = "Class name cannot be empty";
      isValid = false;
    }

    update();

    return isValid;
  }

  IconData getCourseIcon(String? course) {
    switch (course) {
      case "MCA":
        return Icons.school;

      case "BTECH":
        return Icons.note;

      default:
        return Icons.people;
    }
  }

  Color getCourseColor(String? course) {
    switch (course) {
      case "MCA":
        return ColorPalette.orange;

      case "BTECH":
        return ColorPalette.Green;

      default:
        return ColorPalette.accent;
    }
  }

  //class tab

  int tabIndex = 0;
  void tabchange(int index) {
    tabIndex = index;
    update();
  }

  // excel file picker

  Future<void> pickexcelfile() async {
    // Pick a single file.
    final PlatformFile? file = await FilePicker.pickFile();
    if (file != null) {
      print('Picked ${file.name} (${await file.length()} bytes).');
    }

    // Pick multiple files, filtered by extension.
    final List<PlatformFile> images = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png', 'jpg'],
    );
    print('Picked ${images.length} image(s).');

    // Pick a directory.
    final String? directoryPath = await FilePicker.getDirectoryPath();
    print('Picked directory: $directoryPath');
  }

  //fetch all student
  List<Map<String, dynamic>> students = [];

  Future<void> fetchAllStudent() async {
    try {
      final response = await supabase.from('student_profiles').select();

      students = List<Map<String, dynamic>>.from(response);

      // print("Total students: ${students.length}");
      // print(students);

      update(); // If using GetBuilder
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  Future<void> deleteClass(String classId) async {
    try {
      await supabase.from('class_subject').delete().eq('class_id', classId);
      await supabase.from('new_class').delete().eq('id', classId);
      await getClasses();

      CustomSnackbar.success(
        title: "Class deleted",
        message: "Class deleted successfully",
      );

      update(); // If using GetBuilder
    } catch (e) {
      print("Error deleting class: $e");
    }
  }
}
