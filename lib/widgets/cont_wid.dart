import 'package:flutter/material.dart';

class icon_cont extends StatelessWidget {
  icon_cont({super.key , required this.text , required this.icon});
  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left : 8.0 , right: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(height: 5,),
            Text(text),
          ],
        ),
      ),
    );
  }
}
