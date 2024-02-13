import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gdsc_solution/community/community.dart';
import 'package:gdsc_solution/home.dart';
import 'package:gdsc_solution/profile/profile_screen.dart';
import 'package:gdsc_solution/splash_screen.dart';
import 'package:gdsc_solution/tasks.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final _homeKey = UniqueKey();
  void changeIndex(index) {
    setState(() {
      _selectedIndex = index;
    });
    debugPrint('Changed index $index');
  }

  int _selectedIndex = 0;
  bool show = true;
  late List<Widget> _widgetOptions;
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Home(changeIndex, key: _homeKey,), // Pass the function directly
      const Community(),
      const ProfileScreen(),
      const Tasks(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 4310), () {
      setState(() {
        show = false;
      });
    });
    return Stack(
      children: [
        Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    hoverColor: Theme.of(context).colorScheme.onPrimary,
                    gap: 8,
                    activeColor: Colors.black,
                    iconSize: 24,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: Theme.of(context).colorScheme.primary,
                    color: Theme.of(context).colorScheme.onSecondary,
                    tabs: const [
                      GButton(
                        icon: LineIcons.home,
                        iconSize: 30.0,
                        text: 'Home',
                      ),
                      GButton(
                        icon: LineIcons.globe,
                        iconSize: 30.0,
                        text: 'Community',
                      ),
                      GButton(
                        icon: LineIcons.userCircle,
                        iconSize: 30.0,
                        text: 'Profile',
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                    onTabChange: (index) => changeIndex(index),
                  ),
                ),
              )),
        ),
        show
            ? const SplashScreen()
                .animate()
                .fadeOut(delay: 3900.ms, duration: 300.ms, curve: Curves.easeIn)
            : Container()
      ],
    );
  }
}
