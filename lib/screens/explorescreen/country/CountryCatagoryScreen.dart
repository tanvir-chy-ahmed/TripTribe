import 'package:flutter/material.dart';
import 'package:triptribe/screens/explorescreen/country/CountryTopPlacesDetails.dart';

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
    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardListHorizontal(
              name: "Dubai",
              imgUrl: "https://images.pexels.com/photos/2453295/pexels-photo-2453295.jpeg",
              description: 'A luxurious city known for its modern architecture and vibrant nightlife.',
              rating: '8.0',
              flag: 'https://t4.ftcdn.net/jpg/05/18/83/39/360_F_518833985_IGWqx1AnMNsni4CH0CnLbSxqTYhQbvRM.jpg',
            ),
            CardListHorizontal(
              name: "Indonesia",
              imgUrl: "https://images.pexels.com/photos/4090349/pexels-photo-4090349.jpeg",
              description: 'An archipelago with beautiful beaches and rich cultural heritage.',
              rating: '7.5',
              flag: 'https://media.gettyimages.com/id/1740659549/video/indonesia-flag-waving-seamless-slow-motion-high-quality-4k.jpg?s=640x640&k=20&c=YrAwCiJDpwC4u4In3UuIdjGBjgZqiwtyy1E-qs3F6e0=',
            ),
            CardListHorizontal(
              name: "Jordan",
              imgUrl: "https://images.pexels.com/photos/2097855/pexels-photo-2097855.jpeg",
              description: 'Home to ancient monuments like Petra and stunning desert landscapes.',
              rating: '8.3',
              flag: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNVgC91JRFb3UGVBzH35QMlVI3gm8wNVv4GEMjo9dKdlxBqLlAYrMf-6AyOrD88Bs7kvY&usqp=CAU',
            ),
            CardListHorizontal(
              name: "Italy",
              imgUrl: "https://images.pexels.com/photos/4987272/pexels-photo-4987272.jpeg",
              description: 'Famous for its art, history, cuisine, and scenic coastlines.',
              rating: '9.0',
              flag: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEBPxpf00iWvlZxFRG8_CiI9PhKnJGvaNWWQ&s',
            ),
            CardListHorizontal(
              name: "Portugal",
              imgUrl: "https://images.pexels.com/photos/30272791/pexels-photo-30272791.jpeg",
              description: 'Known for its beautiful beaches, historic cities, and delicious food.',
              rating: '8.2',
              flag: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRKdQSxfS8JML0zK_gVnKVocPZoM7BspdaFsg&s',
            ),
            CardListHorizontal(
              name: "USA",
              imgUrl: "https://images.pexels.com/photos/378570/pexels-photo-378570.jpeg",
              description: 'A vast country with diverse landscapes and iconic cities.',
              rating: '8.8',
              flag: 'https://i.pinimg.com/736x/a9/cf/4a/a9cf4ae1faee0af9b338cb93a43aa316.jpg',
            ),
            CardListHorizontal(
              name: "Japan",
              imgUrl: "https://images.pexels.com/photos/1440476/pexels-photo-1440476.jpeg",
              description: 'A blend of tradition and technology with stunning nature.',
              rating: '9.2',
              flag: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeKjdakGpg8gLhau5MOVdL-REmYoyiIzXccw&s',
            ),
            CardListHorizontal(
              name: "Egypt",
              imgUrl: "https://images.pexels.com/photos/18991572/pexels-photo-18991572.jpeg",
              description: 'Land of ancient pyramids and rich archaeological treasures.',
              rating: '8.5',
              flag: 'https://t3.ftcdn.net/jpg/00/42/90/78/360_F_42907895_qbW5Aa3T6oEbyBcu8QJ94241lSGd0Fbg.jpg',
            ),
            CardListHorizontal(
              name: "Maldive",
              imgUrl: "https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg",
              description: 'Tropical paradise with crystal-clear waters and white sandy beaches.',
              rating: '9.5',
              flag: 'https://t3.ftcdn.net/jpg/04/75/25/70/360_F_475257008_YKylfsF490rvMpNZxD69WB7bs6z5EcSH.jpg',
            ),
            CardListHorizontal(
              name: "Australia",
              imgUrl: "https://images.pexels.com/photos/5707602/pexels-photo-5707602.jpeg",
              description: 'Known for its unique wildlife and beautiful natural landscapes.',
              rating: '8.7',
              flag: 'https://t3.ftcdn.net/jpg/08/48/73/26/360_F_848732634_yRmx9HKhd1seyXuTHoceSEM6rgBfe3sv.jpg',
            ),

            CircularProgressIndicator(),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
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
                        child: Image.network(
                          widget.imgUrl,
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(child: Icon(Icons.broken_image)),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(child: ShimmerExplore());
                          },
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
                  backgroundImage: NetworkImage(widget.flag),
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
