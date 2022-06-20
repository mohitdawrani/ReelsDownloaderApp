import 'package:flutter/material.dart';
import 'package:reels_downloader_app/contants.dart';

class InfoDrawer extends StatelessWidget {
  const InfoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        child: Column(
          children: [
            // DrawerHeader(
            //   child: Container(
            //     child: Center(
            //       child: Image.asset("assets/images/notification-icon.png"),
            //     ),
            //   ),
            // ),
            ListTile(
              title: Text(
                "Storage Location",
                style: TextStyle(fontSize: 18.0),
              ),
              subtitle: Text(
                kPath,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Divider(
              height: 0.0,
              thickness: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
