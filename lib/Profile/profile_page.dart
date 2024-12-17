import 'package:assignment2/Authentication/auth_service.dart';
import 'package:assignment2/Profile/model/user_model.dart';
import 'package:assignment2/Profile/screens/editProfile.dart';
import 'package:assignment2/Profile/widget/image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String? name, city, bio, url;

class ProfilePage extends StatefulWidget {
  // ProfilePage({this.name, this.city, this.bio});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    _fetchUserData(); // Fetch the user data on initialization
  }

  // Function to fetch user data from Firestore
  Future<void> _fetchUserData() async {
    String userId = AuthService().getCurrentUser()!.uid;

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .get();

      if (snapshot.exists) {
        // If user data exists, populate the form fields
        var data = snapshot.data() as Map<String, dynamic>;

        setState(() {
          var userData = UserModel.fromJson(data);
          name = userData.userName;
          city = userData.city;
          bio = userData.bio;
          url = userData.userImage;
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget tex(String s) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: double.infinity,
        child: Text(
          s,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushNamed(Editprofile.routeName);
        },
        child: Text('Edit Profile'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Photo(url==null?"fd":url!),
          SizedBox(
            height: 32,
          ),
          if (name == null) tex('Name:'),
          if (name != null) tex('Name: ${name}'),
          if (city == null) tex('City:'),
          if (city != null) tex('City: ${city}'),
          if (bio == null) tex('Bio:'),
          if (bio != null) tex('Bio: ${bio}'),
        ],
      ),
    );
  }
}
