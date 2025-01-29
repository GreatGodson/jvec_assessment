import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/framework/theme/spacings/spacings.dart';
import '../../../../shared/presentation/components/button_component.dart';
import '../../../authentication/presentation/pages/signup_page.dart';
import '../components/indicator_component.dart';
import '../controllers/onboarding_content_controller.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingController controller = Get.put(OnboardingController());
  final onboardingController = Get.find<OnboardingContentController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() {
        if (onboardingController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (onboardingController.onboardingData.value == null) {
          return const Center(
            child: Text('Failed to load onboarding data'),
          );
        }
        final data = onboardingController.onboardingData.value!;

        final message = data.message;
        return Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.pageViewIndex.value = index;
                },
                itemCount: message.length,
                itemBuilder: (context, index) {
                  final title = message[index].title;
                  final description = message[index].message;
                  final lottie = message[index].lottie;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Spacings.spacing24,
                      vertical: Spacings.spacing24,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                fontSize: Spacings.spacing30,
                                fontWeight: FontWeight.w700,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: Spacings.spacing24),
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: Spacings.spacing16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Spacings.spacing40,
                        ),
                        Flexible(
                          child: Center(
                            child: Lottie.asset(lottie),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacings.spacing24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() => PageViewIndicatorsComponent(
                          index: controller.pageViewIndex.value,
                          count: 3,
                        )),
                  ),
                  const SizedBox(width: Spacings.spacing24),
                  Expanded(
                    child: Obx(() => ButtonComponent(
                          color: Colors.purple,
                          verticalPadding: Spacings.spacing18,
                          text: controller.pageViewIndex.value < 2
                              ? "Skip"
                              : "Get Started",
                          onPressed: () {
                            if (controller.pageViewIndex.value == 2) {
                              Get.off(() => SignupPage());
                            } else {
                              controller.pageController.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                        )),
                  ),
                ],
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideY(begin: 1.0, end: 0, duration: 1000.ms),
            ),
          ],
        );
      })),
    );
  }
}
