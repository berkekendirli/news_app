import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/welcome_screen.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime timeBackPressed = DateTime.now();

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 255, 58, 68),
          ),
        );
      },
    );

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    await FirebaseAuth.instance.signOut();
    Navigator.pop(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
                      backgroundColor: const Color.fromARGB(
                        255,
                        163,
                        60,
                        60,
                      ),
                      foregroundColor: Colors.white),
                  onPressed: signUserOut,
                  child: const Text('Signout'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "LOGGED IN AS: ${user.email!}",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
