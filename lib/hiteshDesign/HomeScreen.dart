// import 'package:flutter/material.dart';
// // import 'package:reels/downlods.dart';
// // import 'package:reels/instagram.dart';
// // import 'package:flutter_downloader/flutter_downloader.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({ Key? key }) : super(key: key);
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
// class _HomeScreenState extends State<HomeScreen> {

//   TabController? tabController;

//   @override
//   void initState() {
//     super.initState();
//     //tabController = TabController(vsync: this, initialIndex: 1, length: 2);
//     initializeDownloader();
    
//   }

//   void initializeDownloader() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     // await FlutterDownloader.initialize(debug: true // optional: set false to disable printing logs to console
//     // );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Insta Reels Downloader"),
//           backgroundColor: Colors.grey[800],
//           bottom: TabBar(
//             controller: tabController,
//             tabs: [
             
//               Tab(
//                 child: Text("Downloding"),
//               ),
//               Tab(
//                 child: Text("Downlods"),
//               )
//             ],
//           ),
//         ),
//         drawer: Drawer(),
//         body:TabBarView(
//           controller: tabController,
//           children: [
//             // InstaReels(),
//             // Downlods()
//           ],
//         ),
//       ),
//     );
//   }
// }