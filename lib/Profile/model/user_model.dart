import 'package:flutter/material.dart';

class UserModel {
  String? userName;
  String? userId;
  String? city;
  String? bio;
  String? userImage;

  // Constructor with named parameters
  UserModel({
    this.userName,
    this.userId,
    this.city,
    this.bio,
    this.userImage,
  });

  // Factory method to create a UserModel object from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'] as String?,
      userId: json['userId'] as String?,
      city: json['city'] as String?,
      bio: json['bio'] as String?,
      userImage: json['userImage'] as String?,
    );
  }

  // Method to convert UserModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'userId': userId,
      'city': city,
      'bio': bio,
      'userImage': userImage,
    };
  }
}
