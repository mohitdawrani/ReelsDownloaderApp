// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_insta/flutter_insta.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// //import 'package:path_provider/path_provider.dart';
// //import 'package:permission_handler/permission_handler.dart';
// import 'dart:isolate';
// //import 'package:flutter/services.dart';

// class InstaReels extends StatefulWidget {
//   //final String title  ;
//   const InstaReels({ Key? key,  }) : super(key: key);

//   //final String title;
//   @override
//   _InstaReelsState createState() => _InstaReelsState();
// }

// class _InstaReelsState extends State<InstaReels> {
//   TextEditingController reelController = TextEditingController();
  
//   var icon;
//   //int _counter = 0;
//   var id;
//   bool downloading = false;
//   bool pressed = false;
//   void _downloadFile() async {
//     var myvideourl = await FlutterInsta().downloadReels(reelController.text);

//     await FlutterDownloader.enqueue(
//       url: '$myvideourl',
//       savedDir: '/sdcard/Download',
//       showNotification: true,
//       fileName: 'filename',
//       // show download progress in status bar (for Android)
//       openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//     ).whenComplete(() {
//       setState(() {
//         downloading = false; // set to false to stop Progress indicator
//       });
//     });
//   }
//   int progress = 0;
//   ReceivePort _receivePort = ReceivePort();
//   @override
//   void initState(){
//     super.initState();
//     IsolateNameServer.registerPortWithName(_receivePort.sendPort,"downloadingnvideo");

//     _receivePort.listen((message) {
//       setState(() {
//        progress = message[2];
        
//       });
//     });

//     FlutterDownloader.registerCallback(downloadCallback);
//     super.initState();
//   }

//   static downloadCallback(id, status, progress) {
//     SendPort sendPort = IsolateNameServer.lookupPortByName("downloadingnvideo")!;
//     sendPort.send(progress);
    
//   }

  
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
//                     height: 10,
//                 ), 
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
//                           Color.fromARGB(255,254, 218, 119),                                          
//                           Color.fromARGB(255,221, 42, 123), 
//                           Color.fromARGB(255,129, 52, 175),
//                           Color.fromARGB(255,81, 91, 212),                          
//                         ],                        
//                       ),
//                       borderRadius:BorderRadius.circular(10.0),
//                       boxShadow: [
//                             BoxShadow(
//                               color: Colors.black,
//                               blurRadius: 3.0,
//                             ),
//                           ],
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
//                       borderRadius:BorderRadius.circular(10.0),
//                       gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight,
//                         colors: [
//                           Color.fromARGB(255,245, 133, 41),                                          
//                           Color.fromARGB(255,221, 42, 123), 
//                           Color.fromARGB(255,129, 52, 175),
//                           Color.fromARGB(255,81, 91, 212),                          
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
//                 onTap: (){
//                   FocusScope.of(context).unfocus();
//                 },
//                 child: TextField(
//                   controller: reelController,
//                   decoration: new InputDecoration(
//                           labelText: "Url",
//                           fillColor: Colors.grey,
//                           filled: true,                       
//                           //fillColor: Colors.green
//                           border: InputBorder.none,
//                           enabledBorder: OutlineInputBorder(),
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
//                 shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
//                 child: Container(
//                   width: 310.0,
//                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                   child: Center(
//                     child: const Text('Paste',style: TextStyle(fontSize: 20)),
//                   ),
//                   decoration: const BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(80.0)),                    
//                     gradient: LinearGradient(                      
//                       colors: <Color>[
//                         Color.fromARGB(255,129, 52, 175),
//                         Color.fromARGB(255,221, 42, 123), 
//                       ],
//                     ),
//                     boxShadow: [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 3.0,
//                         ),
//                       ],                    
//                   ),
                                    
//                 ),
//               ),
              
//                SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 clipBehavior: Clip.antiAlias,
//                 height: 360.0,
//                 width: 311.0,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius:BorderRadius.circular(10.0),
//                    boxShadow: [
//                         BoxShadow(
//                           color: Colors.black,
//                           blurRadius: 3.0,
//                         ),
//                       ],
//                 ),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 00),
//                       child: Container(
//                         height: 300.0,
//                         width: 300.0,
//                         decoration: BoxDecoration(
//                           color: Colors.blue[100]
//                         ),
//                         child:id,
//                         ),
//                     ),
//                     Container(
//                       height: 50.0,
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         //color: Colors.red[100]
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Icon(Icons.share),
//                           Icon(Icons.save),
                          
//                           IconButton(
//                             onPressed: (){
//                               setState(() {
//                                 downloading = true; //set to true to show Progress indicator
//                               });
//                               _downloadFile();
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
//                 '#$progress',
//                 style: Theme.of(context).textTheme.headline4,
//               )
//             ],        
//           ),
//         ),
//       ),      
      
//     );
//   }

  
// }