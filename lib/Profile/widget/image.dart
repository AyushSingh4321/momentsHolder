import 'package:flutter/material.dart';

class Photo extends StatelessWidget {
  String url;
  Photo(this.url);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: CircleAvatar(
        backgroundImage: url!=null? NetworkImage(url): null, //Profile Image
        backgroundColor: Colors.grey,
        radius: 40,
        // child: Icon(Icons.camera_alt),
      ),
    );
  }
}
