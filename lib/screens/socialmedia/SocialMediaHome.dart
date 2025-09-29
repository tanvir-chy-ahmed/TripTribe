import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:triptribe/screens/socialmedia/chat/chatingScreen.dart';
import 'package:triptribe/screens/socialmedia/componenets/post_slider.dart';
import 'package:triptribe/screens/socialmedia/componenets/story_data.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  @override
  Widget build(BuildContext context) {
    List<SData> myDataList = [
      SData(
        name: "Your Story",
        photo:
            "https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/499029099_18029526185670233_7526993224988534445_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby45MzYuYzIifQ&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=105&_nc_oc=Q6cZ2QFMl7vccxIB8mVLOx8u9xn9cLz11Wsr6MzUKNWfDFiiYSWN_AI9f6N_B1LpOek_r1E&_nc_ohc=RwE-053JyVcQ7kNvwEmJVJ8&_nc_gid=s8Qd6-C7HVnJmrf8_OwmUw&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_AfWdFfXOG4jxp2vo-st282sB1eO2ZhLgYpu5Up4_pDJ6Jg&oe=68A33029&_nc_sid=7d3ac5",
      ),

      SData(
        name: "Tanvir",
        photo: "https://avatars.githubusercontent.com/u/211104424?v=4",
      ),
      SData(
        name: "Diana",
        photo:
            "",
      ),
      SData(
        name: "Ethan",
        photo:
            "",
      ),
      SData(
        name: "Fiona",
        photo:
            "https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/529916314_17888396355335447_5082541763938354592_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=111&_nc_oc=Q6cZ2QG_7GTZIaRwoQ_yqG66U6xhOpA7dRJd4NjLPZGMG2Mi6O6CD8eHod8375R3HotS6tY&_nc_ohc=QNS-CTN5KsgQ7kNvwGFRC6P&_nc_gid=7AApvNyTDDRpm8e09Ozm2Q&edm=ALGbJPMBAAAA&ccb=7-5&oh=00_AfWREiZU8WCwOUrVPsj91KDTLGz9LeTeP_Zv-2hUFj8lSA&oe=68A33FA5&_nc_sid=7d3ac5",
      ),
      SData(
        name: "George",
        photo:
            "https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/428587771_1460861248111990_8363773842415897441_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=110&_nc_oc=Q6cZ2QEWbWpehbC3un_ydSHVMz6qDeEwGNzTImfGYDj_1CZycM7JyquTq0PemNbhBVGsZjM&_nc_ohc=auogAmggBGgQ7kNvwEGye0x&_nc_gid=QEc-Mu4RwSCQRR5G1GU6uQ&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AfUaNuEZpnYp6Oig-3fUKhUnsKL-huID7uXPXOQyT460oQ&oe=68A32AFB&_nc_sid=7a9f4b",
      ),

      SData(
        name: "Julia",
        photo:
            "https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/487429861_693185129805392_5237713188802216051_n.jpg?stp=dst-jpg_s320x320_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=108&_nc_oc=Q6cZ2QFVOdxFopaz5kp_j4Q4lNfuf4Ulf_wiYjyvlY52vTbb2ZFQhMa1sW9wM7wmn_anL1c&_nc_ohc=UbS-IoUZPfEQ7kNvwE6YEiU&_nc_gid=H_oCyVGJE5mLvNG4VR82mA&edm=AEJre34BAAAA&ccb=7-5&oh=00_AfW_EDISK7uo8aNbt4OdF45mccq0T5qribXihZBqWA9MRQ&oe=68A3190C&_nc_sid=35743f",
      ),
      SData(
        name: "Juliya",
        photo:
            "https://static.toiimg.com/thumb/msid-112842370,width-1280,height-720,resizemode-4/112842370.jpg",
      ),
      SData(
        name: "Alan",
        photo:
            "https://tintuc-divineshop.cdn.vccloud.vn/wp-content/uploads/2024/08/1-97.jpg",
      ),
      SData(
        name: "Hammad",
        photo:
            "https://media.licdn.com/dms/image/v2/D5603AQHJfY9unNN7dw/profile-displayphoto-shrink_200_200/B56Zb_FExOGsAY-/0/1748036242833?e=2147483647&v=beta&t=XMvz91wSr2534MCgoLvR7vGSDN0f0Nd0A38oGomftSQ",
      ),
    ];

    Future refresh() async {
      setState(() {});
    }

    return Scaffold(
      backgroundColor: const Color(0xFFf8f8f8),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color(0xFFF8F8F8),
              elevation: 0,
              automaticallyImplyLeading: false,
              floating: true,
              // AppBar hides/shows on scroll
              snap: true,
              // Snap effect when scrolling up
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Bigger Logo
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://github.com/walid269/test/blob/main/ChatGPT%20Image%20Aug%2014,%202025,%2009_30_12%20AM.png?raw=true',
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                  // Action Icons
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: CachedNetworkImage(
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/1077/1077035.png',
                          height: 24,
                          width: 24,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  ChattingScreen(),
                              transitionsBuilder:
                                  (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                final tween = Tween(
                                  begin: begin,
                                  end: end,
                                ).chain(CurveTween(curve: curve));
                                final offsetAnimation = animation.drive(tween);

                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        icon: CachedNetworkImage(
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/3024/3024593.png',
                          height: 24,
                          width: 24,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),

            // Body Content
            SliverList(
              delegate: SliverChildListDelegate([
                // Story section
                StoryScroller(stories: myDataList),
                const Divider(),

                SizedBox(height: 10),
                //post
                Column(
                  children: [
                    SizedBox(
                      height: 54,
                      width: 375,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 45,
                                  width: 45,
                                  imageUrl:
                                      'https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/17265790_427045080983585_8337130549214707712_a.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby40NTMuYzIifQ&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=105&_nc_oc=Q6cZ2QGXNNCmgsX0DGjai3ZzFz2-iFf5VZOTe_3B4lPEAJySIzqnqE2yNiCwjDFhOHZKfEM&_nc_ohc=3aH7R23-Bo4Q7kNvwFJudv5&_nc_gid=2r6B77Vy7WBf-uaU0sOBmA&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AfUWGk4MfniuHsYQEJrJVFe_Gq3yvjOZ7_d-7qF1wWS8HA&oe=68A3385F&_nc_sid=7a9f4b',
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'pavel durov',
                                        style: TextStyle(
                                          fontFamily: 'SF',
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://cdn-icons-png.flaticon.com/512/1271/1271750.png',
                                        height: 16,
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Moscow,Russia',
                                    style: TextStyle(
                                      fontFamily: 'SF',
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          Icon(Icons.more_horiz_outlined),
                        ],
                      ),
                    ),

                    //Image post
                    InstagramPostSlider(
                      images: [
                        'https://instagram.fdac177-1.fna.fbcdn.net/v/t51.29350-15/393112253_7019013634777457_6980744860331867286_n.webp?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQuaW1hZ2VfdXJsZ2VuLjE0NDB4MTQ0MC5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=105&_nc_oc=Q6cZ2QGXNNCmgsX0DGjai3ZzFz2-iFf5VZOTe_3B4lPEAJySIzqnqE2yNiCwjDFhOHZKfEM&_nc_ohc=8L2e5-q_yHEQ7kNvwHDpmDU&_nc_gid=2r6B77Vy7WBf-uaU0sOBmA&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzIxNjk5NTE3NDkzNTkxODU5Nw%3D%3D.3-ccb7-5&oh=00_AfUJ85Ya7-95fq_QkPKm0XzdojVWkGLoJzPoBUAiAceNvQ&oe=68A31DA5&_nc_sid=7a9f4b',
                        'https://instagram.fdac177-1.fna.fbcdn.net/v/t51.29350-15/343786126_1416142512478490_6380851318215873473_n.webp?stp=dst-jpg_e35_p640x640_sh0.08_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQuaW1hZ2VfdXJsZ2VuLjE0NDB4MTc0OS5zZHIuZjI5MzUwLmRlZmF1bHRfaW1hZ2UuYzIifQ&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=102&_nc_oc=Q6cZ2QGXNNCmgsX0DGjai3ZzFz2-iFf5VZOTe_3B4lPEAJySIzqnqE2yNiCwjDFhOHZKfEM&_nc_ohc=Mbt3zfq8Vy0Q7kNvwHDvLGW&_nc_gid=2r6B77Vy7WBf-uaU0sOBmA&edm=AP4sbd4BAAAA&ccb=7-5&ig_cache_key=MzA5MzA0MjMxMjUxNDM3ODY4OA%3D%3D.3-ccb7-5&oh=00_AfWtIA9GpAwTxC81HqWrKUJerdj68mRKHMdhs0z_UHbwJw&oe=68A30279&_nc_sid=7a9f4b',
                        'https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-15/13277631_2032550480305625_3865273457465884672_n.jpg?stp=dst-jpg_e35_tt6&efg=eyJ2ZW5jb2RlX3RhZyI6IkZFRUQuaW1hZ2VfdXJsZ2VuLjEwODB4MTA5Ni5zZHIuZjI4ODUuZGVmYXVsdF9pbWFnZS5jMiJ9&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=105&_nc_oc=Q6cZ2QF9ugVnd6r_S5qKH3Ww91UWcRiZJ5eH_t29rPCvzGOVY28aICL_DwHT7hfFSJo_nqM&_nc_ohc=aXfFj-i73OsQ7kNvwGPz2BG&_nc_gid=Wd61NU8SffK_BTa8OvkKnw&edm=APoiHPcBAAAA&ccb=7-5&ig_cache_key=MTQ3OTc1MTUzNTE1MDk2MjI3OQ%3D%3D.3-ccb7-5&oh=00_AfX3KTrN0My-hUDc2KU6vFAdaFTS_WxigSu5BkyP2n-QJQ&oe=68A32815&_nc_sid=22de04',
                      ],
                    ),

                    SizedBox(height: 10),

                    //Like row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 10),
                        //like icon
                        CachedNetworkImage(
                          color: Color(0xff262626),
                          height: 24,
                          width: 24,
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/1077/1077035.png',
                        ),

                        SizedBox(width: 20),
                        //comment icon
                        CachedNetworkImage(
                          color: Color(0xff262626),
                          height: 24,
                          width: 24,
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/5948/5948565.png',
                        ),

                        SizedBox(width: 20),
                        //share icon
                        CachedNetworkImage(
                          color: Color(0xff262626),
                          height: 24,
                          width: 24,
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/3024/3024593.png',
                        ),

                        // shows
                        SizedBox(width: 250),

                        //Favourite icon
                        CachedNetworkImage(
                          color: Color(0xff262626),
                          height: 24,
                          width: 24,
                          imageUrl:
                              'https://cdn-icons-png.flaticon.com/128/3082/3082331.png',
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(width: 10),

                        OverlappingAvatars(),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text('Liked by juliya and 44,686 others'),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 1000),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class OverlappingAvatars extends StatelessWidget {
  const OverlappingAvatars({super.key});

  @override
  Widget build(BuildContext context) {
    // final List<String> imageUrls = [
    //   "https://avatars.githubusercontent.com/u/211104424?v=4",
    //   "https://randomuser.me/api/portraits/women/2.jpg",
    //   "https://randomuser.me/api/portraits/men/3.jpg",
    // ];

    return SizedBox(
      width: 95, // Adjust width as needed
      height: 40,
      child: Stack(
        children: [
          // First two avatars
          for (int i = 0; i < 2; i++)
            Positioned(
              left: i * 25,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 14,
                  backgroundImage: NetworkImage(
                    [
                      "https://instagram.fdac177-1.fna.fbcdn.net/v/t51.2885-19/428587771_1460861248111990_8363773842415897441_n.jpg?efg=eyJ2ZW5jb2RlX3RhZyI6InByb2ZpbGVfcGljLmRqYW5nby4xMDgwLmMyIn0&_nc_ht=instagram.fdac177-1.fna.fbcdn.net&_nc_cat=110&_nc_oc=Q6cZ2QEWbWpehbC3un_ydSHVMz6qDeEwGNzTImfGYDj_1CZycM7JyquTq0PemNbhBVGsZjM&_nc_ohc=auogAmggBGgQ7kNvwEGye0x&_nc_gid=QEc-Mu4RwSCQRR5G1GU6uQ&edm=AP4sbd4BAAAA&ccb=7-5&oh=00_AfUaNuEZpnYp6Oig-3fUKhUnsKL-huID7uXPXOQyT460oQ&oe=68A32AFB&_nc_sid=7a9f4b",
                      "https://avatars.githubusercontent.com/u/211104424?v=4",
                    ][i],
                  ),
                ),
              ),
            ),

          // "+12k" text avatar
          Positioned(
            left: 2 * 25,
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue.shade200,
                child: Text(
                  "+12k",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
