import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust/modules/home/home_controller.dart';
import '../../core/theme/app_colors.dart';

class NewsScreen extends StatefulWidget {
  final NewsItem news;

  const NewsScreen({
    super.key,
    required this.news,
  });

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  String? selectedAnswer;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  bool get isRevealed => selectedAnswer != null;

  bool get isAI => widget.news.sourceType == 'ai_generated';

  String get actualSource => isAI ? 'AI Generated' : 'Journalist';

  bool get isCorrect => selectedAnswer == widget.news.sourceType;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void selectAnswer(String answer) {
    if (selectedAnswer != null) return;

    setState(() {
      selectedAnswer = answer;
    });
  }

  void resetAnswer() {
    setState(() {
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final news = widget.news;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: AppColors.text,
        title: const Text(
          'News Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.text,
          ),
        ),
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CATEGORY
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.purple.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      news.category,
                      style: const TextStyle(
                        color: AppColors.purple,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // TITLE
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 26,
                      height: 1.3,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 15),

                  // PUBLISHER
                  Row(
                    children: [
                      const Icon(
                        Icons.newspaper_outlined,
                        color: AppColors.muted,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          news.publisher,
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // SUMMARY
                  const Text(
                    'Summary',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    news.summary,
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 15,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // VERIFICATION CARD
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.border,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // HEADING
                        const Text(
                          'Can you identify the source?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'Make your guess before revealing the result.',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),

                        const SizedBox(height: 22),

                        // ANSWER BUTTONS
                        Row(
                          children: [
                            Expanded(
                              child: answerButton(
                                label: 'Journalist',
                                icon: Icons.person_outline,
                                value: 'journalist',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: answerButton(
                                label: 'AI Generated',
                                icon: Icons.smart_toy_outlined,
                                value: 'ai_generated',
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        Divider(
                          color: AppColors.border,
                        ),

                        const SizedBox(height: 20),

                        // RESULT HEADING
                        const Text(
                          'SOURCE VERIFICATION',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.bold,
                            color: AppColors.muted,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // SOURCE TYPE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'News source',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 14,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ScaleTransition(
                                    scale: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: Text(
                                isRevealed ? actualSource : '???',
                                key: ValueKey(isRevealed),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: !isRevealed
                                      ? AppColors.text
                                      : isAI
                                          ? Colors.deepOrange
                                          : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 22),

                        // CREDIBILITY SCORE
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Credibility Score',
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 14,
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 400),
                              transitionBuilder: (child, animation) {
                                return ScaleTransition(
                                  scale: animation,
                                  child: child,
                                );
                              },
                              child: Text(
                                isRevealed ? '${news.credibility}/100' : '???',
                                key: ValueKey(isRevealed),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.purple,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 13),

                        // ANIMATED PROGRESS BAR
                        TweenAnimationBuilder<double>(
                          key: ValueKey(isRevealed),
                          tween: Tween<double>(
                            begin: 0,
                            end: isRevealed ? news.credibility / 100 : 0,
                          ),
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: value,
                                minHeight: 9,
                                backgroundColor: AppColors.border,
                                valueColor: const AlwaysStoppedAnimation(
                                  AppColors.purple,
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),

                        // FEEDBACK ANIMATION
                        AnimatedSize(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOut,
                          child: isRevealed
                              ? Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                    color: isCorrect
                                        ? Colors.green.withOpacity(0.08)
                                        : Colors.orange.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        isCorrect
                                            ? Icons.check_circle_outline
                                            : Icons.info_outline,
                                        color: isCorrect
                                            ? Colors.green
                                            : Colors.orange,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          isCorrect
                                              ? 'Correct! You identified the source.'
                                              : 'Not quite! Check the actual source.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: isCorrect
                                                ? Colors.green
                                                : Colors.orange,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ),

                        const SizedBox(height: 15),

                        // TRY AGAIN
                        if (isRevealed)
                          Center(
                            child: TextButton.icon(
                              onPressed: resetAnswer,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Try Again'),
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.purple,
                              ),
                            ),
                          )
                        else
                          const Center(
                            child: Text(
                              'Select an option to reveal the result.',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // FULL ARTICLE
                  const Text(
                    'Full Article',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.text,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    news.news,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.8,
                      color: AppColors.muted,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ANIMATED ANSWER BUTTON
  Widget answerButton({
    required String label,
    required IconData icon,
    required String value,
  }) {
    final isSelected = selectedAnswer == value;
    final isDisabled = isRevealed && !isSelected;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: isDisabled ? 0.45 : 1,
      child: GestureDetector(
        onTap: isRevealed ? null : () => selectAnswer(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(
            vertical: 17,
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.navy.withOpacity(0.08) : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected ? AppColors.navy : AppColors.border,
              width: isSelected ? 1.7 : 1,
            ),
          ),
          child: Column(
            children: [
              AnimatedScale(
                scale: isSelected ? 1.15 : 1,
                duration: const Duration(milliseconds: 250),
                child: Icon(
                  icon,
                  size: 26,
                  color: isSelected ? AppColors.navy : AppColors.muted,
                ),
              ),
              const SizedBox(height: 9),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.navy : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
