import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptribe/screens/onboard/controller/onb_ctrl.dart';

/*
Feautres-
  # current location nearest famous places & their distance mesaure type
  # make shimmer for details screen -  isImageBoxBlank
                          ? Icon(Icons.cloud_upload_rounded, size: 300)
                          : CachedNetworkImage(
                              imageUrl: ImageUrlCtrl.text.trim(),
                              errorWidget: (context, url, error) =>
                                  Center(child: Icon(Icons.broken_image)),
                              // placeholder: (context, url) =>
                              //     Center(child: ShimmerCard()),
                            ),
  # explore screen card show how much tour famous places in this country this type overview instead rating
 */
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://fjyxowmcrqfledlqrbuy.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZqeXhvd21jcnFmbGVkbHFyYnV5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTE2MjAyNDgsImV4cCI6MjA2NzE5NjI0OH0.sFNcBSBo9z3LmVhOdLJRL79F8ooLDORLKW7DWKKOy3I",
  );
  // await Firebase.initializeApp();
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingController(),
    );
  }
}
