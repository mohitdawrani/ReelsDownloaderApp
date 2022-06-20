// import 'package:flutter/material.dart';
// import 'package:reels_downloader_app/controller/reelsDownloaderController.dart';

// class ReelsDownloadScreen extends StatelessWidget {
//   final ReelsDownloaderController _reelsDownloaderController =
//       ReelsDownloaderController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(
//                 height: 10,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     height: 130.0,
//                     width: 150.0,
//                     child: Icon(Icons.settings),
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color.fromARGB(255, 254, 218, 119),
//                           Color.fromARGB(255, 221, 42, 123),
//                           Color.fromARGB(255, 129, 52, 175),
//                           Color.fromARGB(255, 81, 91, 212),
//                         ],
//                       ),
//                       borderRadius: BorderRadius.circular(10.0),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 3.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     width: 19,
//                   ),
//                   Container(
//                     height: 130.0,
//                     width: 150.0,
//                     child: Icon(Icons.camera_alt),
//                     decoration: BoxDecoration(
//                       //color: Colors.red[100],
//                       borderRadius: BorderRadius.circular(10.0),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color.fromARGB(255, 245, 133, 41),
//                           Color.fromARGB(255, 221, 42, 123),
//                           Color.fromARGB(255, 129, 52, 175),
//                           Color.fromARGB(255, 81, 91, 212),
//                         ],
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 3.0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: TextField(
//                   controller: _reelsDownloaderController.linkController,
//                   decoration: new InputDecoration(
//                     labelText: "Url",
//                     fillColor: Colors.grey,
//                     filled: true,
//                     //fillColor: Colors.green
//                     border: InputBorder.none,
//                     enabledBorder: OutlineInputBorder(),
//                   ),
//                   enabled: true,
//                 ),
//               ),
//               SizedBox(
//                 height: 15.0,
//               ),
//               MaterialButton(
//                 onPressed: () {},
//                 textColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(80.0)),
//                 child: Container(
//                   width: 310.0,
//                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                   child: Center(
//                     child: const Text('Paste', style: TextStyle(fontSize: 20)),
//                   ),
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(80.0)),
//                     gradient: LinearGradient(
//                       colors: <Color>[
//                         Color.fromARGB(255, 129, 52, 175),
//                         Color.fromARGB(255, 221, 42, 123),
//                       ],
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black,
//                         blurRadius: 3.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 clipBehavior: Clip.antiAlias,
//                 height: 360.0,
//                 width: 311.0,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(10.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black,
//                       blurRadius: 3.0,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 00),
//                       child: Container(
//                         height: 300.0,
//                         width: 300.0,
//                         decoration: BoxDecoration(color: Colors.blue[100]),
//                         // child:id,
//                       ),
//                     ),
//                     Container(
//                       height: 50.0,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                           //color: Colors.red[100]
//                           ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Icon(Icons.share),
//                           Icon(Icons.save),
//                           IconButton(
//                             onPressed: () {
//                               // _downloadFile();
//                             },
//                             icon: Icon(Icons.download),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Text("download percentage"),
//               Text(
//                 '#100',
//                 style: Theme.of(context).textTheme.headline4,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
