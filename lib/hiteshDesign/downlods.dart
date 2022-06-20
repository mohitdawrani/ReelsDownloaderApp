import 'package:flutter/material.dart';

class Downlods extends StatefulWidget {
  const Downlods({ Key? key }) : super(key: key);

  @override
  _DownlodsState createState() => _DownlodsState();
}

class _DownlodsState extends State<Downlods> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  color: Colors.black38,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}