import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triptribe/screens/detailsscreen/DetailsScreen.dart';
import 'package:triptribe/screens/explorescreen/ExploreScreen.dart';
import 'package:triptribe/screens/profile/screen/ProfileScreen.dart';
import 'package:triptribe/screens/shimmer/shimmer_card.dart';
import 'package:triptribe/screens/socialmedia/chat/chatingScreen.dart';
import 'package:triptribe/util/images.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true; // or use a state variable
  final TextEditingController searchController = TextEditingController();

  File? _selectedImage;
  final ProfileImageKey = "I4M3jK3Y0fdfa";

  @override
  initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
        _loadSavedImage();
      });
    });
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(ProfileImageKey)) {
      String? savedPath = prefs.getString(ProfileImageKey);
      if (savedPath != null && File(savedPath).existsSync()) {
        setState(() => _selectedImage = File(savedPath));
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Loaded existing file: $savedPath")),
        // );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No file selected and no file saved")),
      );
    }
  }

  Future<void> _reresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _reresh,
      child: Scaffold(
        backgroundColor: Color(0xFFf2f2f2),
        appBar: AppBar(
          backgroundColor: Color(0xFFf2f2f2),
          elevation: 0,
          leadingWidth: 220,
          // enough width to fit avatar + texts
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
                      child: _selectedImage == null
                          ? Image.network(
                              "https://preview.redd.it/umvub4tgwxt61.jpg?auto=webp&s=92f15de309c9701dfa14e7922072aa3bf0061746",
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : ClipOval(
                              child: Image.file(
                                _selectedImage!,
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

        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "\t\tExplore ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Default color
                        ),
                      ),
                      TextSpan(
                        text: "the ",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black, // Blue color only for Tanvir
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Explore tours and adventures...',
                      hintStyle: TextStyle(color: Colors.grey),
                      prefixIcon: Icon(Icons.search),

                      //IconButton(onPressed: (){},icon: Image.asset(Images.filter,color: Colors.black,),)
                      suffixIcon: IconButton(
                        onPressed: () {
                          //✅Logic Filter
                        },
                        icon: Image.asset(Images.filter, color: Colors.black),
                      ),
                      filled: true,
                      fillColor: Color(0xffffffff),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.black45),
                      ),
                    ),
                    style: TextStyle(fontSize: 16),
                    textInputAction: TextInputAction.search,
                    //use next to go next field
                    // use when you want to go next textfield
                    //onEditingComplete: () => FocusScope.of(context).requestFocus(passFocusMode),
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    enableSuggestions: true,
                    cursorColor: Colors.blue,
                    onChanged: (value) {
                      // setState(() {}); // Update suffix icon
                      // Add debounce logic if needed
                    },
                    onSubmitted: (value) {
                      // Perform search
                    },
                  ),
                ),

                //For FIlters
                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(children: [FilterList()]),
                // ),
                //
                // SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "🔥 Hot right now",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ExploreScreen(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  final tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: curve));
                                  final offsetAnimation = animation.drive(
                                    tween,
                                  );

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                      child: Text(
                        "View all   ",
                        style: TextStyle(
                          color: Color(0xFF5296fa),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                //Scrollable Row Of Places
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        CardList(
                          name: 'Bali Beach',
                          imgUrl:
                              'https://images.pexels.com/photos/9094948/pexels-photo-9094948.jpeg',
                          location: 'Indonesia',
                          rating: '4.8',
                          isLoading: isLoading,
                        ),

                        CardList(
                          name: 'Istanbul City',
                          imgUrl:
                              'https://images.pexels.com/photos/27705570/pexels-photo-27705570.jpeg',
                          location: 'Turkey',
                          rating: '5.0',
                          isLoading: isLoading,
                        ),

                        CardList(
                          isLoading: isLoading,
                          name: 'Venice',
                          imgUrl:
                              'https://i.pinimg.com/1200x/1c/1e/b6/1c1eb67149c3e3bc8cef02e9c516266a.jpg',
                          location: 'Italy',
                          rating: '4.5',
                        ),

                        CardList(
                          isLoading: isLoading,
                          name: 'Egypt',
                          imgUrl:
                              'https://i.pinimg.com/736x/d5/61/cb/d561cbb96fb806f40499179f04958f1c.jpg',
                          location: 'Misr',
                          rating: '4.0',
                        ),

                        CardList(
                          name: 'Blue Mosque',
                          imgUrl:
                              'https://i.pinimg.com/736x/7c/ff/ef/7cffef675634d9e268a5c8def95e342a.jpg',
                          location: 'Turkey',
                          rating: '4.3',
                          isLoading: isLoading,
                        ),

                        CardList(
                          name: 'Sajek Velly',
                          imgUrl:
                              'https://i.pinimg.com/736x/8f/81/ec/8f81ec6d7ed97b40b99b60dba6a395c8.jpg',
                          location: 'Bangladesh',
                          rating: '3.5',
                          isLoading: isLoading,
                        ),

                        CardList(
                          name: 'Niagara Falls',
                          imgUrl:
                              'https://i.pinimg.com/736x/87/65/bc/8765bc048b1d0fdcd6684a4e301fa8c3.jpg',
                          location: 'Canada',
                          rating: '4.4',
                          isLoading: isLoading,
                        ),
                        SizedBox(width: 20),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => ExploreScreen(),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;

                                        final tween = Tween(
                                          begin: begin,
                                          end: end,
                                        ).chain(CurveTween(curve: curve));
                                        final offsetAnimation = animation.drive(
                                          tween,
                                        );

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                ),
                              );
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                color: Color(0xFF5296fa),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 5),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Explore More",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    //Go To Explore Screen
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ExploreScreen(),
                            transitionsBuilder:
                                (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  final tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: curve));
                                  final offsetAnimation = animation.drive(
                                    tween,
                                  );

                                  return SlideTransition(
                                    position: offsetAnimation,
                                    child: child,
                                  );
                                },
                          ),
                        );
                      },
                      //Navigate explore more screen
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ExploreScreen(),
                              transitionsBuilder:
                                  (
                                    context,
                                    animation,
                                    secondaryAnimation,
                                    child,
                                  ) {
                                    const begin = Offset(1.0, 0.0);
                                    const end = Offset.zero;
                                    const curve = Curves.ease;

                                    final tween = Tween(
                                      begin: begin,
                                      end: end,
                                    ).chain(CurveTween(curve: curve));
                                    final offsetAnimation = animation.drive(
                                      tween,
                                    );

                                    return SlideTransition(
                                      position: offsetAnimation,
                                      child: child,
                                    );
                                  },
                            ),
                          );
                        },
                        child: Text(
                          "View all   ",
                          style: TextStyle(
                            color: Color(0xFF5296fa),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //Scrollable Row Of Places
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CardListHorizontal(
                          name: 'Beach',
                          imgUrl:
                              'https://images.pexels.com/photos/3601422/pexels-photo-3601422.jpeg',
                          location: 'Maldives',
                          rating: '5.2',
                        ),

                        CardListHorizontal(
                          name: 'Santorini',
                          imgUrl:
                              'https://images.pexels.com/photos/1029021/pexels-photo-1029021.jpeg',
                          location: 'Greece',
                          rating: '5.0',
                        ),

                        CardListHorizontal(
                          name: 'Banff National Park',
                          imgUrl:
                              'https://images.pexels.com/photos/33297495/pexels-photo-33297495.jpeg',
                          location: 'Canada',
                          rating: '4.5',
                        ),

                        CardListHorizontal(
                          name: 'Machu Picchu',
                          imgUrl:
                              'https://images.pexels.com/photos/17060849/pexels-photo-17060849.jpeg',
                          location: 'Peru',
                          rating: '4.0',
                        ),

                        CardListHorizontal(
                          name: 'Northern Lights in Iceland',
                          imgUrl:
                              'https://images.pexels.com/photos/11180713/pexels-photo-11180713.jpeg',
                          location: 'Norway',
                          rating: '4.5',
                        ),

                        CardListHorizontal(
                          name: 'Plitvice Lakes',
                          imgUrl:
                              'https://images.pexels.com/photos/17503328/pexels-photo-17503328.jpeg',
                          location: 'Croatia',
                          rating: '4.7',
                        ),

                        CardListHorizontal(
                          name: 'Ha Long Bay',
                          imgUrl:
                              'https://images.pexels.com/photos/4390720/pexels-photo-4390720.jpeg',
                          location: 'Vietnam',
                          rating: '4.4',
                        ),
                        SizedBox(height: 10),

                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                      ) => ExploreScreen(),
                                  transitionsBuilder:
                                      (
                                        context,
                                        animation,
                                        secondaryAnimation,
                                        child,
                                      ) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.ease;

                                        final tween = Tween(
                                          begin: begin,
                                          end: end,
                                        ).chain(CurveTween(curve: curve));
                                        final offsetAnimation = animation.drive(
                                          tween,
                                        );

                                        return SlideTransition(
                                          position: offsetAnimation,
                                          child: child,
                                        );
                                      },
                                ),
                              );
                            },
                            child: Text(
                              "View all",
                              style: TextStyle(
                                color: Color(0xFF5296fa),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 100),
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

  CardList({
    super.key,
    required this.name,
    required this.isLoading,
    required this.imgUrl,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen()),
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
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: Icon(Icons.broken_image)),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: ShimmerCard());
                        },
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

  CardListHorizontal({
    super.key,
    required this.name,
    required this.imgUrl,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailsScreen()),
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
                      child: Image.network(
                        imgUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Center(child: Icon(Icons.broken_image)),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: ShimmerCard());
                        },
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
                  backgroundImage: NetworkImage(
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
