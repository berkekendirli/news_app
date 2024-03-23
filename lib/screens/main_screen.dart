import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/methods/gradient_design.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/screens/news_page.dart';
import 'package:news_app/screens/profile_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  DateTime timeBackPressed = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;

    List<Widget> pages = const [
      NewsPage(),
      ProfilePage(),
    ];

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        final isExitWarning = difference >= const Duration(seconds: 2);

        if (isExitWarning) {
          Fluttertoast.showToast(msg: 'Press back again to exit', fontSize: 18);
          timeBackPressed = DateTime.now();
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: gradientBackground(),
            child: pages[_selectedIndex], // Show the selected page
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 55),
            child: GNav(
              color: Colors.white,
              tabBackgroundColor: const Color.fromARGB(21, 163, 60, 60),
              activeColor: const Color.fromARGB(255, 163, 60, 60),
              iconSize: 30,
              backgroundColor: Colors.black,
              gap: 8,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: _onItemTapped, // Call _onItemTapped when a tab is changed
            ),
          ),
        ),
      ),
    );
  }
}
