import 'dart:typed_data';

import 'package:crochet/view/service/homepage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomepageController extends GetxController {
  List<dynamic> cats = [];
  PageController pagecontroller = PageController();
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();

    getCats();
  }

  Future<void> getCats() async {
    try {
      isLoading = true;
      update();

      cats = await getCatsapi();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  int bottomnavigationindex = 0;

  void changeindex(int i) {
    bottomnavigationindex = i;

    pagecontroller.animateToPage(
      i,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    print(bottomnavigationindex);

    update();
  }

  Future<void> downloadImage(BuildContext context, String url) async {
    try {
      print("Downloading $url");

      // permissions
      await Permission.storage.request();
      await Permission.photos.request();

      // writable temp directory
      final dir = await getTemporaryDirectory();

      print("Directory: ${dir.path}");

      // full file path
      final filePath =
          "${dir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";

      print("FilePath: $filePath");

      // download
      await Dio().download(url, filePath);

      // save to gallery
      await GallerySaver.saveImage(filePath);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Image Downloaded")));
    } catch (e) {
      print(e);
    }
  }
}
