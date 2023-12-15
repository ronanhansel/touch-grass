import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gdsc_solution/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .background, //Theme.of(context).colorScheme.background,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: const Center(
            child: Padding(
          padding: EdgeInsetsDirectional.all(30.0),
          child: Text(
            'Breathe deep! Your air contains "laugh gas" released by laughter. So go ahead, giggle and spread some air joy!',
            style: TextStyle(
                fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        )),
      ),
    );
  }
}
