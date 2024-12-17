import './widget/tileWidget.dart';
import 'package:flutter/material.dart';

class Myfeed extends StatelessWidget {
  const Myfeed({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> urls = [
      'https://gratisography.com/wp-content/uploads/2024/11/gratisography-cool-sphere-1170x780.jpg',
      'https://images.pexels.com/photos/674010/pexels-photo-674010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended
      (
        onPressed: () {
          // Add your gallery functionality here
        },
        label: const Text('Add from gallery'),
        icon: const Icon(Icons.browse_gallery_outlined),
      ),
   
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < urls.length; i++)
              TileWidget('Image ${i + 1}', urls[i]),
          ],
        ),
      ),
    );
  }
}
