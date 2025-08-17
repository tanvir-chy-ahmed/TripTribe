import 'package:flutter/material.dart';

class InstagramPostSlider extends StatefulWidget {
  final List<String> images;
  const InstagramPostSlider({Key? key, required this.images}) : super(key: key);

  @override
  State<InstagramPostSlider> createState() => _InstagramPostSliderState();
}

class _InstagramPostSliderState extends State<InstagramPostSlider> {
  final PageController _controller = PageController();
  int _current = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // keep it square
      child: Stack(
        children: [
          // ----------------  Image pages  ----------------
          PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (idx) => setState(() => _current = idx),
            itemBuilder: (_, idx) => _buildImage(widget.images[idx]),
          ),

          // ---------------  Top‑right counter -------------
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '${_current + 1}/${widget.images.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),

          // ------------  Bottom‑center indicator dots -----
          Positioned(
            bottom: 12,          // distance from bottom edge
            left: 0,
            right: 0,           // widen to full width so Row can center itself
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.images.length,
                    (idx) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  height: 6,
                  width: _current == idx ? 16 : 6,
                  decoration: BoxDecoration(
                    color: _current == idx
                        ? Colors.blueAccent
                        : Colors.white.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    final isNetwork = path.startsWith('http');
    return isNetwork
        ? Image.network(path, fit: BoxFit.cover, width: double.infinity)
        : Image.network(path, fit: BoxFit.cover, width: double.infinity);
  }
}




