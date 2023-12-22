import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _buttonController;
  late bool _sucess;
  late String _userEmail;

  @override
  void initState() {
    _buttonController =
        AnimationController(vsync: this, duration: 100.milliseconds);
    super.initState();
  }

  void _register() async {
    debugPrint('Button pressed');
    final User? user = (await _auth.createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text))
        .user;

    if (user != null) {
      setState(() {
        _sucess = true;
        _userEmail = user.email!;
        debugPrint('Welcome $user');
      });
    } else {
      setState(() {
        _sucess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool clicked = false;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ))
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
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: _passwordController,
                decoration: const InputDecoration(
                    labelText: 'PASSWORD',
                    labelStyle: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    )),
                obscureText: true,
              ),
              const SizedBox(
                height: 5.0,
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  shadowColor: Colors.greenAccent,
                  color: Colors.black,
                  elevation: 7,
                  child: GestureDetector(
                      onTap: () async {
                        _buttonController.forward();
                        _register();
                      },
                      child: const Center(
                          child: Text('SIGNUP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')))),
                ),
              ).animate(controller: _buttonController, autoPlay: false).scale(
                  begin: Offset(1, 1),
                  end: Offset(0.95, 0.95),
                  duration: 100.milliseconds),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Go Back',
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline)),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
