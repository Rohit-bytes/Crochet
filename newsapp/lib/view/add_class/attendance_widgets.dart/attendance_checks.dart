import 'package:flutter/material.dart';

class AttendanceInfoCard extends StatelessWidget {
  final List<String> messages;

  const AttendanceInfoCard({
    super.key,
    this.messages = const [
      'A unique QR code will be generated',
      'Valid only for the selected duration',
      'Students can mark attendance only once',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F0FF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFD4E5FF), width: 1.2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: Color(0xFF2878FF), size: 24),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                messages.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: index == messages.length - 1 ? 0 : 16,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.check,
                        color: Color(0xFF2878FF),
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          messages[index],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF60769B),
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
