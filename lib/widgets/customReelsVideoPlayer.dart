import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';

class BuildReelsVideoPlayer extends StatelessWidget {
  const BuildReelsVideoPlayer({
    Key? key,
    required this.videoURL,
  }) : super(key: key);

  final String videoURL;

  @override
  Widget build(BuildContext context) {
    return BetterPlayer.network(
      videoURL,
      betterPlayerConfiguration: BetterPlayerConfiguration(
        fit: BoxFit.contain,
        aspectRatio: 9 / 16,
        looping: true,
        autoPlay: true,
        errorBuilder: (context, error) {
          return Container(
            alignment: Alignment.center,
            child: Text("Something Went Wrong, Try Again!"),
          );
        },
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enableProgressBar: false,
          enableProgressText: false,
          enableFullscreen: false,
          enableSkips: false,
          enablePlayPause: false,
          enableOverflowMenu: false,
          controlBarHeight: 20.0,
          playIcon: CupertinoIcons.play_circle_fill,
          pauseIcon: CupertinoIcons.pause_circle_fill,
          showControlsOnInitialize: false,
        ),
      ),
    );
  }
}
