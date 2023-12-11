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
          primary: Color.fromARGB(255, 181, 232, 131),
          onPrimary: Color.fromARGB(190, 199, 238, 179),
          secondary: Color.fromRGBO(241, 243, 230, 1),
          onSecondary: Color.fromRGBO(153, 153, 153, 1),
          error: Color(0xFFE2A11F),
          onError: Color.fromRGBO(226, 36, 112, 1),
          background: Color.fromRGBO(248, 250, 237, 1),
          onBackground: Color.fromRGBO(234, 239, 209, 1),
          surface: Color.fromRGBO(238, 240, 227, 1),
          onSurface: Color.fromRGBO(238, 240, 227, 1),
        )),
        debugShowCheckedModeBanner: false,
        home: const Navigation());
  }
}
