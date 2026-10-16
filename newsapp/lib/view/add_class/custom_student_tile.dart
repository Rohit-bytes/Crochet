import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final String enrollmentNo;
  final String name;
  final String email;
  final String imageUrl;

  const StudentTile({
    super.key,
    required this.enrollmentNo,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // Profile Image
          Container(
            height: 58,
            width: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffF1F5F9),
            ),
            child: ClipOval(child: Image.asset(imageUrl, fit: BoxFit.cover)),
          ),

          const SizedBox(width: 14),

          // Student Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  enrollmentNo,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff263B72),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff172554),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  email,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xff64748B),
                  ),
                ),
              ],
            ),
          ),

          // Three dot menu
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_horiz, color: Color(0xff172554)),
            padding: EdgeInsets.zero,
            onSelected: (value) {
              if (value == 'view') {
                // View student
              } else if (value == 'remove') {
                // Remove student
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'view', child: Text('View')),
              PopupMenuItem(value: 'remove', child: Text('Remove')),
            ],
          ),
        ],
      ),
    );
  }
}
