import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inu_puzzle/core/service/audio_service.dart';
import 'package:inu_puzzle/view/home/puzzle_pieces.dart';
import 'package:inu_puzzle/view/home/puzzlecomponent.dart';
import 'package:inu_puzzle/viewmodel/puzzlecontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Puzzlecontroller controller = Get.put(Puzzlecontroller());

  @override
  void initState() {
    super.initState();
    Get.find<AudioService>().backgroundMusic();
    controller.getPuzzleImage();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Puzzlecontroller>(
      builder: (puzzlecontroller) {
        if (puzzlecontroller.pieceOrder.isEmpty) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Calculate the piece size dynamically based on screen width
        double boardSize = MediaQuery.of(context).size.width * 0.9;
        double pieceSize = boardSize / puzzlecontroller.gridSize;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              // Top Image Section
              Container(
                height: 150,
                // color: Colors.red,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://i.pinimg.com/originals/9a/a3/5e/9aa35edded370761aff4065510146b56.gif",
                    ),
                    fit: BoxFit.cover,
                  ),
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Puzzlecomponent(width: 100, height: 100),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.find<AudioService>().toggleSound();
                          },
                          child: Obx(
                            () => CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.orange,
                              child: Icon(
                                Get.find<AudioService>().isSoundEnabled.value
                                    ? Icons.music_note
                                    : Icons.music_off,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Spacing between buttons
                        Container(
                          height: 90,
                          width: 90,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white24),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.timer_outlined,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${puzzlecontroller.timeLeft}s",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Puzzle Grid Section
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF0A2540),
                        Color(0xFF134E9B),
                        Color(0xFF0A2540),
                      ],
                      stops: [0.0, 0.5, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    color: Color.fromRGBO(9, 57, 109, 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          border: Border.all(color: Colors.yellow, width: 10),
                        ),
                        child: AbsorbPointer(
                          absorbing:
                              puzzlecontroller.timeLeft == 0 ||
                              puzzlecontroller.isgamestart == false,
                          child: SizedBox(
                            width: boardSize,
                            height: boardSize,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: puzzlecontroller.pieceOrder.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: puzzlecontroller.gridSize,
                                  ),
                              itemBuilder: (context, index) {
                                // 3. Get the shuffled piece ID currently sitting at this index
                                int pieceId =
                                    puzzlecontroller.pieceOrder[index];

                                // 4. Calculate where this chunk of the image targets originally
                                int correctRow =
                                    pieceId ~/ puzzlecontroller.gridSize;
                                int correctCol =
                                    pieceId % puzzlecontroller.gridSize;

                                return PuzzlePiece(
                                  imageUrl: puzzlecontroller.puzzleUrl,
                                  correctRow: correctRow,
                                  correctCol: correctCol,
                                  gridSize: puzzlecontroller.gridSize,
                                  size: pieceSize,
                                  currentIndex: index,
                                  onPieceSwapped: puzzlecontroller.swapPieces,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            height: 105,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: BottomAppBar(
              color: Color.fromRGBO(9, 57, 109, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Grid Size: ${puzzlecontroller.gridSize}x${puzzlecontroller.gridSize}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: IconButton(
                            onPressed: () {
                              puzzlecontroller.resetGame();
                            },
                            icon: const Icon(
                              Icons.refresh,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 10), // Spacing between buttons
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 1.5,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (puzzlecontroller.isPuzzleSolved() == true) {
                                puzzlecontroller.resetGame();
                              } else if (puzzlecontroller.isgamestart ==
                                      false &&
                                  puzzlecontroller.timeLeft > 0) {
                                puzzlecontroller.startGame();
                              } else if (puzzlecontroller.timeLeft <= 0) {
                                puzzlecontroller.resetGame();
                              } else {
                                puzzlecontroller.startGame();
                              }
                            },
                            child: Text(
                              puzzlecontroller.isgamestart
                                  ? 'GAME RUNNING'
                                  : puzzlecontroller.isPuzzleSolved()
                                  ? 'NEXT ROUND'
                                  : 'START GAME',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
