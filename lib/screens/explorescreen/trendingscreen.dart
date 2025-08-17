import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:triptribe/screens/detailsscreen/DetailsScreen.dart';

class Trendingscreen extends StatefulWidget {
  const Trendingscreen({super.key});

  @override
  State<Trendingscreen> createState() => _TrendingscreenState();
}

class _TrendingscreenState extends State<Trendingscreen> {
  @override
  Widget build(BuildContext context) {
    Future refresh() async {
      setState(() {});
    }

    return RefreshIndicator(
      onRefresh: refresh,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CardListHorizontal(
                name: "Mount Fuji",
                imgUrl: "https://images.pexels.com/photos/33368124/pexels-photo-33368124.jpeg",
                location: "Japan",
                rating: "5.5"
            ),
            CardListHorizontal(
                name: "Eiffel Tower",
                imgUrl: "https://images.pexels.com/photos/338515/pexels-photo-338515.jpeg",
                location: "Paris, France",
                rating: "4.8"
            ),
            CardListHorizontal(
                name: "Colosseum",
                imgUrl: "https://images.pexels.com/photos/3021382/pexels-photo-3021382.jpeg",
                location: "Rome, Italy",
                rating: "4.7"
            ),
            CardListHorizontal(
                name: "Great Wall of China",
                imgUrl: "https://images.pexels.com/photos/6187743/pexels-photo-6187743.jpeg",
                location: "China",
                rating: "4.9"
            ),
            CardListHorizontal(
                name: "salar de uyuni",
                imgUrl: "https://images.pexels.com/photos/30929523/pexels-photo-30929523.jpeg",
                location: "Bolivia",
                rating: "4.6"
            ),
            CardListHorizontal(
                name: "Petra",
                imgUrl: "https://images.pexels.com/photos/11195793/pexels-photo-11195793.jpeg",
                location: "Jordan",
                rating: "4.9"
            ),
            CardListHorizontal(
                name: "Machu Picchu",
                imgUrl: "https://images.pexels.com/photos/2929906/pexels-photo-2929906.jpeg",
                location: "Cusco Region, Peru",
                rating: "4.9"
            ),
            CardListHorizontal(
                name: "Pyramids of Giza",
                imgUrl: "https://images.pexels.com/photos/18991572/pexels-photo-18991572.jpeg",
                location: "Giza, Egypt",
                rating: "4.8"
            ),
            CardListHorizontal(
                name: "Plitvice lakes",
                imgUrl: "https://images.pexels.com/photos/19818816/pexels-photo-19818816.jpeg",
                location: "Croatia",
                rating: "4.7"
            ),
            CardListHorizontal(
                name: "Maldives Beachs",
                imgUrl: "https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg",
                location: "Maldives",
                rating: "4.8"
            ),
            CardListHorizontal(
                name: "Venice",
                imgUrl: "https://images.pexels.com/photos/10713946/pexels-photo-10713946.jpeg",
                location: "Italy",
                rating: "4.6"
            ),
            CardListHorizontal(
                name: "Niagara Falls",
                imgUrl: "https://images.pexels.com/photos/5429909/pexels-photo-5429909.jpeg",
                location: "USA / Canada",
                rating: "4.8"
            ),
            CardListHorizontal(
                name: "Sydney Opera House",
                imgUrl: "https://images.pexels.com/photos/5707610/pexels-photo-5707610.jpeg",
                location: "Sydney, Australia",
                rating: "4.7"
            ),

            CircularProgressIndicator(),
            SizedBox(height: 100,)

          ],
        ),
      ),
    );
  }
}

class CardListHorizontal extends StatefulWidget {
  final String name;
  final String imgUrl;
  final String location;
  final String rating;

  const CardListHorizontal({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.location,
    required this.rating,
  });

  @override
  State<CardListHorizontal> createState() => _CardListHorizontalState();
}

class _CardListHorizontalState extends State<CardListHorizontal>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0, // Start from normal scale
    );

    _scaleAnimation = _animationController.drive(
      Tween<double>(begin: 1.0, end: 0.95),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.reverse();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.forward();
  }

  void _onTapCancel() {
    _animationController.forward();
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: (details) {
        _onTapUp(details);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen()),
        );
      },
      onTapCancel: _onTapCancel,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: SizedBox(
            height: 260,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
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
                                Center(child: Icon(Icons.broken_image)),
                            loadingBuilder:
                                (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: ShimmerExplore());
                            },
                          ),
                        ),
                        // Gradient Overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.7),
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

                // Trending Badge (top right)
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.7),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      "Trending",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                // Share icon (top left)
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.black45,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          check = !check;
                        });
                      },
                      color: Colors.redAccent,
                      icon: Icon(
                        check ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),
                  ),
                ),


                // Text info (bottom center)
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_pin,
                              size: 18, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Star Rating Row
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          double ratingValue =
                              double.tryParse(widget.rating) ?? 0.0;
                          if (index + 1 <= ratingValue.floor()) {
                            return Icon(Icons.star,
                                color: Colors.amber, size: 20);
                          } else if (index < ratingValue &&
                              ratingValue - ratingValue.floor() >= 0.5) {
                            return Icon(Icons.star_half,
                                color: Colors.amber, size: 20);
                          } else {
                            return Icon(Icons.star_border,
                                color: Colors.amber, size: 20);
                          }
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerExplore extends StatelessWidget {
  const ShimmerExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼️ Image Placeholder
                Container(
                  height: 270,
                  width: double.infinity,
                  margin: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                // 📝 Text placeholders
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(height: 14, width: 100, color: Colors.white),
                      SizedBox(height: 6),
                      Container(height: 12, width: 80, color: Colors.white),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(height: 12, width: 40, color: Colors.white),
                          Spacer(),
                          Container(height: 20, width: 20, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
