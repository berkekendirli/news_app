import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Notifica',
              style: GoogleFonts.ptSerif(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              width: 1,
            ),
            Text(
              'tions',
              style: GoogleFonts.ptSerif(
                  color: const Color.fromARGB(255, 255, 58, 68),
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: const SafeArea(child: Placeholder()),
    );
  }
}
