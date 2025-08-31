import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Simple Components model (adjust if you already declared SData elsewhere)
@immutable
class SData {
  final String name;
  final String photo;

  const SData({required this.name, required this.photo});
}

/// Re‑usable story scroller widget
class StoryScroller extends StatelessWidget {
  final List<SData> stories;
  final double avatarSize;
  final TextStyle nameStyle;
  final EdgeInsetsGeometry padding;

  const StoryScroller({
    super.key,
    required this.stories,
    this.avatarSize = 68, // diameter of the circle
    this.nameStyle = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis,
    ),
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: avatarSize + 28, // room for avatar + name text
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: padding,
        itemCount: stories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (_, index) {
          final story = stories[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar with border (optional)
              Container(
                width: avatarSize,
                height: avatarSize,
                padding: const EdgeInsets.all(2),

                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5296fa), // soft sky blue
                      Color(0xFF5296fa), // pale blue
                      Color(0xFF99CCFF), // pastel blue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: story.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: avatarSize + 4, // keep text width close to avatar
                child: Text(
                  story.name,
                  style: nameStyle,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
