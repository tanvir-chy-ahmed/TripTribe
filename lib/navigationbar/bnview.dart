import 'package:flutter/material.dart';
import 'package:triptribe/screens/explorescreen/ExploreScreen.dart';
import 'package:triptribe/screens/homescreen/HomeScreen.dart';
import 'package:triptribe/screens/homescreen/post/Post_Place.dart';
import 'package:triptribe/screens/profile/screen/ProfileScreen.dart';
import 'package:triptribe/screens/socialmedia/SocialMediaHome.dart';
import 'package:triptribe/screens/socialmedia/post/Post.dart';

class FloatingNavBarScreen extends StatefulWidget {
  const FloatingNavBarScreen({super.key});

  @override
  State<FloatingNavBarScreen> createState() => _FloatingNavBarScreenState();
}

class _FloatingNavBarScreenState extends State<FloatingNavBarScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late TabController _tabController;

  bool _isFabExpanded = false; // FAB menu state

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

  void toggleFab() {
    setState(() {
      _isFabExpanded = !_isFabExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color activeColor = colors[_currentIndex];
    final Color inactiveColor = activeColor.computeLuminance() > 0.5
        ? const Color(0xFF5296fa)
        : Colors.white;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Pages
          IndexedStack(index: _currentIndex, children: _pages),

          // Bottom navigation bar
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
                children: List.generate(_pages.length + 1, (index) {
                  if (index == 2) return const SizedBox(width: 60);

                  int realIndex = index > 2 ? index - 1 : index;

                  return GestureDetector(
                    onTap: () {
                      _tabController.animateTo(realIndex);
                      setState(() {
                        _currentIndex = realIndex;
                        _isFabExpanded = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: _currentIndex == realIndex
                            ? inactiveColor.withOpacity(0.2)
                            : Colors.transparent,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        realIndex == 0
                            ? Icons.home
                            : realIndex == 1
                            ? Icons.explore_outlined
                            : realIndex == 2
                            ? Icons.telegram
                            : Icons.person,
                        color: _currentIndex == realIndex
                            ? inactiveColor
                            : inactiveColor.withOpacity(0.5),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          // FAB + expanded menu
          Positioned(
            bottom: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Expanded menu items
                // FAB + expanded menu with background overlay
                if (_isFabExpanded)
                  // Full-screen semi-transparent overlay
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: toggleFab, // Close menu when tapping outside
                      child: Container(
                        color: Colors.black.withOpacity(0.5), // Dim background
                      ),
                    ),
                  ),

                Positioned(
                  bottom: 30,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Expanded menu items
                      if (_isFabExpanded) ...[
                        buildFabItem(
                          Icons.place_outlined,
                          "Places Post",
                          Colors.red,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostPlaceScreen(),
                              ),
                            );
                            setState(() {
                              _isFabExpanded = false;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        buildFabItem(
                          Icons.add_a_photo_outlined,
                          "Social Post",
                          Colors.green,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SocialPostScreen(),
                              ),
                            );
                            setState(() {
                              _isFabExpanded = false;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        // buildFabItem(Icons.camera_alt, "", Colors.orange, () {}),
                        // const SizedBox(height: 10),
                      ],
                      FloatingActionButton(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.blue,
                        onPressed: toggleFab,
                        child: Icon(
                          _isFabExpanded ? Icons.close : Icons.add,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFabItem(
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 35,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
