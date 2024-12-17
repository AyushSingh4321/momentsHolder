import 'package:assignment2/Profile/screens/editProfile.dart';
import 'package:assignment2/Profile/widget/image.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
          Photo(),
          SizedBox(height: 32,),
          tex('Name:Ayush'),
          tex('City: Kanpur'),
          tex('Bio: Chin tapak dam dam'),
        ],
      ),
    );
  }
}
