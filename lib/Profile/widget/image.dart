import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  const Photo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            child: CircleAvatar(
              backgroundImage: null,//Profile Image
              backgroundColor: Colors.grey,
              radius: 40,
              // child: Icon(Icons.camera_alt),
            ),
          );
  }
}