import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';


class UploadImg {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadUserProfileImage(String userId, XFile image) async {
    // Create a reference to Firebase Storage
    Reference ref = storage.ref().child("userImages/$userId.jpg");

    // Upload the file
    UploadTask uploadTask = ref.putFile(File(image.path));
    await uploadTask.whenComplete(() => null);

    // Get the URL of the uploaded image
    String imageUrl = await ref.getDownloadURL();

    // Store the URL in Firestore
    await firestore.collection("users").doc(userId).update({"photo": imageUrl});
  }
}

void showEnlargedPhoto(BuildContext context, String? imageUrl) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: imageUrl != null && imageUrl.isNotEmpty
          ? Image.network(imageUrl, fit: BoxFit.cover)
          : Image.asset('assets/app/icon.png'), // Default image
    ),
  );
}

// TODO: Implement get_user_info
class UserInfoFetcher {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchUserInfo(String userId) async {
    try {
      DocumentSnapshot userDoc = await firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error fetching user info: $e');
      // Consider handling the error more gracefully,like through user notifications
      return null;
    }
  }
}

//Upload task after swipe right
class TaskUploader {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> uploadSavedTask({
    required String name, 
    required String detail, 
    required String photo, 
    required String type, 
    required int xp,
    required expiration
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    String userId = currentUser.uid;
    Map<String, dynamic> taskData = {
      'name': name,
      'detail': detail,
      'photo': photo,
      'type': type,
      'xp': xp,
      'expiration': expiration
    };

    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('saved tasks')
          .add(taskData);
      // Additional logic after successful upload can be added here
    } catch (e) {
      print('Error uploading task: $e');
      // Consider handling the error more gracefully
    }
  }

  Future<void> uploadDismissedTask({
    required String name, 
    required String detail, 
    required String photo, 
    required String type, 
    required int xp,
    required expiration
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('No user logged in');
    }

    String userId = currentUser.uid;
    Map<String, dynamic> taskData = {
      'name': name,
      'detail': detail,
      'photo': photo,
      'type': type,
      'xp': xp,
      'expiration': expiration
    };

    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('dismissed tasks')
          .add(taskData);
      // Additional logic after successful upload can be added here
    } catch (e) {
      print('Error uploading task: $e');
      // Consider handling the error more gracefully
    }
  }
}

