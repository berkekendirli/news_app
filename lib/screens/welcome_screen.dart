import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/login_screen.dart';
import 'package:news_app/screens/register_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 151, 182, 243),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/newsread.png', width: 300),
                const SizedBox(height: 20),
                Text(
                  'Welcome to the home of news!',
                  style: GoogleFonts.lobster(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 44, 44, 44),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: const Color.fromARGB(255, 44, 44, 44),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    backgroundColor: const Color.fromARGB(255, 163, 60, 60),
                  ),
                  child: SizedBox(
                    width: 150,
                    height: 50,
                    child: Center(
                      child: Text(
                        'Skip',
                        style: GoogleFonts.overpass(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
