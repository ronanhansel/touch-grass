import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

// TODO: Implement get_user_info