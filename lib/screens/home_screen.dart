import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reels_downloader_app/contants.dart';
import 'package:reels_downloader_app/controller/notificationController.dart';
import 'package:reels_downloader_app/screens/downloaded_reels_history.dart';
import 'package:reels_downloader_app/screens/reels_download_screen.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  late AndroidDeviceInfo androidInfo;
  PersistentBottomSheetController? _bottomSheetController;
  bool bottomSheetOpened = false;

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  NotificationController notificationController = NotificationController();

  @override
  void initState() {
    homeInit();
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.instance.getToken().then((value) => print(value));
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      RemoteNotification? notification = event.notification;
      print(notification!.title);
      notificationController.showFcmNotification(
          title: notification.title!, msg: notification.body!);
    });
    super.initState();
  }

  // Future _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   print("Handling a background message: ${message.messageId}");
  // }

  homeInit() async {
    androidInfo = await deviceInfo.androidInfo;
    if (androidInfo.version.sdkInt >= 29) {
      kPath = "/storage/emulated/0/Pictures";
    } else {
      kPath = "/storage/emulated/0/Download";
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ));
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
          preferredSize: new Size(MediaQuery.of(context).size.width, 55.0),
          child: Container(
            decoration: BoxDecoration(
              gradient: kPrimaryLinearGradient,
            ),
            child: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.light,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
              ),
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                    splashRadius: 20.0,
                    onPressed: () {
                      // if (_scaffoldKey.currentState != null)
                      //   _scaffoldKey.currentState!.openEndDrawer();
                      try {
                        if (!bottomSheetOpened) {
                          _bottomSheetController =
                              _scaffoldKey.currentState!.showBottomSheet(
                            (context) {
                              return Container(
                                height: 150.0,
                                padding: EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Thank You For Using Our App",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        letterSpacing: 1.2,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Rate us on Google Play Store",
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Divider(
                                      thickness: 2.0,
                                      height: 30.0,
                                    ),
                                    Center(
                                      child: Text(
                                        "Storage Location",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        kPath,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            elevation: 10.0,
                            backgroundColor: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                          );
                        } else {
                          if (_bottomSheetController != null) {
                            _bottomSheetController!.close();
                            _bottomSheetController = null;
                          }
                        }
                        setState(() => bottomSheetOpened = !bottomSheetOpened);
                      } catch (e) {
                        print(e);
                        setState(() => bottomSheetOpened = false);
                      }
                    },
                    icon: Icon(CupertinoIcons.info_circle)),
              ],
              backgroundColor: Colors.transparent,
              title: TabBar(
                labelColor: Colors.white,
                indicatorColor: Colors.white,
                unselectedLabelStyle: TextStyle(
                  color: Colors.white,
                ),
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                indicatorSize: TabBarIndicatorSize.label,
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.arrow_down_circle,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Download",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          CupertinoIcons.rectangle_grid_3x2,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "History",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
          ),
        ),
        // endDrawer: InfoDrawer(),
        body: UpgradeAlert(
          canDismissDialog: true,
          showReleaseNotes: false,
          child: TabBarView(
            children: [
              ReelsDownloadScreen(),
              DownloadedReelsHistoryScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
