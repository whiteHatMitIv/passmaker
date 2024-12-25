import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passmaker/screens/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dotindicator extends GetxController {
  static Dotindicator get instance => Get.find();

  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true); // Enregistrer l'état
    Get.off(MainPage());
  }

  void updatePageIndicator(index) => currentPageIndex.value = index;

  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  void nextPage() {
    if (currentPageIndex.value == 2) {
      _completeOnboarding();
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }
}

