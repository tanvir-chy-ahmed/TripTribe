import 'package:flutter/material.dart';
import 'package:triptribe/screens/socialmedia/SocialMediaHome.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color(0xFFf8f8f8),
            appBar: AppBar(
              backgroundColor: const Color(0xFFf8f8f8),
              elevation: 0,
              automaticallyImplyLeading: false, // Prevents default back button
              actions: [
                Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text("Post")
                ),
              ],
              title: Row(
                children: [
                  // Back Button
                  TextButton(onPressed: (){
                   Navigator.pop(context);
                  }, 
                      child: Text("Cancel")),

                  const Spacer(), // Balances the row

                  // Notification Icon
                ],
              ),
            ),

     body: Text(
                  "What's Happening",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
    );
  }
}