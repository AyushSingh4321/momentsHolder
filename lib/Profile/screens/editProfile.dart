import 'dart:io'; // For File handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../pickers/user_image_picker.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});
  static const routeName = '/profile';

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  final _formKey = GlobalKey<FormState>();
  File? _userImageFile;

  // Controllers for text fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _bio = TextEditingController();

  // Function to pick image from gallery
  void _pickedImage(File image) {
    _userImageFile = image;
  }

  // Save button action
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      print('Name: ${_nameController.text}');
      print('Mobile No: ${_city.text}');
      print('Aadhaar No: ${_bio.text}');
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Profile image
                UserImagePicker(_pickedImage),
                SizedBox(height: 20),

                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Mobile Number field
                TextFormField(
                  controller: _city,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Aadhaar Number field
                TextFormField(
                  controller: _bio,
                  decoration: InputDecoration(
                    labelText: 'Bio',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Bio';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),

                // Save button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: _saveForm,
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
