import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/newsread.png', width: 300),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Welcome to the home of news!',
            style: GoogleFonts.lobster(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: const Color.fromARGB(255, 44, 44, 44),
                foregroundColor: Colors.white),
            child: Text(
              'Sign Up',
              style: GoogleFonts.overpass(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              backgroundColor: Colors.white,
              foregroundColor: const Color.fromARGB(255, 44, 44, 44),
            ),
            child: Text(
              'Sign In',
              style: GoogleFonts.overpass(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
