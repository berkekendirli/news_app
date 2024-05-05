import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
    } on FirebaseAuthException catch (error) {
      // print('Password reset failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your email and we will send you a password reset link!',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: GoogleFonts.overpass(fontSize: 16),
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 82, 82, 82),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(204, 129, 129, 129),
                              Colors.black
                            ],
                            end: Alignment.bottomLeft,
                            begin: Alignment.topRight),
                      ),
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: passwordReset,
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          backgroundColor: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            'Reset Password',
                            style: GoogleFonts.overpass(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
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
        ),
      ),
    );
  }
}
