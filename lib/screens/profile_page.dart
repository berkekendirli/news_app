import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/screens/welcome_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime timeBackPressed = DateTime.now();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: const Color.fromARGB(255, 163, 60, 60,),
                      foregroundColor: Colors.white),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WelcomePage(),
                      ),
                    );
                  },
                  child: const Text('Signout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
