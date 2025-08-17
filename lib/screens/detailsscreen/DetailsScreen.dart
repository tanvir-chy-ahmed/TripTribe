import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:triptribe/screens/homescreen/HomeScreen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () {
            // Book Now logic
          },
          icon: Icon(Icons.shopping_cart),
          label: Text(
            "Book Now!",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      "https://images.pexels.com/photos/158441/venice-italy-sunset-grand-canal-158441.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0x4DB0BEC5),

                            // Soft material grey with transparency
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios_new,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Color(0x33B0BEC5),

                            // Soft material grey with transparency
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: FvrtIcon(),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 390),
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(42),
                      ),
                      child: Card(
                        margin: EdgeInsets.zero,
                        elevation: 4,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(42),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 10,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        ImageContainer(
                                          "https://images.pexels.com/photos/208701/pexels-photo-208701.jpeg",
                                        ),
                                        SizedBox(width: 8),
                                        ImageContainer(
                                          "https://images.pexels.com/photos/258196/pexels-photo-258196.jpeg",
                                        ),
                                        SizedBox(width: 8),
                                        ImageContainer(
                                          "https://images.pexels.com/photos/705782/pexels-photo-705782.jpeg",
                                        ),
                                        SizedBox(width: 8),
                                        ImageContainer(
                                          "https://images.pexels.com/photos/705782/pexels-photo-705782.jpeg",
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bali',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal, // Optional
                                    ),
                                  ),

                                  Text(
                                    '\$120.5' + '/person',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal, // Optional
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        "Italy",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.grey.shade500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "4.5",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      // replace "rating" with actual value
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 10),
                              OverlappingAvatars(),
                              SizedBox(height: 10),
                              ProductTabView(),
                              SizedBox(height: 500),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable image widget
Widget ImageContainer(String url) {
  return Container(
    height: 80,
    width: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
    ),
  );
}

class ProductTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Description'),
              Tab(text: 'Maps'),
              Tab(text: 'Review'),
            ],
          ),
          SizedBox(
            height: 250, // Give height so TabBarView doesn't get 0 height
            child: TabBarView(
              children: [
                // Description Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                      ReadMoreText(
                        'Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. '
                        'East of Java and west of Lombok, the province includes the island of Bali. '
                        'It is renowned for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs.'
                        'Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands'
                        'East of Java and west of Lombok, the province includes the island of Bali. '
                        'It is renowned for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs.'
                        'Bali is a province of Indonesia and the westernmost of the Lesser Sunda Islands. '
                        'East of Java and west of Lombok, the province includes the island of Bali. '
                        'It is renowned for its forested volcanic mountains, iconic rice paddies, beaches, and coral reefs.',
                        trimLines: 3,
                        colorClickableText: Colors.blue,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'Read more',
                        trimExpandedText: ' Read less',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        moreStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                // Review Tab
                Center(child: Text("No Maps Content yet")),
                Center(child: Text("No reviews yet")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
