import 'dart:io' show File;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  final String ProfileImageKey = "I4M3jK3Y0fdfa";

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
      if (prefs.containsKey(ProfileImageKey)) {
        String? oldPath = prefs.getString(ProfileImageKey);
        if (oldPath != null && File(oldPath).existsSync()) {
          await File(oldPath).delete();
        }
      }

      await prefs.setString(ProfileImageKey, pickedFile.path);
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
    if (prefs.containsKey(ProfileImageKey)) {
      String? savedPath = prefs.getString(ProfileImageKey);
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
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Stack(
                  children: [
                    _selectedImage == null
                        ? ClipOval(
                            child: Image.network(
                              "https://preview.redd.it/umvub4tgwxt61.jpg?auto=webp&s=92f15de309c9701dfa14e7922072aa3bf0061746",
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: GestureDetector(
                          onTap: _getImage,

                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.blue,
                            ),
                            padding: EdgeInsets.all(6),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Account",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),

            Column(
              children: [
                CustomCard("My Trips", Icons.shopping_bag_outlined),
                SizedBox(height: 15),
                CustomCard("My Plan", Icons.monetization_on_outlined),
                SizedBox(height: 15),
                CustomCard("Trip History", Icons.history),
                SizedBox(height: 15),
                CustomCard("Top Contributers", Icons.cached),
                SizedBox(height: 15),
                CustomCard("My Trips", Icons.star_border_purple500_outlined),
                SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable image widget
Widget CustomCard(String name, IconData icon) => Container(
  height: 75,
  width: double.infinity,
  decoration: BoxDecoration(
    color: Colors.grey.shade50,
    borderRadius: BorderRadius.circular(30),
  ),
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Icon(icon),
            ),
            SizedBox(width: 10),
            Text(name, style: TextStyle(fontSize: 20)),
          ],
        ),

        Icon(Icons.arrow_drop_down),
      ],
    ),
  ),
);
