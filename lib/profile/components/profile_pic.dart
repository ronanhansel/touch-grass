import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_solution/functions/auth.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  Widget build(BuildContext context) {

    ImageProvider imageProvider;

    if (userData != null && userData!['photo'] != null && (userData!['photo'] as String).isNotEmpty) {
      // If there is a user photo URL and it's not empty, use NetworkImage
      imageProvider = NetworkImage(userData!['photo']);
    } else {
      // If there is no user photo URL or it's empty, use the default AssetImage
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
                onPressed: () {},
                child: SvgPicture.asset("assets/icon/CameraIcon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
