import 'package:flutter/material.dart';
import 'package:reels_downloader_app/contants.dart';

class BuildSubmitButton extends StatelessWidget {
  const BuildSubmitButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
          gradient: kPrimaryLinearGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
