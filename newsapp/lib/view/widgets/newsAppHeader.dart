import 'package:TrustLens/core/color_pallete.dart';
import 'package:flutter/material.dart';

class NewsAppHeader extends StatelessWidget {
  final VoidCallback? onSearch;
  final VoidCallback? onNotifications;

  const NewsAppHeader({super.key, this.onSearch, this.onNotifications});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                      color: ColorPalette.textPrimary,
                      letterSpacing: -1,
                    ),
                    children: [
                      TextSpan(text: 'News'),
                      TextSpan(
                        text: 'Hub',
                        style: TextStyle(color: ColorPalette.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Stay informed. Stay ahead.',
                  style: TextStyle(
                    color: ColorPalette.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _HeaderButton(icon: Icons.search_rounded, onTap: onSearch),
          const SizedBox(width: 10),
          _HeaderButton(
            icon: Icons.notifications_none_rounded,
            onTap: onNotifications,
            showDot: true,
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool showDot;

  const _HeaderButton({required this.icon, this.onTap, this.showDot = false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: const Color(0xFFF0F3F8),
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 46,
              height: 46,
              child: Icon(icon, color: ColorPalette.textPrimary, size: 24),
            ),
          ),
        ),
        if (showDot)
          Positioned(
            right: 3,
            top: 3,
            child: Container(
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: ColorPalette.breaking,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
