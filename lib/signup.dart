import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdsc_solution/navigation.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late bool _sucess;
  late String _userEmail;

  // Add the Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _register() async {
  final User? user = (
    await _auth.createUserWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text
    )
  ).user;

  if (!mounted) return; // Check if the widget is still in the widget tree

  if (user != null) {
    setState(() {
      _sucess = true;
      _userEmail = user.email!;
    });

    // Call the method to create a Firestore document for the user
    _createUserDocument(user);

    // Navigate to the Navigation screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Navigation()),
    );

  } else {
    setState(() {
      _sucess = false;
    });
  }
}



  // Method to create a Firestore document for a new user
  Future<void> _createUserDocument(User user) async {
  DocumentReference userDocRef = _firestore.collection('users').doc(user.uid);

  await userDocRef.set({
    'name': '', // Update with actual data or keep as empty string
    'photo': '', // Update with actual data or keep as empty string
    'age': 0, // Update with actual data
    'gender': '', // Update with actual data
    // Add other fields as necessary
  });
  print("created user");

  // Placeholder data for sub-collections
  Map<String, dynamic> placeholderData = {'placeholderField': 'placeholderValue'};

  // Creating placeholder documents in each sub-collection
  await userDocRef.collection('dismissed tasks').doc('placeholder').set(placeholderData);
  await userDocRef.collection('saved tasks').doc('placeholder').set(placeholderData);
  await userDocRef.collection('today tasks').doc('placeholder').set(placeholderData);

  print("User document and sub-collections created in Firestore");
}


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                  child: const Text("SignUp",
                      style: TextStyle(
                          fontSize: 40, fontWeight: FontWeight.bold,
                          color: Colors.black
                      )
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 35, left: 20, right: 30),
            child: Column(
              children: <Widget>[
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _emailController,
                  decoration: const InputDecoration(
                      labelText: 'EMAIL',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )
                  ),
                ),
                const SizedBox(height: 20,),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      labelText: 'PASSWORD',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.grey
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                      )
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 5.0,),
                const SizedBox(height: 40,),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                  child: const Text('Sign up'),
             ),
                ),
                const SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                          'Go Back',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline
                          )
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }
}