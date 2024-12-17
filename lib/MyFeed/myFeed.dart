import 'dart:io';
import 'dart:math';

import 'package:assignment2/Authentication/auth_service.dart';
import 'package:assignment2/MyFeed/model/post_model.dart';
import 'package:assignment2/cloudinary/cloud.dart';
import 'package:image_picker/image_picker.dart';

import './widget/tileWidget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String? kimage;
final uId = AuthService().getCurrentUser()!.uid;
final List<PostModel> urls = [];
 TextEditingController title = new TextEditingController();

class Myfeed extends StatefulWidget {
  const Myfeed({super.key});

  @override
  State<Myfeed> createState() => _MyfeedState();
}

class _MyfeedState extends State<Myfeed> {
 
  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch posts when the widget initializes
  }

  // Method to fetch data from Firestore
  Future<void> _fetchPosts() async {
    try {
      var postSnapshot =
          await FirebaseFirestore.instance.collection('All Posts').get();

      // Clear previous data
      urls.clear();

      // Add each post to the 'urls' list
      for (var doc in postSnapshot.docs) {
        var post = PostModel.fromJson(doc.data());
        urls.add(post);
      }

      setState(() {}); // Update UI after data is fetched
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add your gallery functionality here
          _showImageUploadDialog(context);
        },
        label: const Text('Add from gallery'),
        icon: const Icon(Icons.browse_gallery_outlined),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < urls.length; i++)
              TileWidget(urls[i].userName, urls[i].imageUrl),
          ],
        ),
      ),
    );
  }
}

void _showImageUploadDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () async {
                File? img = await pickImageFromGallery(context);
                print("Image Upload Icon Clicked");
                if (img != null) print('Image selected successfully');
                kimage =
                    await CloudinaryService().uploadImageToCloudinary(img!);
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.upload_rounded,
                  size: 40,
                  color: Colors.grey[700],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: title,
              decoration: InputDecoration(
                labelText: 'Image Heading',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                prefixIcon: Icon(Icons.title),
              
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Database details added here
                    addDataToDatabase(title.text, kimage!, generateUserId(), uId);
                    Navigator.pop(context);
                    print("Save Clicked");
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

Future<void> addDataToDatabase(
    String name, String image, String postId, String userId) async {
  try {
    var temp =
        await FirebaseFirestore.instance.collection("All Posts").doc(postId);
    var temp2 = PostModel(
        userName: name, imageUrl: image, postId: postId, userId: userId);
    await temp.set(temp2.toJson());
    print('DONE!!!!');
  } catch (e) {
    print("Error adding post: $e");
  }
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("An error occurred: $e")),
    );
  }
  return image;
}

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}

String generateUserId() {
  Random random = Random();
  int randomNumber = 10000 +
      random.nextInt(90000); // Generates a number between 10000 and 99999
  return randomNumber.toString();
}
