import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/forgotpw_screen.dart';
import 'package:news_app/screens/main_screen.dart';
import 'package:news_app/screens/register_screen.dart';
import 'package:news_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String _email = "";
  String _password = "";
  String _errorMessage = "";

  void handleLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }

    setState(() {
      _errorMessage = "";
    });

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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const NewsScreen(),
          ),
          (route) => false);
    } catch (e) {
      Navigator.pop(context); // Dismiss the loading indicator
      setState(() {
        _errorMessage = 'Wrong email or password';
      });
    }
    emailController.clear();
    passwordController.clear();
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            message,
            style: GoogleFonts.nunito(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: GoogleFonts.nunito(
                    color: const Color.fromARGB(255, 0, 128, 255),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
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
                        'Sign In',
                        style: GoogleFonts.ptSerif(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: emailController,
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
                        controller: passwordController,
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
                      if (_errorMessage.isNotEmpty || _errorMessage != '')
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            _errorMessage,
                            style: GoogleFonts.nunito(
                              color: const Color.fromARGB(255, 255, 58, 68),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ForgotPassword(),
                                ),
                              );
                            });
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.nunito(
                              color: const Color.fromARGB(255, 0, 128, 255),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
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
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            handleLogin();
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
                              'Sign In',
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
                      GestureDetector(
                        onTap: () => AuthService().signInWithGoogle(context),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 58, 68),
                                  Color.fromARGB(255, 255, 128, 134),
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight),
                          ),
                          height: 50,
                          child: Center(
                            child: Image.asset(
                              'assets/images/Google_.png',
                              height: 35,
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
                          Text(
                            'Don\'t you have an account?',
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
                                    builder: (context) => const RegisterPage(),
                                  ),
                                );
                              });
                            },
                            child: Text(
                              'Sign Up',
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
