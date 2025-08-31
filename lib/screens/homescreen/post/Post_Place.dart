import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:triptribe/screens/homescreen/HomeScreen.dart';

class PostPlaceScreen extends StatefulWidget {
  const PostPlaceScreen({super.key});

  @override
  State<PostPlaceScreen> createState() => _PostPlaceScreenState();
}

class _PostPlaceScreenState extends State<PostPlaceScreen> {
  final TextEditingController PlaceNameCtrl = TextEditingController();
  final TextEditingController ratingCtrl = TextEditingController();
  final TextEditingController LocationCtrl = TextEditingController();
  final TextEditingController DescriptionCtrl = TextEditingController();
  final TextEditingController ImageUrlCtrl = TextEditingController();
  final TextEditingController DemoImageUrlCtrl_1 = TextEditingController();
  final TextEditingController DemoImageUrlCtrl_2 = TextEditingController();
  final TextEditingController DemoImageUrlCtrl_3 = TextEditingController();
  final TextEditingController DemoImageUrlCtrl_4 = TextEditingController();
  final TextEditingController DemoImageUrlCtrl_5 = TextEditingController();
  final FocusNode loacationNode = FocusNode();
  bool isImageBoxBlank = true;

  addPlace() async {
    await Supabase.instance.client.from('homescreen').insert({
      'imgUrl': ImageUrlCtrl.text.trim(),
      'location': LocationCtrl.text.trim(),
      'name': PlaceNameCtrl.text.trim(),
      'description': DescriptionCtrl.text.trim(),
      'rating': ratingCtrl.text.trim(),
    });
  }

