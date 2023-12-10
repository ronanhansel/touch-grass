import 'package:flutter/material.dart';
import 'package:gdsc_solution/navigation.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color.fromRGBO(238, 240, 227, 1),
          onPrimary: Color.fromRGBO(238, 240, 227, 1),
          secondary: Color.fromRGBO(241, 243, 230, 1),
          onSecondary: Color.fromRGBO(153, 153, 153, 1),
          error: Color.fromRGBO(238, 240, 227, 1),
          onError: Color.fromRGBO(238, 240, 227, 1),
          background: Color.fromRGBO(250, 251, 239, 1),
          onBackground: Color.fromRGBO(234, 239, 209, 1),
          surface: Color.fromRGBO(238, 240, 227, 1),
          onSurface: Color.fromRGBO(238, 240, 227, 1),
        )),
        debugShowCheckedModeBanner: false,
        home: const Navigation());
  }
}
