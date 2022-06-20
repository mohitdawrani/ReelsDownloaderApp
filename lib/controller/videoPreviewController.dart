import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VideoPreviewController extends GetxController {
  var isPreview = false.obs;
  String? url;

  @override
  void onClose() {
    if (playerController != null) {
      if (playerController!.isPlaying()!) {
        playerController!.pause();
        // playerController!.dispose();
      }
    }

    super.onClose();
  }

  BetterPlayerConfiguration _betterPlayerConfiguration =
      BetterPlayerConfiguration(
    aspectRatio: 1,
    fit: BoxFit.contain,
    autoDispose: false,
    controlsConfiguration: BetterPlayerControlsConfiguration(
      enableOverflowMenu: false,
      enablePlayPause: false,
      enableSkips: false,
      enableFullscreen: false,
      playIcon: CupertinoIcons.play_circle,
      pauseIcon: CupertinoIcons.pause_circle,
      fullscreenEnableIcon: CupertinoIcons.fullscreen,
      fullscreenDisableIcon: CupertinoIcons.fullscreen_exit,
      controlBarHeight: 30.0,
      enableProgressBar: false,
      enableProgressText: false,
    ),
  );

  BetterPlayerController? playerController;

  VideoPreviewController() {
    playerController = BetterPlayerController(_betterPlayerConfiguration);
  }

  void setPlayerURL(String url) {
    this.url = url;
    isPreview.value = true;
    if (playerController != null) {
      playerController!.setupDataSource(BetterPlayerDataSource.network(url));
    }
  }
}
