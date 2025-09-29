import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:triptribe/provider/profile_provider.dart';
import 'package:triptribe/screens/detailsscreen/DetailsScreen.dart';
import 'package:triptribe/screens/explorescreen/ExploreScreen.dart';
import 'package:triptribe/screens/profile/screen/ProfileScreen.dart';
import 'package:triptribe/screens/shimmer/shimmer_card.dart';
import 'package:triptribe/screens/socialmedia/chat/chatingScreen.dart';
import 'package:triptribe/supabase/setup.dart';
import 'package:triptribe/util/images.dart';
import 'package:provider/provider.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Searching Operation
  List<Map<String, dynamic>> searchresults = [];
  bool searching = false;
  final TextEditingController searchController = TextEditingController();
  Timer? debounce;

  void performsearch() async {
    final results = await searchplaces(searchController.text.trim());
    setState(() {
      searchresults = results;
    });
  }

  bool isLoading = true; // or use a state variable





  @override
  initState() {
    super.initState();
    Future.microtask((){
      Provider.of<ProfileImageProvider>(context,listen:false).loadSavedImage();
    });
    Future.delayed(Duration(seconds: 2), () {
      if(mounted)
        {
          setState(()=> isLoading =false);
        }
    });
  }


  Future<void> _reresh() async {
    setState(() {});
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileImageProvider>();
    return RefreshIndicator(
      onRefresh: _reresh,
      child: Scaffold(
        backgroundColor: Color(0xFFf2f2f2),
        appBar: AppBar(
          backgroundColor: Color(0xFFf2f2f2),
          elevation: 0,
          leadingWidth: 220,
          leading: Padding(
            padding: const EdgeInsets.only(left: 12),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              child: Row(
                children: [
                  // Profile image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFFeaeaea),
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: profileProvider.selectedImage == null
                          ? CachedNetworkImage(
                              imageUrl:
                                  "https://preview.redd.it/umvub4tgwxt61.jpg?auto=webp&s=92f15de309c9701dfa14e7922072aa3bf0061746",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: SizedBox(height: 50, width: 50),
                              ),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.broken_image)),
                            )
                          : ClipOval(
                              child: Image.file(
                                profileProvider.selectedImage!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Greeting texts
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Ensures same start line
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Hello, ",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Default color
                              ),
                            ),
                            TextSpan(
                              text: "Ana",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color:
                                    Colors.black, // Blue color only for Tanvir
                              ),
                            ),
                            TextSpan(
                              text: " 👋",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            // Notification icon
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Notification Clicked!")),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFeaeaea),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.notifications_active_outlined, size: 26),
                ),
              ),
            ),

            // Menu icon
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ChattingScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.ease;

                            final tween = Tween(
                              begin: begin,
                              end: end,
                            ).chain(CurveTween(curve: curve));
                            final offsetAnimation = animation.drive(tween);

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                    ),
                  );
                },
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFeaeaea),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    // child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border)),
                    child: Image.asset(
                      Images.chat,
                      fit: BoxFit.contain,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        body: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          radius: const Radius.circular(20),
          thickness: 6,
          interactive: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Title ---
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\t\tExplore ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "the ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: "World 🌋",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),

                // --- Search Box ---
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      // Immediately set searching true if any character typed
                      searching = value.isNotEmpty;

                      // Debounce search to avoid too many API calls
                      if (debounce?.isActive ?? false) debounce!.cancel();
                      debounce = Timer(
                        const Duration(milliseconds: 300),
                        () async {
                          if (value.isNotEmpty) {
                            searchresults = await searchplaces(value);
                          } else {
                            searchresults = [];
                          }
                          setState(() {}); // rebuild UI after results
                        },
                      );

                      setState(
                        () {},
                      ); // rebuild to update suffixIcon immediately
                    },
                    onSubmitted: (_) async {
                      performsearch();
                      setState(() {
                        searching = true;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Explore tours and adventures...',
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                searchController.clear();
                                setState(() {
                                  searching = false;
                                  searchresults.clear();
                                });
                              },
                            )
                          : IconButton(
                              onPressed: () {
                                // filter logic
                              },
                              icon: Image.asset(
                                Images.filter,
                                color: Colors.black,
                              ),
                            ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                searching
                    ? SizedBox(height: 0, width: 0)
                    : Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "🔥 Hot right now",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ExploreScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View all   ",
                                  style: TextStyle(
                                    color: Color(0xFF5296fa),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

                          // 2️⃣ Horizontal scroll with shuffled images
                          SizedBox(
                            height: 260,
                            child: FutureBuilder<List<Map<String, dynamic>>>(
                              future: fetchAllImagesShuffled(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text('Error: ${snapshot.error}'),
                                  );
                                }

                                final images = snapshot.data ?? [];

                                if (images.isEmpty) {
                                  return Center(child: Text('No Item found.'));
                                }

                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: images.length,
                                  itemBuilder: (context, index) {
                                    final image = images[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: CardList(
                                        name: image['name'].toString(),
                                        imgUrl: image['imgUrl'].toString(),
                                        location: image['location'].toString(),
                                        rating: image['rating'].toString(),
                                        isLoading: isLoading,
                                        demo1: image['demo_1'].toString(),
                                        demo2: image['demo_2'].toString(),
                                        demo3: image['demo_3'].toString(),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),

                // --- Explore More ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      searching ? "" : "Explore More",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExploreScreen(),
                          ),
                        );
                      },
                      child: Text(
                        searching ? "" : "View all   ",
                        style: TextStyle(
                          color: Color(0xFF5296fa),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // --- Explore More List ---
                FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchAllImagesShuffled(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Center the progress indicator in full available space
                      return SizedBox(
                        height:
                            MediaQuery.of(context).size.height *
                            0.5, // optional, to limit height
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.blue,
                            ), // custom color
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
                        children: (searching ? searchresults : images).map((
                          image,
                        ) {
                          return CardListHorizontal(
                            name: image['name'].toString(),
                            imgUrl: image['imgUrl'].toString(),
                            location: image['location'].toString(),
                            rating: image['rating'].toString(),
                            demo1: image['demo_1'].toString(),
                            demo2: image['demo_2'].toString(),
                            demo3: image['demo_3'].toString(),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),

                // Center(child: CircularProgressIndicator(color: Colors.blue,)),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
// class FilterList extends StatefulWidget {
//   const FilterList({super.key});
//
//   @override
//   _FilterListState createState() => _FilterListState();
// }
//
// class _FilterListState extends State<FilterList> {
//   int selectedIndex = 0; // first filter selected by default
//
//   final List<String> filters = [
//     "🔥Popular",
//     "🌋 Volcano",
//     "🏖️ Beach",
//     "🏞️ Nature",
//     "🏕️ Camp",
//     "🗻️ Mountain",
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: List.generate(filters.length, (index) {
//         return SingleFilter(
//           text: filters[index],
//           isSelected: selectedIndex == index,
//           onTap: () {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//         );
//       }),
//     );
//   }
// }
//
// class SingleFilter extends StatelessWidget {
//   final String text;
//   final bool isSelected;
//   final VoidCallback onTap;
//
//   const SingleFilter({
//     super.key,
//     required this.text,
//     required this.isSelected,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 10, right: 10),
//       child: GestureDetector(
//         onTap: onTap,
//         child: Container(
//           height: 40,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: isSelected ? Color(0xFF5296fa) : Color(0xFFf7f7f7),
//             borderRadius: BorderRadius.circular(25),
//             border: Border.all(
//               color: isSelected ? Colors.transparent : Colors.grey.shade400,
//               width: 2,
//             ),
//           ),
//           alignment: Alignment.center,
//           child: Text(
//             text,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.black,
//               fontSize: 16,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class CardList extends StatelessWidget {
  String name;
  String imgUrl;
  String location;
  bool isLoading;
  String rating;
  String demo1;
  String demo2;
  String demo3;

  CardList({
    super.key,
    required this.name,
    required this.isLoading,
    required this.imgUrl,
    required this.location,
    required this.rating,
    required this.demo1,
    required this.demo2,
    required this.demo3,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imgUrl: imgUrl,
              name: name,
              location: location,
              rating: rating,
              demo1: demo1,
              demo2: demo2,
              demo3: demo3,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 260,
        width: 190,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black.withOpacity(0.2),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🌅 Image with fixed height
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Center(child: ShimmerCard()),
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.broken_image)),
                      ),
                    ),
                  ),
                ),
                // 🏝️ Content
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF09453e),
                        ),
                      ),
                      SizedBox(height: 3),
                      Row(
                        children: [
                          Icon(
                            Icons.location_pin,
                            size: 14,
                            color: Colors.grey.shade600,
                          ),
                          SizedBox(width: 2),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6),
                      Row(
                        children: [
                          Icon(Icons.star, size: 16, color: Colors.amber),
                          SizedBox(width: 3),
                          Text(rating, style: TextStyle(fontSize: 13)),
                          Spacer(),

                          FvrtIcon(),
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

class CardListHorizontal extends StatelessWidget {
  String name;
  String imgUrl;
  String location;
  String rating;
  String demo1;
  String demo2;
  String demo3;

  CardListHorizontal({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.location,
    required this.rating,
    required this.demo1,
    required this.demo2,
    required this.demo3,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              imgUrl: imgUrl,
              name: name,
              location: location,
              rating: rating,
              demo1: demo1,
              demo2: demo2,
              demo3: demo3,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 170,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          shadowColor: Colors.black.withOpacity(0.2),
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Row(
              children: [
                // 🖼️ Image
                SizedBox(
                  height: 160,
                  width: 190,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            Center(child: Icon(Icons.broken_image)),
                        placeholder: (context, url) =>
                            Center(child: ShimmerCard()),
                      ),
                    ),
                  ),
                ),

                // 🧾 Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF09453e),
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 14,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 2),
                            Expanded(
                              child: Text(
                                location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(Icons.star, size: 16, color: Colors.amber),
                            SizedBox(width: 3),
                            Text(rating, style: TextStyle(fontSize: 13)),
                            Spacer(),
                            FvrtIcon(),
                            SizedBox(width: 5),
                          ],
                        ),
                        SizedBox(height: 8),
                        OverlappingAvatars(),
                      ],
                    ),
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

class FvrtIcon extends StatefulWidget {
  const FvrtIcon({super.key});

  @override
  State<FvrtIcon> createState() => _FvrtIconState();
}

class _FvrtIconState extends State<FvrtIcon> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          check = !check;
        });
      },
      child: Icon(
        check == true ? Icons.favorite : Icons.favorite_border,
        size: 20,
        color: Colors.redAccent,
      ),
    );
  }
}

class OverlappingAvatars extends StatelessWidget {
  const OverlappingAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      "https://avatars.githubusercontent.com/u/211104424?v=4",
      "https://randomuser.me/api/portraits/women/2.jpg",
      "https://randomuser.me/api/portraits/men/3.jpg",
    ];

    return SizedBox(
      width: 110, // Adjust width as needed
      height: 40,
      child: Stack(
        children: [
          for (int i = 0; i < 3; i++)
            Positioned(
              left: i * 25,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: CachedNetworkImageProvider(
                    [
                      "https://randomuser.me/api/portraits/women/2.jpg",
                      "https://avatars.githubusercontent.com/u/211104424?v=4",
                      "https://randomuser.me/api/portraits/men/3.jpg",
                    ][i],
                  ),
                ),
              ),
            ),
          Positioned(
            left: 3 * 25,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue.shade200,
                child: Text(
                  "+12k",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
