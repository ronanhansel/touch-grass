import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup.dart';
import 'package:gdsc_solution/navigation.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  int _success = 1;
  String _userEmail = "";
  // Add a loading state to your class
  bool _isLoading = false;

  void _signIn() async {
  setState(() => _isLoading = true);
  try {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text
    )).user;

    if (!mounted) return;

    if (user != null) {
      setState(() {
        _success = 2;
        _userEmail = user.email ?? 'No email available';
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Navigation()),
      );
    } else {
      setState(() => _success = 3);
    }
  } catch (e) {
    setState(() => _success = 3);
    final snackBar = SnackBar(content: Text('Sign in failed: $e'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  setState(() => _isLoading = false);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(15, 110, 0, 0),
                child: const Text("Hello",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
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
              Container(
                alignment: const Alignment(1, 0),
                padding: const EdgeInsets.only(top: 15, left: 20),
                child: const InkWell(
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    _success == 1
                        ? ''
                        : (_success == 2
                            ? 'Successfully signed in $_userEmail'
                            : 'Sign in failed'),
                    style: const TextStyle(color: Colors.red),
                  )),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  child: _isLoading 
                      ? const CircularProgressIndicator()
                      : const Text('Sign in'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return const SignupPage();
                      }));
                    },
                    child: const Text('Register',
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
