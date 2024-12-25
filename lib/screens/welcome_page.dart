import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passmaker/models/onboard.dart';
import 'package:passmaker/screens/main_page.dart';
import 'package:passmaker/widgets/dotIndicator.dart';
import 'package:passmaker/widgets/onboard_content.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final controller = Get.put(Dotindicator());

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => MainPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLightMode = theme.brightness == Brightness.light;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width - 110),
                child: TextButton(
                  onPressed:() {
                    controller.skipPage();
                  }, 
                  child: Text(
                    "Passer",
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.textTheme.bodyMedium?.color,
                    ),
                  )
                ),
              ),
              Expanded(
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: controller.pageController,
                  onPageChanged:(index) {
                    controller.updatePageIndicator(index);
                    setState(() {});
                  },
                  itemBuilder: (context, index) => OnboardContent(
                    image: isLightMode ? demoData[index].imageLight : demoData[index].image,
                    title: demoData[index].title,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: SmoothPageIndicator(
                  controller: controller.pageController, 
                  onDotClicked: controller.dotNavigationClick,
                  count: demoData.length,
                  effect: ExpandingDotsEffect(
                    activeDotColor: isLightMode ? Color(0xFF333232) : Colors.white,
                    dotHeight: 6,
                    dotWidth: 15
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60.0),
                child: ElevatedButton(
                  onPressed: () {
                    controller.nextPage();
                  }, 
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    backgroundColor: theme.elevatedButtonTheme.style?.backgroundColor?.resolve({}),
                  ),
                  child: Center(
                    child: Text(
                      controller.currentPageIndex.value == 2
                        ? "Get Started"
                        : "Suivant",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isLightMode ? Colors.white : Colors.black,
                      ),
                    ),
                  )
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}