import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inu_puzzle/core/service/audio_service.dart';
import 'package:inu_puzzle/core/service/puzzle_service.dart';
import 'package:inu_puzzle/view/home/reusable_components/custom_game_status.dart';
import 'package:inu_puzzle/view/home/reusable_components/custom_snackbar.dart';

class Puzzlecontroller extends GetxController {
  // Your default fallback image URL
  String puzzleUrl =
      'https://img.freepik.com/free-vector/404-error-web-template-with-cute-dog_23-2147763341.jpg?semt=ais_hybrid&w=740&q=80';

  // Grid properties
  int gridSize = 3; // 3 means a 3x3 grid (9 pieces total)
  List<int> pieceOrder = [];

  void getPuzzleImage() {
    PuzzleService()
        .getRandomDog()
        .then((dogImage) {
          puzzleUrl = dogImage.message;
          // Setup and shuffle the pieces using the newly fetched image

          initializePuzzle();
        })
        .catchError((error) {
          print('Error fetching dog image: $error');
          // Optional fallback: Initialize game even if API fails using default image
          initializePuzzle();
        });
  }

  // Generates positions [0, 1, 2...8] and shuffles them
  void initializePuzzle() {
    pieceOrder = List.generate(gridSize * gridSize, (index) => index);
    pieceOrder.shuffle();
    update(); // Notifies GetBuilder in HomeScreen to rebuild the UI
  }

  // Swaps two pieces in the list when dragged and dropped
  void swapPieces(int srcIndex, int targetIndex) {
    int temp = pieceOrder[srcIndex];
    pieceOrder[srcIndex] = pieceOrder[targetIndex];
    pieceOrder[targetIndex] = temp;
    update(); // Re-render the grid with new positions

    // Check if the user won
    if (isPuzzleSolved()) {
      // You can trigger your success dialog or state change here!
      print("Puzzle Solved successfully!");
      Get.find<AudioService>().win();
      GamePopup.win();
      isgamestart = false;
      stopTimer();
      update(); // Update the UI to reflect the solved state
    }
  }

  // Verifies if every piece is back in its original chronological order
  bool isPuzzleSolved() {
    for (int i = 0; i < pieceOrder.length; i++) {
      if (pieceOrder[i] != i) return false;
    }
    return true;
  }

  Timer? timer;
  int timeLeft = 120; // 2 minutes in seconds
  bool timeisabouttoUp = false;
  void toggleTimeWarning() {
    timeisabouttoUp = !timeisabouttoUp;
    update();
  }

  void timerfor2minutes() {
    // Implement your timer logic here
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        timeLeft--;
        if (timeLeft == 37) {
          Get.find<AudioService>().timeisabouttoUp();
          toggleTimeWarning();
        }
        update(); // Update the UI with the new time
      } else {
        timer.cancel();
        // Handle what happens when the timer runs out
        print("Time's up!");
        Get.find<AudioService>().lose();
        GamePopup.timeUp();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void resetGame() {
    timeLeft = 120; // Reset timer to 2 minutes
    stopTimer(); // Stop any existing timer
    getPuzzleImage(); // Fetch a new image and reset the puzzle
    isgamestart = false;
    update(); // Update the UI to reflect the reset state
  }

  void resetsameGame() {
    timeLeft = 120; // Reset timer to 2 minutes
    stopTimer(); // Stop any existing timer
    isgamestart = false;
    update(); // Update the UI to reflect the reset state
  }

  bool isgamestart = false;
  void startGame() {
    Get.find<AudioService>().backgroundMusic();
    isgamestart = true;
    timerfor2minutes();
    update();
  }

  void tryagain() {
    if (timeLeft <= 0) {
      isgamestart = false;
      resetsameGame();
    } else {
      isgamestart = true;
      update();
    }
  }
}
