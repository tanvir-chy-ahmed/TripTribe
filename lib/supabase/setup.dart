import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

Future<List<Map<String, dynamic>>> fetchAllImagesShuffled() async {
  try {
    final response = await supabase.from('homescreen').select();
    if (response.isNotEmpty) {
      final images = List<Map<String, dynamic>>.from(response);
      images.shuffle(); // Randomize order
      return images;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> fetchCoutryCatagoryScreen() async {
  try {
    final response = await supabase.from('countrycgscreen').select();
    if (response.isNotEmpty) {
      final images = List<Map<String, dynamic>>.from(response);
      images.shuffle(); // Randomize order
      return images;
    } else {
      return [];
    }
  } catch (e) {
    return [];
  }
}

Future<List<Map<String, dynamic>>> searchplaces(String query) async {
  try {
    final response = await supabase
        .from('homescreen')
        .select()
        .or('name.ilike.%$query%,location.ilike.%$query%');

    // .ilike('name', '%$query%');// search in the 'name' column

    print("\n\n\nerror $response\n\n\n");
    if (response.isNotEmpty) {
      final results = List<Map<String, dynamic>>.from(response);
      results.shuffle();
      return results;
    } else {
      return [];
    }
  } catch (e) {
    print("\n\n\nerror $e\n\n\n");
    print("\n\n\nerror $e\n\n\n");
    return [];
  }
}




