import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    required this.initialApiUrl,
    required this.onVideoChanged,
  }) : super(key: key);

  final String initialApiUrl;
  final Function(String) onVideoChanged;

  @override
  State<CustomVideoPlayer> createState() =>
      _CustomVideoPlayerState(initialApiUrl, onVideoChanged);
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late String videoUrl;
  late YoutubePlayerController _controller;
  final String initialApiUrl;
  final Function(String) onVideoChanged;

  _CustomVideoPlayerState(this.initialApiUrl, this.onVideoChanged);

  @override
  void initState() {
    videoUrl = 'https://www.youtube.com/watch?v=$initialApiUrl';
    final videoID = YoutubePlayer.convertUrlToId(videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        controlsVisibleAtStart: true,
      ),
    );

    super.initState();
  }

  void enterFullScreen() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _controller.toggleFullScreenMode();
  }

  void exitFullScreen() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(const Duration(seconds: 1), () {
      _controller.play();
    });
    Future.delayed(const Duration(seconds: 5), () {
      SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: OrientationBuilder(
        builder: (context, orientation) {
          return YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                _controller.addListener(() {
                  if (_controller.value.isFullScreen) {
                    // Do something when entering fullscreen
                  } else {
                    // Do something when exiting fullscreen
                  }
                });
              },
            ),
            builder: (context, player) {
              return Scaffold(
                appBar: AppBar(title: const Text('الفيديو'),),
                body: player,
              );
            },
          );
        },
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    if (oldWidget.initialApiUrl != widget.initialApiUrl) {
      final newVideoUrl = 'https://www.youtube.com/watch?v=${widget.initialApiUrl}';
      final newVideoID = YoutubePlayer.convertUrlToId(newVideoUrl);

      if (_controller.initialVideoId != newVideoID) {
        _controller.load(newVideoID!);
        onVideoChanged(widget.initialApiUrl);
      }
    }
    super.didUpdateWidget(oldWidget);
  }
}
