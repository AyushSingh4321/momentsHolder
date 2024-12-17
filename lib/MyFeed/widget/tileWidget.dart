import 'package:flutter/material.dart';

class TileWidget extends StatelessWidget {
  final title;
  final url;
  TileWidget(this.title, this.url);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Image1',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              height: 300,
              width: deviceSize.width - 16,
              decoration: BoxDecoration(color: Colors.grey),
              child: Image.network(
                  fit: BoxFit.cover,
                  url),
            )
          ],
        )
      ],
    );
  }
}
