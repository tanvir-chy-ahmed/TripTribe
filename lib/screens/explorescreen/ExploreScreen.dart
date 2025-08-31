import 'package:flutter/material.dart';
import 'package:triptribe/screens/explorescreen/country/CountryCatagoryScreen.dart';
import 'package:triptribe/screens/explorescreen/trendingscreen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int selectedIndex = 0;

  final List<String> filters = [
    "🔥 Trending",
    "🌏 Country",
    "🌋Mountain",
    "🏞️Nature",
    "🏖️Beach",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: CustomScrollView(
          slivers: [
            // Main AppBar
            SliverAppBar(
              pinned: true,
              backgroundColor: const Color(0xFFf2f2f2),
              elevation: 5,
              centerTitle: true,
              title: const Text(
                "Explore",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Transparent Filters Bar (stays pinned)
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.transparent,
              // transparent background
              elevation: 0,
              automaticallyImplyLeading: false,
              toolbarHeight: 5,
              // height of the filter row
              flexibleSpace: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(filters.length, (index) {
                      return SingleFilter(
                        text: filters[index],
                        isSelected: selectedIndex == index,
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                      );
                    }),
                  ),
                ),
              ),
            ),

            // Scrollable content
            SliverToBoxAdapter(
              child: selectedIndex == 0 ? Trendingscreen() : Countryscreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class SingleFilter extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const SingleFilter({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, left: 2),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF5296fa)
                : const Color(0xFFf7f7f7),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade400,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class FilterList extends StatefulWidget {
  const FilterList({super.key});

  @override
  _FilterListState createState() => _FilterListState();
}

class _FilterListState extends State<FilterList> {
  int selectedIndex = 0; // first filter selected by default

  final List<String> filters = ["🔥 Trending", "🌏 Country"];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Filter Row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(filters.length, (index) {
            return SingleFilter(
              text: filters[index],
              isSelected: selectedIndex == index,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
            );
          }),
        ),

        const SizedBox(height: 20),

        // Show screen based on selection
        Expanded(
          child: selectedIndex == 0 ? Trendingscreen() : Countryscreen(),
        ),
      ],
    );
  }
}
