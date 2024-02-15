import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_solution/functions/auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdsc_solution/functions/functions.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    if (currentUser != null) {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data();
        });
      }
    }
  }

  Future<void> _uploadNewPicture() async {
  try {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      UploadImg uploadImg = UploadImg();
      await uploadImg.uploadUserProfileImage(currentUser!.uid, image);

      // Update the userData with new photo URL after successful upload
      _loadUserData();
    }
  } catch (e) {
    print('An error occurred: $e');  // This will print the error details to the console.
  }
}


  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;

    if (userData != null && userData!['photo'] != null && (userData!['photo'] as String).isNotEmpty) {
      imageProvider = NetworkImage(userData!['photo']);
    } else {
      imageProvider = const AssetImage('assets/app/icon.png');
    }

    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: imageProvider,
            backgroundColor: Colors.transparent,
            child: InkWell(
              onTap: () {
                showEnlargedPhoto(context, userData?['photo']);
              },
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(color: Colors.white),
                  ),
                  backgroundColor: const Color(0xFFF5F6F9),
                ),
                onPressed: _uploadNewPicture,
                child: SvgPicture.asset("assets/icon/CameraIcon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
