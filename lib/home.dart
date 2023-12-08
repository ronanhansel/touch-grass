import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.amber[600]!,
              ),
              color: Color.fromRGBO(255, 248, 242, 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber[600]!.withOpacity(.25),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20))),
          height: height * 0.55,
          width: width * 0.95,
          child: Text(''),
        ),
      ),
    );
  }
}
