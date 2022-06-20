import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:reels_downloader_app/contants.dart';
import 'package:reels_downloader_app/controller/reelsDownloaderController.dart';
import 'package:reels_downloader_app/controller/videoPreviewController.dart';
import 'package:reels_downloader_app/widgets/submitButton.dart';

class ReelsDownloadScreen extends StatefulWidget {
  @override
  _ReelsDownloadScreenState createState() => _ReelsDownloadScreenState();
}

class _ReelsDownloadScreenState extends State<ReelsDownloadScreen> {
  final ReelsDownloaderController _reelsDownloaderController =
      ReelsDownloaderController();

  final VideoPreviewController _videoPreviewController =
      Get.put(VideoPreviewController());

  TextEditingController linkController = new TextEditingController();

  final GetStorage box = GetStorage('downloadedReels');

  @override
  void dispose() {
    if (_videoPreviewController.playerController != null) {
      _videoPreviewController.playerController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: ListView(
            // physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding * 2),
            children: [
              Form(
                child: TextFormField(
                  controller: linkController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        linkController.clear();
                        FocusScope.of(context).unfocus();
                        _videoPreviewController.isPreview.value = false;
                      },
                      splashRadius: 20.0,
                      color: Colors.black,
                      // iconSize: 30.0,
                      tooltip: "Clear Text",
                      icon: Icon(Icons.clear_rounded),
                    ),
                    prefixIcon: IconButton(
                      onPressed: () async {
                        await _reelsDownloaderController
                            .pasteLink(linkController);
                        // FocusScope.of(context).unfocus();
                      },
                      splashRadius: 20.0,
                      color: Colors.blue,
                      // iconSize: 28.0,
                      tooltip: "Paste Link",
                      icon: Icon(Icons.paste_rounded),
                    ),
                    border: InputBorder.none,
                    hintText: "Paste Link Here",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildSubmitButton(
                    label: "Paste",
                    onTap: () {
                      // print(box.read("downloadedReelsLinks"));
                      _reelsDownloaderController.pasteLink(linkController);
                    },
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  BuildSubmitButton(
                    label: "Download",
                    onTap: () {
                      _reelsDownloaderController.downloadReel(
                          linkTextController: linkController);
                    },
                  ),
                ],
              ),
              Obx(() {
                if (_reelsDownloaderController.isDownloading == RxBool(true)) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: LinearPercentIndicator(
                      percent: _reelsDownloaderController.downloadProgress
                              .toDouble() /
                          100,

                      backgroundColor: Colors.grey[300],
                      // progressColor: kPrimaryColor,
                      linearGradient: LinearGradient(
                        colors: <Color>[
                          Color.fromARGB(255, 129, 52, 175),
                          Color.fromARGB(255, 221, 42, 123),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.2, 1.0],
                      ),
                      center: Text(
                        _reelsDownloaderController.downloadProgress
                                    .toDouble() ==
                                0.0
                            ? "Loading..."
                            : "${_reelsDownloaderController.downloadProgress.toDouble()}%",
                        style: TextStyle(color: Colors.white),
                      ),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      lineHeight: 20.0,
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
              Obx(() => Center(
                    child: _videoPreviewController.isPreview.value
                        ? Container(
                            clipBehavior: Clip.antiAlias,
                            margin: EdgeInsets.all(20.0).copyWith(top: 40.0),
                            constraints: BoxConstraints(
                              maxWidth: 350.0,
                              minHeight: 300.0,
                            ),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black,
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue[100]),
                                      child: _videoPreviewController
                                              .isPreview.value
                                          ? Stack(
                                              children: [
                                                Container(
                                                  child: BetterPlayer(
                                                      controller:
                                                          _videoPreviewController
                                                              .playerController!),
                                                ),
                                                // Align(
                                                //   alignment: Alignment.topRight,
                                                //   child: IconButton(
                                                //     onPressed: () {},
                                                //     color: Colors.white,
                                                //     icon: Icon(Icons.share_rounded),
                                                //   ),
                                                // )
                                              ],
                                            )
                                          : Container(
                                              child: Center(
                                                child: Icon(
                                                  CupertinoIcons.play_circle,
                                                  size: 100.0,
                                                ),
                                              ),
                                            )
                                      // child:id,
                                      ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox.shrink(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
