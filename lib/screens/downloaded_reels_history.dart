import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reels_downloader_app/controller/reelsHistoryController.dart';
import 'package:reels_downloader_app/widgets/customReelsVideoPlayer.dart';

class DownloadedReelsHistoryScreen extends StatelessWidget {
  final ReelsHistoryController _reelsHistoryController =
      ReelsHistoryController();
  final GetStorage box = GetStorage('downloadedReels');

  DownloadedReelsHistoryScreen() {
    box.listenKey('downloadedReelsLinks', (value) {
      _reelsHistoryController.getHistoryReels();
    });
  }

  void showVideoDialog({required BuildContext context, required String url}) {
    showDialog(
        context: context,
        barrierColor: Colors.white38,
        builder: (context) {
          return Container(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              backgroundColor: Colors.transparent,
              contentPadding: EdgeInsets.all(0.0),
              elevation: 10.0,
              content: AspectRatio(
                aspectRatio: 9 / 16,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: BuildReelsVideoPlayer(videoURL: url),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Obx(
          () => _reelsHistoryController.historyReels.isNotEmpty
              ? GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: _reelsHistoryController.historyReels.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    //mainAxisExtent: 400,
                    childAspectRatio: 2 / 4,
                  ),
                  itemBuilder: (context, index) {
                    File file = File(_reelsHistoryController.historyReels[index]
                        ["thumbnailURL"]);
                    return GestureDetector(
                      onTap: () {
                        showVideoDialog(
                            context: context,
                            url: _reelsHistoryController.historyReels[index]
                                ["videoURL"]);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.file(
                                file,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: 55,
                                height: 55,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  CupertinoIcons.play_circle,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  child: Center(
                    child: Text("No History"),
                  ),
                ),
        ),
      ),
    );
  }
}
