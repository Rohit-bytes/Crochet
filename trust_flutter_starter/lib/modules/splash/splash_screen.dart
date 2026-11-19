import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_text.dart';
import '../../core/theme/app_colors.dart';
import 'splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _glowController;
  late AnimationController _textController;
  late AnimationController _particleController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<Offset> _logoSlide;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  @override
  void initState() {
    super.initState();

    Get.put(SplashController());

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _logoScale = CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    );

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeOutCubic,
    ));

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _logoController.forward();

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _textController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _glowController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: Stack(
        children: [
          // Background glow
          Positioned(
            top: -120,
            right: -100,
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4776E6).withOpacity(.12),
              ),
            ),
          ),

          Positioned(
            bottom: -150,
            left: -120,
            child: Container(
              height: 350,
              width: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF805AD5).withOpacity(.10),
              ),
            ),
          ),

          // Animated particles
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _particleController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticlePainter(_particleController.value),
                );
              },
            ),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated logo
                FadeTransition(
                  opacity: _logoFade,
                  child: SlideTransition(
                    position: _logoSlide,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: AnimatedBuilder(
                        animation: _glowController,
                        builder: (context, child) {
                          final glow = 15 + (_glowController.value * 20);

                          return Container(
                            height: 145,
                            width: 145,
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.06),
                              borderRadius: BorderRadius.circular(38),
                              border: Border.all(
                                color: Colors.white.withOpacity(.15),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xFF4776E6).withOpacity(.25),
                                  blurRadius: glow,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: Image.asset(
                              'assets/applogo.png',
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Animated app name
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Column(
                      children: [
                        const Text(
                          AppText.appName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          height: 3,
                          width: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4776E6),
                                Color(0xFF5EEAD4),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          AppText.tagline,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'KNOW WHO IS BEHIND THE NEWS.',
                          style: TextStyle(
                            color: Colors.white38,
                            fontSize: 9,
                            letterSpacing: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom loading indicator
          Positioned(
            bottom: 65,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _textFade,
              child: Column(
                children: [
                  const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Color(0xFF5EEAD4),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'PREPARING YOUR NEWS EXPERIENCE',
                    style: TextStyle(
                      color: Colors.white.withOpacity(.4),
                      fontSize: 9,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Background particle animation
class ParticlePainter extends CustomPainter {
  final double progress;

  ParticlePainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(.20);

    for (int i = 0; i < 35; i++) {
      final x = (i * 73.0) % size.width;
      final baseY = (i * 113.0) % size.height;
      final y = (baseY - progress * size.height) % size.height;

      final radius = 1.0 + (i % 3) * .5;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
