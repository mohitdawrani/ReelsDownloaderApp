import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reels_downloader_app/controller/thumbnailController.dart';

class ReelsHistoryController extends GetxController {
  ThumbnailController _thumbnailController = ThumbnailController();
  final GetStorage box = GetStorage('downloadedReels');

  var historyReels = [].obs;

  ReelsHistoryController() {
    getHistoryReels();
  }

  Future<String?> _getThumnailFileName({required String videoURL}) async {
    return await _thumbnailController.generateVideoThumbnail(
        videoURL: videoURL);
  }

  Future<void> storeHistory({required String videoURL}) async {
    String? thumbnailURL = await _getThumnailFileName(videoURL: videoURL);
    Map<String, dynamic> data = {
      "videoURL": videoURL,
      "thumbnailURL": thumbnailURL
    };
    if (box.read("downloadedReelsLinks") != null) {
      var list = box.read("downloadedReelsLinks");
      list.insert(0, data);
      box.write("downloadedReelsLinks", list);
    } else {
      box.write("downloadedReelsLinks", [data]);
    }
    //Current Insert
    historyReels.insert(0, data);
  }

  void getHistoryReels() async {
    var fetchedData = await box.read("downloadedReelsLinks");
    historyReels.clear();
    if (fetchedData != null) historyReels.addAll(fetchedData);
  }
}
