import 'package:flutter/material.dart';

class AttendanceProgressCard extends StatelessWidget {
  final int present;
  final int total;
  final double size;

  const AttendanceProgressCard({
    super.key,
    required this.present,
    required this.total,
    this.size = 150,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = total == 0
        ? 0
        : (present / total).clamp(0.0, 1.0);

    final int percentageValue = (percentage * 100).round();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background circle
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 15,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFDCE8FA),
                    ),
                  ),
                ),

                // Progress circle
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    value: percentage,
                    strokeWidth: 15,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.transparent,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF2879E8),
                    ),
                  ),
                ),

                // Center text
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$present / $total',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$percentageValue%',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF111827),
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
  }
}
