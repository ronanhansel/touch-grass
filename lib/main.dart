import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gdsc_solution/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gdsc_solution/navigation.dart';
import 'package:gdsc_solution/signup.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'touch-grass',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initFirebaseSdk = Firebase.initializeApp();
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(181, 232, 131, 1),
          onPrimary: Color.fromRGBO(199, 238, 179, 0.745),
          secondary: Color.fromRGBO(241, 243, 230, 1),
          onSecondary: Color.fromRGBO(153, 153, 153, 1),
          error: Color(0xFFE2A11F),
          onError: Color.fromRGBO(226, 36, 112, 1),
          background: Color.fromRGBO(255, 252, 243, 1),
          onBackground: Color.fromRGBO(234, 239, 209, 1),
          surface: Color.fromRGBO(238, 240, 227, 1),
          onSurface: Color.fromRGBO(238, 240, 227, 1),
        )),
        debugShowCheckedModeBanner: false,

        // home: const SignupPage()
        home: const Navigation()
        //   routes: <String, WidgetBuilder>{
        //   '/signup': (BuildContext context) => const SignupPage()
        // },
        );
  }

  
}
