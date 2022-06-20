import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:insta_extractor/insta_extractor.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reels_downloader_app/contants.dart';
import 'package:path/path.dart' as path;
import 'package:reels_downloader_app/controller/notificationController.dart';
import 'package:reels_downloader_app/controller/reelsHistoryController.dart';
import 'package:reels_downloader_app/controller/videoPreviewController.dart';

class ReelsDownloaderController extends GetxController {
  NotificationController _notificationController = NotificationController();
  VideoPreviewController _videoPreviewController =
      Get.put(VideoPreviewController());
  ReelsHistoryController _reelsHistoryController = ReelsHistoryController();
  final GetStorage box = GetStorage('downloadedReels');
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late AndroidDeviceInfo androidInfo;

  var isDownloading = false.obs;
  var downloadProgress = 0.obs;

  ReelsDownloaderController() {
    init();
  }

  init() async {
    androidInfo = await deviceInfo.androidInfo;
  }

  bool _linkValidation(String link) {
    String url = link;
    if (url.trim().isEmpty) {
      errorSnackBar(msg: "URL Can't be Empty!");
      return false;
    } else {
      return true;
    }
  }

  Future<Directory?> _getDownloadDirectory() async {
    Directory directory;
    if (Platform.isAndroid) {
      directory = (await getExternalStorageDirectory())!;
      String newPath = "";
      print(directory);
      List<String> paths = directory.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }
      newPath = newPath + "/Reels Videos Downloaded";
      directory = Directory(newPath);
      return directory;
      // return await DownloadsPathProvider.downloadsDirectory;
    }
    return await getApplicationDocumentsDirectory();
  }

  Future<bool> _requestPermissions() async {
    var storagePermission = await Permission.storage.status;
    // var externalStorageManagePermission =
    //     await Permission.manageExternalStorage.status;
    if (storagePermission != PermissionStatus.granted) {
      storagePermission = await Permission.storage.request();

      if (storagePermission != PermissionStatus.granted) {
        Get.snackbar("Allow Permission", "Please Allow Storage Permission");
      }
    }
    return storagePermission == PermissionStatus.granted;
  }

  Future<String> _getDownloadableLink(String rawURL) async {
    try {
      var linkEdit = rawURL.replaceAll(" ", "").split("/");
      var downloadURL = await Dio().get(
          '${linkEdit[0]}//${linkEdit[2]}/${linkEdit[3]}/${linkEdit[4]}' +
              "/?__a=1");
      print(downloadURL);
      var data = downloadURL.data;
      var graphql = data['graphql'];
      var shortcodeMedia = graphql['shortcode_media'];
      var videoUrl = shortcodeMedia['video_url'];
      return videoUrl;
    } catch (e) {
      print("Error in Get Downloadable Link : $e");
    }
    return "";
  }

  Future _downloadFile(String fileURL, String savePath) async {
    return await Dio().download(fileURL, savePath,
        onReceiveProgress: (received, total) {
      int percentage = ((received / total) * 100).floor();
      downloadProgress.value = percentage;
    });
  }

  Future<Map<String, dynamic>> _startDownload(String link) async {
    Map<String, dynamic> result = {
      'isSuccess': false,
      'filePath': null,
      'error': null,
      'downloadableLink': null
    };

    if (await _requestPermissions()) {
      // geting Video Link
      await _getDownloadableLink(link).catchError((e) {
        errorSnackBar(msg: "Wrong URL!");
      }).then((downloadableLink) async {
        String downloadableURL = downloadableLink;
        if (downloadableURL != "") {
          //Generating Filename
          DateTime now = DateTime.now();
          String formatedDate = DateFormat("yyyy-MM-dd – kk:mm:s").format(now);
          String fileName = "InstaReelVideo - " + formatedDate + ".mp4";

          // Downloading Video
          try {
            final dir = await _getDownloadDirectory();
            final savePath = path.join(dir!.path, fileName);
            print(androidInfo.version.sdkInt);
            if (androidInfo.version.sdkInt >= 29) {
              var appDocDir = await getTemporaryDirectory();
              String saveDirectory = appDocDir.path + "/temp.mp4";
              final response =
                  await _downloadFile(downloadableURL, saveDirectory);
              result['isSuccess'] = response.statusCode == 200;
              result['filePath'] = saveDirectory;
              await ImageGallerySaver.saveFile(saveDirectory).catchError((e) {
                result['isSuccess'] = false;
              });
            } else {
              final response = await _downloadFile(downloadableURL, savePath);
              result['isSuccess'] = response.statusCode == 200;
              result['filePath'] = savePath;
            }

            result['downloadableLink'] = downloadableURL;
            print(downloadableURL);
            print(savePath);
          } catch (e) {
            print("Error: $e");
            result['error'] = e.toString();
          } finally {
            //Showing Notification
            await _notificationController.showDownloadNotification(result);
          }
        } else {
          errorSnackBar(msg: "Wrong URL!");
        }
      });
    }
    return result;
  }

  downloadReel({required TextEditingController linkTextController}) async {
    if (isDownloading.value) errorSnackBar(msg: "Download in Progress");
    String link = linkTextController.text;
    if (_linkValidation(link)) {
      isDownloading.value = true;
      try {
        await _startDownload(link).then((value) async {
          if (value["isSuccess"]) {
            await _reelsHistoryController.storeHistory(
                videoURL: value["downloadableLink"]);
            successSnackBar(
                title: "Download Successfully",
                msg: "Reel Video Downloaded Successfully!");
          }
        });
      } catch (e) {
        print("error: $e");
        errorSnackBar(msg: "Something Went Wrong! Try Again!");
      }
      // linkTextController.clear();
      isDownloading.value = false;
      downloadProgress = RxInt(0);
    }
  }

  Future<void> pasteLink(TextEditingController controller) async {
    controller.text = await FlutterClipboard.paste();
    try {
      _getDownloadableLink(controller.text).catchError((e) {}).then((value) {
        if (value != "") {
          _videoPreviewController.setPlayerURL(value);
        } else {
          errorSnackBar(msg: "Wrong URL!");
        }
      });
    } catch (e) {
      print(e);
      errorSnackBar(msg: "Wrong URL!");
    }
  }
}
