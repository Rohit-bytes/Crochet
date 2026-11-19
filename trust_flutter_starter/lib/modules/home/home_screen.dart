import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trust/modules/home/news_screen.dart';
import '../../core/theme/app_colors.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());
    final wide = MediaQuery.sizeOf(context).width > 700;
    return GetBuilder<HomeController>(builder: (h) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(
                "assets/applogo.png",
                height: 25,
                width: 25,
              ),
              const Text('TRUST.',
                  style: TextStyle(
                      fontWeight: FontWeight.w900, letterSpacing: 1.2)),
            ],
          ),
          actions: [
            IconButton(
              tooltip: 'Log out',
              onPressed: c.logout,
              icon: const Icon(Icons.logout_rounded),
            ),
            const SizedBox(width: 8),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: ListView(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppColors.navy,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('NEWS. WITHOUT THE NOISE.',
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                              letterSpacing: 1.5)),
                      const SizedBox(height: 12),
                      Obx(() => AnimatedSwitcher(
                            duration: const Duration(milliseconds: 700),
                            child: Text(
                              c.titles[c.currentTitleIndex.value],
                              key: ValueKey(c.currentTitleIndex.value),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                height: 1.15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )),
                      const SizedBox(height: 10),
                      const Text(
                          'Explore reporting with transparent source labels.',
                          style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                const Text('Explore news',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text)),
                const SizedBox(height: 14),
                Obx(() => Wrap(
                      spacing: 8,
                      children: [
                        'All',
                        // 'AI', 'Journalist'
                      ].map((filter) {
                        final selected = c.selectedFilter.value == filter;
                        return ChoiceChip(
                          label: Text(filter == 'All' ? 'All news' : filter),
                          selected: selected,
                          onSelected: (_) => c.selectedFilter.value = filter,
                        );
                      }).toList(),
                    )),
                const SizedBox(height: 16),
                Obx(() {
                  final filteredNews = c.filteredNews;

                  if (c.isloading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (filteredNews.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(30),
                        child: Text('No news available'),
                      ),
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredNews.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: wide ? 2 : 1,
                      mainAxisExtent: 230,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                    ),
                    itemBuilder: (context, index) {
                      final item = h.filteredNews[index];
                      final isAi = item.sourceType == 'ai_generated';
                      // final accent = isAi ? AppColors.purple : AppColors.green;
                      final accent = isAi ? AppColors.purple : AppColors.purple;
                      return InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: () {
                          Get.to(() => NewsScreen(news: item));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: accent.withOpacity(.10),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                        // AI GENERATED
                                        //JOURNALIST
                                        isAi ? '???' : '???',
                                        style: TextStyle(
                                            color: accent,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10)),
                                  ),
                                  const Spacer(),
                                  Text(item.category,
                                      style: const TextStyle(
                                          color: AppColors.muted,
                                          fontSize: 11)),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Text(item.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.text)),
                              const SizedBox(height: 8),
                              Expanded(
                                child: Text(item.summary,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: AppColors.muted, height: 1.35)),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(item.publisher,
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.muted))),
                                  Text('???% credibility',
                                      style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: accent)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(height: 12),
                const Text(
                  'Demo content: source labels and credibility values are sample data, not verified assessments.',
                  style: TextStyle(fontSize: 11, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
