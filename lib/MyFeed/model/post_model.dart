import 'package:flutter/material.dart';

class PostModel {
  String? postId;    // New field: postId
  String? userName;
  String? userId;
  String? imageUrl;

  // Constructor with named parameters, including postId
  PostModel({
    this.postId,
    this.userName,
    this.userId,
    this.imageUrl,
  });

  // Factory method to create a PostModel object from a JSON map
  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      postId: json['postId'] as String?,       // Added postId
      userName: json['userName'] as String?,
      userId: json['userId'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  // Method to convert PostModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'postId': postId,       // Added postId
      'userName': userName,
      'userId': userId,
      'imageUrl': imageUrl,
    };
  }
}
