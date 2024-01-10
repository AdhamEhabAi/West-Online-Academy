import 'package:elmanasa/models/video_model.dart';
import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  final Video video;
  final Function(String) onVideoSelected; // Add this line
  const VideoCard({Key? key, required this.video, required this.onVideoSelected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        onVideoSelected(video.firstUrl);

      },
      child: Row(
        children: [
          Image.asset(
            'assets/icons/play.png',
            height: 45,
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  video.views,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
