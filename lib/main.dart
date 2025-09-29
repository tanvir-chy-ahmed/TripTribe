import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptribe/provider/profile_provider.dart';
import 'package:triptribe/screens/onboard/controller/onb_ctrl.dart';
import 'package:provider/provider.dart';
import 'private/SharedPrefKeys.dart';

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
    url: URL_SUPABASE,
    anonKey:ANON_KEY_SUPABASE
  );
  // await Firebase.initializeApp();
  //MainScreen()
  runApp(
    ChangeNotifierProvider(
        create: (_) => ProfileImageProvider()..loadSavedImage(),
        child: MainScreen() //Mainscreen all widgetts can access profileimgprovider,but prblm is its single provider
    )
  );
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
