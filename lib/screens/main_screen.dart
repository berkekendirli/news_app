import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/screens/bookmarks_page.dart';
import 'package:news_app/screens/currency_page.dart';
import 'package:news_app/screens/home_news.dart';
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

    List<Widget> pages = [
      const HomePage(),
      const CurrencyPage(),
      const BookmarksPage(),
      const ProfilePage(),
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
            color: Colors.white,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: pages[_selectedIndex],
            ), // Show the selected page
          ),
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: GNav(
              color: const Color.fromARGB(255, 82, 82, 82),
              activeColor: const Color.fromARGB(255, 255, 58, 68),
              iconSize: 20,
              backgroundColor: Colors.white,
              tabActiveBorder: Border.all(
                color: const Color.fromARGB(255, 255, 128, 134),
              ),
              gap: 8,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  backgroundColor: Colors.white,
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  backgroundColor: Colors.white,
                  icon: Icons.attach_money,
                  text: 'Currency',
                ),
                GButton(
                  backgroundColor: Colors.white,
                  icon: Icons.bookmark,
                  text: 'Bookmarks',
                  textSize: 15,
                ),
                GButton(
                  backgroundColor: Colors.white,
                  icon: Icons.account_circle,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange:
                  _onItemTapped, // Call _onItemTapped when a tab is changed
            ),
          ),
        ),
      ),
    );
  }
}
