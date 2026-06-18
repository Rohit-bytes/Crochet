import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black87,
    IconData icon = Icons.info,
    SnackPosition position = SnackPosition.TOP,
  }) {
    Get.closeAllSnackbars();

    Get.rawSnackbar(
      snackPosition: position,
      backgroundColor: backgroundColor,
      borderRadius: 16,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      duration: const Duration(seconds: 3),
      messageText: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void success(String message) {
    show(
      title: 'Success',
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  static void error(String message) {
    show(
      title: 'Error',
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  static void warning(String message) {
    show(
      title: 'Warning',
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_amber_rounded,
    );
  }
}
