import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trust/main.dart';
import '../../core/routes/app_routes.dart';
import '../../data/services/auth_service.dart';

class NewsItem {
  final String title;
  final String summary;
  final String publisher;
  final String sourceType;
  final int credibility;
  final String category;
  final String news;

  const NewsItem({
    required this.title,
    required this.summary,
    required this.publisher,
    required this.sourceType,
    required this.credibility,
    required this.category,
    required this.news,
  });
}

class HomeController extends GetxController {
  final AuthService _auth = AuthService();

  final List<String> titles = [
    'Know who is behind\nthe news.',
    'AI or Journalist?\nKnow the source.',
    'Read news.\nThink critically.',
    'Transparency builds\ntrust.',
    'Truth deserves\nverification.',
  ];
  final currentTitleIndex = 0.obs;
  Timer? titleTimer;

  @override
  void onInit() {
    super.onInit();

    titleTimer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        currentTitleIndex.value = (currentTitleIndex.value + 1) % titles.length;
      },
    );
    getNews();
    listenToNews();
  }

  @override
  void onClose() {
    titleTimer?.cancel();
    super.onClose();
  }

  List<NewsItem> news = [];
  bool isloading = false;

  RealtimeChannel? _newsChannel;
  void listenToNews() {
    _newsChannel = supabase
        .channel('news_changes')
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'news',
          callback: (payload) {
            print('News database changed: ${payload.eventType}');

            getNews();
          },
        )
        .subscribe();
  }

  Future<void> getNews() async {
    try {
      isloading = true;
      update();
      final response = await supabase.from('news').select();

      news = response.map((item) {
        return NewsItem(
          title: item['title'] ?? '',
          summary: item['summary'] ?? '',
          publisher: item['publisher'] ?? '',
          sourceType: item['sourcetype'] ?? '',
          credibility: item['credibility'] ?? 0,
          category: item['category'] ?? '',
          news: item['news'] ?? '',
        );
      }).toList();
      print(news);
      update();
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      isloading = false;
      update();
    }
  }

  // List<NewsItem> get filteredNews {
  //   if (selectedFilter.value == 'All') return news;
  //   return news
  //       .where((item) => item.sourceType == selectedFilter.value)
  //       .toList();
  // }

  final selectedFilter = 'All'.obs;

  List<NewsItem> get filteredNews {
    if (selectedFilter.value == 'All') {
      return news;
    }

    if (selectedFilter.value == 'AI') {
      return news.where((item) => item.sourceType == 'ai_generated').toList();
    }

    return news.where((item) => item.sourceType == 'journalist').toList();
  }

  Future<void> logout() async {
    await _auth.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
