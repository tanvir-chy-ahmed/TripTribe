import 'package:flutter/material.dart';
import 'package:triptribe/navigationbar/bnview.dart';
/*

Feautres-
  # current location nearest famous places & their distance mesaure type
  # explore screen card show how much tour famous places in this country this type overview instead rating
 */
void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FloatingNavBarScreen(),
    );
  }
}
