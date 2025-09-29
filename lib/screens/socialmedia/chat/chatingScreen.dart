import 'dart:async';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triptribe/supabase/setup.dart';
import '../../../util/images.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  @override
  Widget build(BuildContext context) {
    //Searching Operation
    List<Map<String, dynamic>> searchresults = [];
    bool searching = false;
    final TextEditingController searchController = TextEditingController();
    Timer? debounce;
    void performsearch() async {
      final results = await searchpersons(searchController.text.trim());
      setState(() {
        searchresults = results;
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                  size: 20,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searching = false;
                            searchresults.clear();
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF0F0F0),
                // iOS Telegram grey
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12), // iOS style
                  borderSide: BorderSide.none, // no border
                ),
              ),
              onChanged: (value) {
                setState(() => searching = value.isNotEmpty);

                // Cancel previous debounce
                debounce?.cancel();

                debounce = Timer(const Duration(milliseconds: 300), () async {
                  if (value.isNotEmpty) {
                    searchresults = await searchpersons(value);
                  } else {
                    searchresults = [];
                  }
                  setState(() {});
                });
              },
              onSubmitted: (_) {
                setState(() => searching = true);
              },
            ),
          ),

          Slidable(
            // Specify a key if the Slidable is dismissible.
            key:  ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion:  ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {}),

              // All actions are defined in the children parameter.
              children:  [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (context){},
                  backgroundColor: Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
                SlidableAction(
                  onPressed: (context){},
                  backgroundColor: Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  // An action can be bigger than the others.
                  flex: 2,
                  onPressed: (context){},
                  backgroundColor: const Color(0xFF7BC043),
                  foregroundColor: Colors.white,
                  icon: Icons.archive,
                  label: 'Archive',
                ),
                SlidableAction(
                  onPressed:(context){} ,
                  backgroundColor: const Color(0xFF0392CF),
                  foregroundColor: Colors.white,
                  icon: Icons.save,
                  label: 'Save',
                ),
              ],
            ),

            // The child of the Slidable is what the user sees when the
            // component is not dragged.
            child: SingleChatBox(
                          ispin: true,
                          title: "Saved Messages",
                          lastseen: "Fri",
                          urlAvatar: "https://cdn-icons-png.flaticon.com/512/10329/10329949.png",
                          subtitile: "Hello There",
                          ispendingmsg: false
                      )





          ),




        ],
      ),
    );
  }
}

class SingleChatBox extends StatelessWidget {
  final String title;
  final String lastseen;
  final String subtitile;
  final String urlAvatar;
  final bool ispin;
  final bool ispendingmsg;

  const SingleChatBox({
    super.key,
    required this.ispin,
    required this.title,
    required this.lastseen,
    required this.urlAvatar,
    required this.subtitile,
    required this.ispendingmsg,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(lastseen, style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitile, style: TextStyle(color: Colors.grey.shade600)),
              ispin
                  ? Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: ImageIcon(
                          AssetImage(Images.pin),
                          color: Colors.grey,
                          size: 16,
                        ),
                      ),
                    )
                  : SizedBox.shrink(), // invisible placeholder
            ],
          ),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Container(
              height: 60,
              width: 60,
              color: Colors.blue,
              child: CachedNetworkImage(imageUrl: urlAvatar),
            ),
          ),
        ),
        Divider(indent: 90, thickness: 0.8),
      ],
    );
  }
}
