import 'package:flutter/material.dart';
import 'package:triptribe/screens/explorescreen/ExploreScreen.dart';
import 'package:triptribe/screens/homescreen/HomeScreen.dart';
import 'package:triptribe/screens/profile/screen/ProfileScreen.dart';
import 'package:triptribe/screens/socialmedia/SocialMediaHome.dart';

class FloatingNavBarScreen extends StatefulWidget {
  const FloatingNavBarScreen({super.key});

  @override
  State<FloatingNavBarScreen> createState() => _FloatingNavBarScreenState();
}

class _FloatingNavBarScreenState extends State<FloatingNavBarScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  final List<Color> colors = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  final List<Widget> _pages = [
    const HomeScreen(),
    const ExploreScreen(),
    const SocialMediaScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _pages.length, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentIndex = _tabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = colors[_currentIndex];
    final Color inactiveColor = activeColor.computeLuminance() > 0.5
        ? const Color(0xFF5296fa)
        : Colors.white;

    return Scaffold(
      // No appBar or body here. Body will be the stack with pages + floating nav bar
      body: Stack(
        children: [
          // The pages
          IndexedStack(index: _currentIndex, children: _pages),

          // The floating bottom nav bar positioned at bottom center
          Positioned(
            bottom: 20,
            left: MediaQuery.of(context).size.width * 0.1,
            right: MediaQuery.of(context).size.width * 0.1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 60,
              decoration: BoxDecoration(
                color: activeColor,
                borderRadius: BorderRadius.circular(50),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(_pages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      _tabController.animateTo(index);
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: _currentIndex == index
                            ? inactiveColor.withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        index == 0
                            ? Icons.home
                            : index == 1
                            ? Icons.explore_outlined
                            : index == 2
                            ? Icons.telegram
                            : Icons.person,
                        color: _currentIndex == index
                            ? inactiveColor
                            : inactiveColor.withOpacity(0.5),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
