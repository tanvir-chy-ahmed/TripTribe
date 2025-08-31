import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triptribe/screens/explorescreen/country/CountryTopPlacesDetails.dart';

import '../../../supabase/setup.dart';

class Countryscreen extends StatefulWidget {
  const Countryscreen({super.key});

  @override
  State<Countryscreen> createState() => _CountryscreenState();
}

class _CountryscreenState extends State<Countryscreen> {
  Future refresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchCoutryCatagoryScreen(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Center the progress indicator in full available space
          return SizedBox(
            height:
                MediaQuery.of(context).size.height *
                0.5, // optional, to limit height
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                // custom color
                strokeWidth: 4, // thicker line
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final images = snapshot.data ?? [];

        if (images.isEmpty) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Center(child: Text('No Item found.')),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: images.map((image) {
              return CardListHorizontal(
                flag: image['flag'].toString(),
                name: image['name'].toString(),
                imgUrl: image['imgUrl'].toString(),
                rating: image['rating'].toString(),
                description: image['description'].toString(),
              );
            }).toList(),
          ),
        );
      },
    );

    //   StreamBuilder<List<PlacesData>>(
    //   stream: Stream.value(countrycatagory), // Your static list as a stream
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Center(child: CircularProgressIndicator());
    //     }
    //
    //     if (!snapshot.hasData || snapshot.data!.isEmpty) {
    //       return const Center(child: Text('No data available'));
    //     }
    //
    //     final data = snapshot.data!;
    //
    //     return RefreshIndicator(
    //       onRefresh: () async {
    //         // Refresh logic if needed
    //       },
    //       child: SingleChildScrollView(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             // Horizontal list at the top (fixed height)
    //
    //
    //             // Vertical list (full-screen scroll)
    //             ...data.map((item) => CardListHorizontal(
    //               name: item.name,
    //               imgUrl: item.imgUrl,
    //               description: item.description,
    //               rating: item.rating,
    //               flag: item.flag,
    //             )),
    //
    //             const SizedBox(height: 20),
    //             const Center(child: CircularProgressIndicator()),
    //             const SizedBox(height: 100),
    //           ],
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}

class CardListHorizontal extends StatefulWidget {
  final String name;
  final String imgUrl;
  final String flag;
  final String description;
  final String rating;

  const CardListHorizontal({
    super.key,
    required this.name,
    required this.flag,
    required this.imgUrl,
    required this.description,
    required this.rating,
  });

  @override
  State<CardListHorizontal> createState() => _CardListHorizontalState();
}

class _CardListHorizontalState extends State<CardListHorizontal> {
  bool isWishlisted = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CountryTopPlacesDetails()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              // Card with Hero Animation
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                shadowColor: Colors.black.withOpacity(0.2),
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Hero(
                        tag: widget.imgUrl,
                        child: CachedNetworkImage(
                          imageUrl: widget.imgUrl,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) =>
                              Center(child: Icon(Icons.broken_image)),
                          placeholder: (context, url) =>
                              Center(child: ShimmerExplore()),
                        ),
                      ),
                      // Gradient Overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Country Flag
              Positioned(
                top: 16,
                left: 16,
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: CachedNetworkImageProvider(widget.flag),
                  backgroundColor: Colors.white,
                ),
              ),

              // Rating Badge
              Positioned(
                top: 16,
                right: 60,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        widget.rating,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Wishlist Button
              Positioned(
                top: 12,
                right: 12,
                child: IconButton(
                  icon: Icon(
                    isWishlisted ? Icons.favorite : Icons.favorite_border,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    setState(() {
                      isWishlisted = !isWishlisted;
                    });
                  },
                ),
              ),

              // Title + Description + Button
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CountryTopPlacesDetails(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.explore),
                      label: const Text(
                        "Explore",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 19,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