  addSubPlace() async {
    await Supabase.instance.client.from('subdemo').insert({
      'demo1': DemoImageUrlCtrl_1.text.trim(),
      'demo2': DemoImageUrlCtrl_2.text.trim(),
      'demo3': DemoImageUrlCtrl_3.text.trim(),
      'demo4': DemoImageUrlCtrl_4.text.trim(),
      'demo5': DemoImageUrlCtrl_5.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Place Upload"), centerTitle: true),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 1.2,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: () async {
            if (PlaceNameCtrl.text.trim().isNotEmpty &&
                ratingCtrl.text.trim().isNotEmpty &&
                LocationCtrl.text.trim().isNotEmpty &&
                DescriptionCtrl.text.trim().isNotEmpty &&
                ImageUrlCtrl.text.trim().isNotEmpty &&
                DemoImageUrlCtrl_1.text.trim().isNotEmpty) {
              await addPlace();
              await addSubPlace();
              // Button click logic
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Successfully Uploaded")));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Must be fill up all fields")),
              );
            }
          },
          icon: Icon(Icons.cloud_upload_sharp),
          label: Text(
            "Publish",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width,
                  child: ShowDialog(
                    ImageUrlCtrl: ImageUrlCtrl,
                    isImageBoxBlank: isImageBoxBlank,
                    isBig: true,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 390),
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(42),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(42),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ShowDialog(
                                        ImageUrlCtrl: DemoImageUrlCtrl_1,
                                        isImageBoxBlank: isImageBoxBlank,
                                        isBig: false,
                                      ),
                                      SizedBox(width: 8),
                                      ShowDialog(
                                        ImageUrlCtrl: DemoImageUrlCtrl_2,
                                        isImageBoxBlank: isImageBoxBlank,
                                        isBig: false,
                                      ),
                                      SizedBox(width: 8),
                                      ShowDialog(
                                        ImageUrlCtrl: DemoImageUrlCtrl_3,
                                        isImageBoxBlank: isImageBoxBlank,
                                        isBig: false,
                                      ),
                                      SizedBox(width: 8),
                                      ShowDialog(
                                        ImageUrlCtrl: DemoImageUrlCtrl_4,
                                        isImageBoxBlank: isImageBoxBlank,
                                        isBig: false,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: PlaceNameCtrl,
                                    focusNode: loacationNode,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Place Name',
                                      hintStyle: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      border: InputBorder.none,
                                      // removes all borders
                                      isDense: true,
                                      // removes extra vertical padding
                                      contentPadding: EdgeInsets
                                          .zero, // aligns perfectly with text
                                    ),
                                    cursorColor: Colors.blue,
                                    textInputAction: TextInputAction.next,
                                  ),
                                ),

                                Text(
                                  '\$120.5' + '/person',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal, // Optional
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Location input
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_pin,
                                        size: 20,
                                        color: Colors.grey.shade500,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: TextField(
                                          controller: LocationCtrl,
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade500,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Location',
                                            hintStyle: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black.withOpacity(
                                                0.5,
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                          cursorColor: Colors.blue,
                                          textInputAction: TextInputAction.next,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Rating input
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  // 👈 prevents overflow
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(width: 3),
                                    SizedBox(
                                      width: 40,
                                      // 👈 fixed width for rating field
                                      child: TextField(
                                        controller: ratingCtrl,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: '0.0',
                                          hintStyle: TextStyle(fontSize: 20),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.zero,
                                        ),
                                        cursorColor: Colors.blue,
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: 10),
                            OverlappingAvatars(),
                            SizedBox(height: 10),
                            ProductTabView(descCtrl: DescriptionCtrl),
                            SizedBox(height: 500),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable image widget
Widget ImageContainer(String url) {
  return Container(
    height: 80,
    width: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      image: DecorationImage(
        image: CachedNetworkImageProvider(url),
        fit: BoxFit.cover,
      ),
    ),
  );
}

class ProductTabView extends StatelessWidget {
  TextEditingController descCtrl;

  ProductTabView({super.key, required this.descCtrl});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
            tabs: [
              Tab(text: 'Description'),
              Tab(text: 'Maps'),
              Tab(text: 'Review'),
            ],
          ),
          SizedBox(
            height: 250, // Give height so TabBarView doesn't get 0 height
            child: TabBarView(
              children: [
                // Description Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),

                      TextField(
                        controller: descCtrl,
                        // your TextEditingController
                        maxLines: null,
                        // makes it expandable for multi-line text
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter description...',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          border: InputBorder.none,
                          // removes underline/border
                          isDense: true,
                          // compact vertical padding
                          contentPadding: EdgeInsets.zero,
                        ),
                        cursorColor: Colors.blue,
                        textInputAction: TextInputAction.newline,
                      ),
                    ],
                  ),
                ),

                // Review Tab
                Center(child: Text("No Maps Content yet")),
                Center(child: Text("No reviews yet")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShowDialog extends StatefulWidget {
  TextEditingController ImageUrlCtrl;
  bool isImageBoxBlank;
  bool isBig = true;

  ShowDialog({
    super.key,
    required this.ImageUrlCtrl,
    required this.isImageBoxBlank,
    required this.isBig,
  });

  @override
  State<ShowDialog> createState() => _ShowDialogState();
}

class _ShowDialogState extends State<ShowDialog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: Container(
              width: double.maxFinite,
              // take available width
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Upload Image Button
                  TextButton.icon(
                    onPressed: () {
                      // TODO: open image picker
                    },
                    icon: const Icon(Icons.image, color: Colors.blue),
                    label: const Text(
                      "Upload Image",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Image URL / Note Input
                  TextField(
                    controller: widget.ImageUrlCtrl,
                    decoration: InputDecoration(
                      hintText: 'Image URL',
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(Icons.link, color: Colors.blue),
                      suffixIcon: widget.ImageUrlCtrl.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                widget.ImageUrlCtrl.clear();
                                setState(() {}); // refresh suffix
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    style: const TextStyle(fontSize: 16),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.blue,
                    onChanged: (value) {
                      setState(() {}); // refresh suffix icon visibility
                    },
                    onSubmitted: (value) {
                      print("Submitted: $value");
                      // TODO: handle URL / Note submission
                    },
                  ),
                ],
              ),
            ),

            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  // button color
                  foregroundColor: Colors.white,
                  // text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  // button color
                  foregroundColor: Colors.white,
                  // text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  elevation: 4,
                ),
                onPressed: () {
                  String url = widget.ImageUrlCtrl.text.trim();
                  if (url.startsWith('https://')) {
                    setState(() {
                      widget.isImageBoxBlank = false;
                    });
                    Navigator.pop(context); // only pop if valid
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please Enter a Valid URL")),
                    );
                  }
                },

                child: const Text(
                  'Set',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
      child: widget.isImageBoxBlank
          ? Icon(Icons.cloud_upload_rounded, size: widget.isBig ? 300 : 100)
          : widget.isBig
          ? CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.cover,
              imageUrl: widget.ImageUrlCtrl.text.trim(),
              errorWidget: (context, url, error) => Center(
                child: Icon(Icons.broken_image, size: widget.isBig ? 300 : 100),
              ),
              // placeholder: (context, url) =>
              //     Center(child: ShimmerCard()),
            )
          : ImageContainer(widget.ImageUrlCtrl.text.trim()),
    );
  }
}
