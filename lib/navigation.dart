import 'package:flutter/material.dart';
import 'package:gdsc_solution/community.dart';
import 'package:gdsc_solution/home.dart';
import 'package:gdsc_solution/profile.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _HomePageState();
}

class _HomePageState extends State<Navigation> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Community(),
    Profile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: const Color.fromRGBO(133, 166, 116, 100),
                hoverColor: const Color.fromRGBO(133, 166, 116, 65),
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: const Color.fromRGBO(196, 255, 164, 100)!,
                color: Theme.of(context).colorScheme.onSecondary,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    iconSize: 30.0,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.users,
                    iconSize: 30.0,
                    text: 'Community',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    iconSize: 30.0,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          )),
    );
  }
}
