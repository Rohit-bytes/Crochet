import 'package:flutter/material.dart';

class PuzzlePiece extends StatelessWidget {
  final String imageUrl;
  final int correctRow;
  final int correctCol;
  final int gridSize;
  final double size;
  final int currentIndex; // The current position on the board
  final Function(int srcIndex, int targetIndex) onPieceSwapped;

  const PuzzlePiece({
    super.key,
    required this.imageUrl,
    required this.correctRow,
    required this.correctCol,
    required this.gridSize,
    required this.size,
    required this.currentIndex,
    required this.onPieceSwapped,
  });

  @override
  Widget build(BuildContext context) {
    // The visual piece representation
    Widget pieceImage = SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: OverflowBox(
          maxWidth: size * gridSize,
          maxHeight: size * gridSize,
          alignment: Alignment(
            -1 + (2 * correctCol / (gridSize - 1)),
            -1 + (2 * correctRow / (gridSize - 1)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              imageUrl,
              width: size * gridSize,
              height: size * gridSize,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

    // Make the piece interactive using Draggable and DragTarget
    return DragTarget<int>(
      onAcceptWithDetails: (details) {
        // details.data is the currentIndex of the piece being dragged
        onPieceSwapped(details.data, currentIndex);
      },
      builder: (context, candidateData, rejectedData) {
        return Draggable<int>(
          data: currentIndex, // Pass current index as the payload
          feedback: Material(
            elevation: 8.0,
            color: Colors.transparent,
            child: Opacity(opacity: 0.8, child: pieceImage),
          ),
          childWhenDragging: Container(
            width: size,
            height: size,
            color: Colors.grey.shade300, // Placeholder while dragging
          ),
          child: pieceImage,
        );
      },
    );
  }
}

class JigsawPuzzle extends StatefulWidget {
  final String imageUrl;
  final int gridSize; // e.g., 3 for a 3x3 grid

  const JigsawPuzzle({super.key, required this.imageUrl, this.gridSize = 3});

  @override
  State<JigsawPuzzle> createState() => _JigsawPuzzleState();
}

class _JigsawPuzzleState extends State<JigsawPuzzle> {
  late List<int> pieceOrder; // Holds the current layout of pieces

  @override
  void initState() {
    super.initState();
    // Initialize pieces in order: [0, 1, 2, 3...]
    pieceOrder = List.generate(
      widget.gridSize * widget.gridSize,
      (index) => index,
    );
    _shufflePieces();
  }

  void _shufflePieces() {
    setState(() {
      pieceOrder.shuffle();
    });
  }

  void _swapPieces(int srcIndex, int targetIndex) {
    setState(() {
      int temp = pieceOrder[srcIndex];
      pieceOrder[srcIndex] = pieceOrder[targetIndex];
      pieceOrder[targetIndex] = temp;
    });

    // Optional: Check if the puzzle is solved here
    if (_isSolved()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Congratulations! Puzzle Solved! 🎉')),
      );
    }
  }

  bool _isSolved() {
    for (int i = 0; i < pieceOrder.length; i++) {
      if (pieceOrder[i] != i) return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically calculate individual piece size based on screen width
    double boardSize = MediaQuery.of(context).size.width * 0.9;
    double pieceSize = boardSize / widget.gridSize;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: boardSize,
          height: boardSize,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.gridSize,
            ),
            itemCount: pieceOrder.length,
            itemBuilder: (context, index) {
              // Get the actual piece ID currently occupying this grid slot
              int pieceId = pieceOrder[index];

              // Calculate where this piece *belongs* in the original image
              int correctRow = pieceId ~/ widget.gridSize;
              int correctCol = pieceId % widget.gridSize;

              return PuzzlePiece(
                imageUrl: widget.imageUrl,
                correctRow: correctRow,
                correctCol: correctCol,
                gridSize: widget.gridSize,
                size: pieceSize,
                currentIndex: index,
                onPieceSwapped: _swapPieces,
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _shufflePieces,
          child: const Text('Reshuffle'),
        ),
      ],
    );
  }
}
