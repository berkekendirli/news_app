import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/methods/square_tile.dart';
import 'package:news_app/screens/login_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  void _handleSignUp() async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: _email, password: _password);
      // print('User Registered: ${userCredential.user!.email}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } catch (e) {
      // print('Error During Registration: $e');
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: GoogleFonts.playfairDisplay(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: GoogleFonts.nunito(fontSize: 16),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _email = value;
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: !_isPasswordVisible,
                        controller: _passController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: GoogleFonts.nunito(fontSize: 16),
                          floatingLabelStyle:
                              const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 82, 82, 82),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 82, 82, 82),
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _password = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        obscureText: !_isConfirmPasswordVisible,
                        controller: _confirmPassController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 16,
                          ),
                          floatingLabelStyle:
                              const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 82, 82, 82),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: const Color.fromARGB(255, 82, 82, 82),
                            ),
                            onPressed: () {
                              setState(() {
                                _isConfirmPasswordVisible =
                                    !_isConfirmPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _password) {
                            return 'Passwords doesn\'t match';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 50,
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
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _handleSignUp();
                            }
                          },
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
                              'Sign Up',
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Expanded(
                            child: Divider(
                              color: Color.fromARGB(204, 129, 129, 129),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Or continue with',
                            style: GoogleFonts.nunito(
                              color: const Color.fromARGB(204, 129, 129, 129),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Expanded(
                            child: Divider(
                              color: Color.fromARGB(204, 129, 129, 129),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SquareTile(
                            imagePath: 'assets/images/google.png',
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SquareTile(
                            imagePath: 'assets/images/facebook.png',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account?',
                            style: GoogleFonts.nunito(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Sign In',
                              style: GoogleFonts.nunito(
                                color: const Color.fromARGB(255, 0, 128, 255),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
