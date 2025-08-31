import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:triptribe/navigationbar/bnview.dart';
import 'package:triptribe/screens/onboard/onboarding_s1.dart';
import 'package:triptribe/screens/onboard/onboarding_s2.dart';
import 'package:triptribe/screens/onboard/onboarding_s3.dart';

class OnboardingController extends StatefulWidget {
  const OnboardingController({super.key});

  @override
  _OnboardingControllerState createState() => _OnboardingControllerState();
}

class _OnboardingControllerState extends State<OnboardingController> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  bool isLoading = true;
  bool showOnboarding = true;

  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? alreadyOpened = prefs.getBool('isFirstTimeOpened');

    if (alreadyOpened != null && alreadyOpened == true) {
      // Already opened before, skip onboarding
      setState(() {
        showOnboarding = false;
        isLoading = false;
      });
    } else {
      // First time opening
      await prefs.setBool('isFirstTimeOpened', true);
      setState(() {
        showOnboarding = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show splash/loading while checking SharedPreferences
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!showOnboarding) {
      // Skip onboarding and go to HomeScreen directly
      return FloatingNavBarScreen();
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = index == 2;
              });
            },
            children: [
              OnboardingOne(
                onNext: () => _controller.animateToPage(
                  1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              ),
              OnboardingTwo(
                onNext: () => _controller.animateToPage(
                  2,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                ),
              ),
              OnboardingThree(
                onNext: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FloatingNavBarScreen(),
                  ),
                ),
              ),
            ],
          ),

          // Dot Indicator
          Positioned(
            bottom: 170,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: WormEffect(
                  activeDotColor: Colors.white,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
