import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    bool? confirmSignOut = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Sign Out',
            style: GoogleFonts.ptSerif(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to sign out?',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Sign Out',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: const Color.fromARGB(255, 255, 58, 68),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmSignOut == true) {
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
      await GoogleSignIn().signOut();

      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    }
  }

  void changePassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Password Reset',
              style: GoogleFonts.ptSerif(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'An email has been sent to ${user.email} to reset your password.',
              style: GoogleFonts.nunito(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.nunito(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 255, 58, 68),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (error) {}
  }

  void deleteUserAccount() async {
    bool? confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Account',
            style: GoogleFonts.ptSerif(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                'Delete',
                style: GoogleFonts.nunito(
                  fontSize:20,
                  color: const Color.fromARGB(255, 255, 58, 68),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
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

      try {
        await Future.delayed(
          const Duration(milliseconds: 500),
        );

        await user.delete();
        await GoogleSignIn().signOut();

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const WelcomePage(),
          ),
        );
      } catch (e) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Error',
                style: GoogleFonts.ptSerif(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Failed to delete account: $e',
                style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.nunito(
                      color: const Color.fromARGB(255, 255, 58, 68),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pro',
              style: GoogleFonts.ptSerif(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'file',
              style: GoogleFonts.ptSerif(
                color: const Color.fromARGB(255, 255, 58, 68),
                fontWeight: FontWeight.w800,
                fontSize: 22,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '(' + user.email.toString() + ')',
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 1, // Set the height of the divider
              color: Colors.black26, // Set the color of the divider
            ),
            GestureDetector(
              onTap: changePassword,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Change password',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 1, // Set the height of the divider
              color: Colors.black26, // Set the color of the divider
            ),
            GestureDetector(
              onTap: signUserOut,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sign Out',
                        style: GoogleFonts.nunito(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 1, // Set the height of the divider
              color: Colors.black26, // Set the color of the divider
            ),
            GestureDetector(
              onTap: deleteUserAccount,
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Delete Account',
                        style: GoogleFonts.nunito(
                            color: const Color.fromARGB(255, 255, 58, 68),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 1, // Set the height of the divider
              color: Colors.black26, // Set the color of the divider
            ),
          ],
        ),
      ),
    );
  }
}
