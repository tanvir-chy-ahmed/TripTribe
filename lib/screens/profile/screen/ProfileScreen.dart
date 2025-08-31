import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:triptribe/private/SharedPrefKeys.dart';
import 'package:triptribe/screens/profile/screen/EditProfile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;


  @override
  void initState() {
    super.initState();
    _loadSavedImage(); // Load image on widget start
  }

  Future<void> _getImage() async {
    final prefs = await SharedPreferences.getInstance();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // 1️⃣ Delete old file if exists
      if (prefs.containsKey(PROFILE_IMAGE_KEY_SP)) {
        String? oldPath = prefs.getString(PROFILE_IMAGE_KEY_SP);
        if (oldPath != null && File(oldPath).existsSync()) {
          await File(oldPath).delete();
        }
      }

      await prefs.setString(PROFILE_IMAGE_KEY_SP, pickedFile.path);
      setState(() => _selectedImage = File(pickedFile.path));
      // Button click logic
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("File Exist ${pickedFile.path}")));
    } else {
      // Button click logic
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("No file Selected")));
    }
  }

  Future<void> _loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(PROFILE_IMAGE_KEY_SP)) {
      String? savedPath = prefs.getString(PROFILE_IMAGE_KEY_SP);
      if (savedPath != null && File(savedPath).existsSync()) {
        setState(() => _selectedImage = File(savedPath));
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Loaded existing file: $savedPath")),
        // );
      }
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text("No file selected and no file saved")),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf2f2f2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf2f2f2),
        elevation: 5,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            children: [
              Text(
                "tanvir.chy.0",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Profile Image + Stats Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      _selectedImage == null
                          ? Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://preview.redd.it/umvub4tgwxt61.jpg?auto=webp&s=92f15de309c9701dfa14e7922072aa3bf0061746",
                                  width: 115,
                                  height: 115,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 3,
                                ),
                              ),
                              child: ClipOval(
                                child: Image.file(
                                  _selectedImage!,
                                  width: 115,
                                  height: 115,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GestureDetector(
                            onTap: _getImage,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.all(6),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 25),
                  Column(
                    children: [
                      Text(
                        "3",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Post",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(width: 18),
                  Column(
                    children: [
                      Text(
                        "25",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Followers",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                  SizedBox(width: 18),
                  Column(
                    children: [
                      Text(
                        "25",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Following",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 15),
              Text(
                "Be Your Own Pookie & Stay sukhi \nBecause Others will always Make you dukhi❤️‍🩹",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),

              SizedBox(height: 20),
              // 🔹 Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile()),
                      );
                    },
                    icon: SizedBox(),
                    label: Text(
                      "Edit Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xa5f0f1f6),
                      foregroundColor: Color(0xa5f0f1f6),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      try {
                        await Share.share("Hello from Flutter! https://example.com");
                      } catch (e) {
                        print("Share error: $e");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Error: $e")),
                        );
                      }
                    },

                    icon: SizedBox(),
                    label: Text(
                      "Share Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xa5f0f1f6),
                      foregroundColor: Color(0xa5f0f1f6),
                      padding: EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // 🔹 Product Tab View
              ScrollToTopExample(),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}

class ScrollToTopExample extends StatefulWidget {
  const ScrollToTopExample({super.key});

  @override
  State<ScrollToTopExample> createState() => _ScrollToTopExampleState();
}

class _ScrollToTopExampleState extends State<ScrollToTopExample> {
  final ScrollController parentController = ScrollController();
  final ScrollController gridController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Listen to GridView scroll
    gridController.addListener(() {
      if (gridController.position.atEdge) {
        bool isBottom = gridController.position.pixels != 0;
        if (isBottom) {
          // Scroll parent to top
          parentController.animateTo(
            0,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    parentController.dispose();
    gridController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double tabHeight = MediaQuery.of(context).size.height * 0.6;

    return SingleChildScrollView(
      controller: parentController,
      child: DefaultTabController(
        length: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(icon: Icon(Icons.grid_on_outlined)),
                Tab(icon: Icon(Icons.video_library_outlined)),
                Tab(icon: Icon(Icons.favorite_border)),
              ],
            ),
            SizedBox(
              height: tabHeight,
              child: TabBarView(
                children: [
                  // 🔹 Posts Grid Tab (scrollable)
                  GridView.builder(
                    controller: gridController,
                    padding: EdgeInsets.all(2),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return Image.network(
                        "https://picsum.photos/id/${index + 10}/300/300",
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Center(child: Text("No Videos Content yet")),
                  Center(child: Text("No Liked yet")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//make sure length is same of your tab
