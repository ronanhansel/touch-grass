import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_solution/functions/auth.dart';
import 'package:gdsc_solution/profile/components/profile_menu.dart';
import 'package:gdsc_solution/profile/components/profile_pic.dart';
import 'package:gdsc_solution/screens/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
  if (currentUser != null) {
    try {
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc.data();
        });
      }
    } catch (e) {
      // Handle errors here, e.g., show a message to the user
      print('Error loading user data: $e');
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(color: Colors.black), // Set the text color to black
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            Text(
              '${userData?['name']}',
              style: const TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "My Account",
              icon: "assets/icon/CameraIcon.svg",
              press: () => {},
            ),
            ProfileMenu(
              text: "Notifications",
              icon: "assets/icon/CameraIcon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Settings",
              icon: "assets/icon/CameraIcon.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: "assets/icon/CameraIcon.svg",
              press: () {},
            ),
            ProfileMenu(
            text: "Log Out",
            icon: "assets/icon/CameraIcon.svg",
            press: () async {
                try {
                    await Auth().signOut();
                    // Navigate to login or another appropriate screen
                } catch (error) {
                    // Handle any errors here
                    print('Logout error: $error');
                }
            },
),

            
          ],
        ),
      ),
    );
  }
}





