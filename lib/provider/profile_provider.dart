import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../private/SharedPrefKeys.dart';


class ProfileImageProvider extends ChangeNotifier{
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<bool> getImage() async {
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
     selectedImage = File(pickedFile.path);
     notifyListeners(); //bccz setstate used here previously
      return true;
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File Exist ${pickedFile.path}")));
    } else {
      return false; //avoid ui or use buissness logics
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No file Selected")));
    }
  }

  Future<void> loadSavedImage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(PROFILE_IMAGE_KEY_SP)) {
      String? savedPath = prefs.getString(PROFILE_IMAGE_KEY_SP);
      if (savedPath != null && File(savedPath).existsSync()) {
         selectedImage = File(savedPath);
         notifyListeners();
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

}