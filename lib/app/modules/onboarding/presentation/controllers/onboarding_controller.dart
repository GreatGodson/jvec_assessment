import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageViewIndex = 0.obs;
  late PageController pageController;
  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageViewIndex.value < 2) {
        pageViewIndex.value++;
        pageController.animateToPage(
          pageViewIndex.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    pageController.dispose();
    timer.cancel();
    super.onClose();
  }
}
