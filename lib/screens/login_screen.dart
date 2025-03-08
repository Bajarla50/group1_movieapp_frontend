import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:your_app_name/screens/signup_screen.dart';
import 'home_screen.dart';
import 'package:your_app_name/screens/forgotpassword_screen.dart';

void main() {
  runApp(MovieAppLogin());
}

class MovieAppLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<String> _imagesFirstRow = [
    'assets/June.jpg',
    'assets/Avengers Endgame.jpg',
    'assets/Batman.jpg',
    'assets/Arcane.jpg',
    'assets/Loki.png',
  ];

  final List<String> _imagesSecondRow = [
    'assets/Stranger Things.jpg',
    'assets/Adventure Time.jpg',
    'assets/Gravity Falls.jpeg',
    'assets/Rick and Morty.jpg',
    'assets/Star vs the Forces of Evil.jpg',
  ];

  late ScrollController _scrollController1;
  late ScrollController _scrollController2;

  @override
  void initState() {
    super.initState();
    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _startScrolling(_scrollController1, 120);
    _startScrolling(_scrollController2, 150); // Slightly different speed
  }

  void _startScrolling(ScrollController controller, int durationSeconds) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (controller.hasClients) {
        controller
            .animateTo(
          controller.position.maxScrollExtent,
          duration: Duration(seconds: durationSeconds),
          curve: Curves.linear,
        )
            .then((_) {
          controller.jumpTo(controller.position.minScrollExtent);
          _startScrolling(controller, durationSeconds);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double posterSizeMultiplier = 1.25;

    return Scaffold(
      backgroundColor: const Color(0xE0485297),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF04040A),
              Color(0xE0485297),
            ],
            stops: [0.385, 0.635],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 400,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController1,
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagesFirstRow.length * 2,
                      itemBuilder: (context, index) {
                        final imageIndex = index % _imagesFirstRow.length;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 90 * posterSizeMultiplier,
                            height: 120 * posterSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(_imagesFirstRow[imageIndex]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController2,
                      scrollDirection: Axis.horizontal,
                      itemCount: _imagesSecondRow.length * 2,
                      itemBuilder: (context, index) {
                        final imageIndex = index % _imagesSecondRow.length;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            width: 90 * posterSizeMultiplier,
                            height: 120 * posterSizeMultiplier,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: AssetImage(_imagesSecondRow[imageIndex]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 300),
                      Text(
                        "Log in to Your Account",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.prata(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildInputField("Email/Username"),
                      const SizedBox(height: 10),
                      _buildInputField("Password", obscureText: true),
                      const SizedBox(height: 16),
                      _buildLoginButton(context),
                      const SizedBox(height: 14),
                      Text("Or",
                          style: GoogleFonts.poppins(
                              fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 14),
                      _buildSocialButton("Continue with Google",
                          FontAwesomeIcons.google, Colors.red),
                      const SizedBox(height: 8),
                      _buildSocialButton("Continue with Facebook",
                          FontAwesomeIcons.facebook, Colors.blue),
                      const SizedBox(height: 18),
                      _buildSignupSection(context),
                      const SizedBox(height: 6),
                      _buildForgotPassword(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildInputField(String hint, {bool obscureText = false}) {
  return Container(
    width: 290,
    height: 45,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),
        border: InputBorder.none,
      ),
    ),
  );
}

Widget _buildLoginButton(BuildContext context) {
  return SizedBox(
    width: 214,
    height: 48,
    child: ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF5F56D1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "Continue",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    ),
  );
}

Widget _buildSocialButton(String text, IconData icon, Color color) {
  return SizedBox(
    width: 290,
    height: 45,
    child: ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: FaIcon(icon, color: color),
      label: Text(text,
          style: GoogleFonts.poppins(fontSize: 15, color: Colors.black)),
    ),
  );
}

Widget _buildSignupSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Don't have an account? ",
        style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SignupScreen(),
          );
        },
        child: Text(
          "Sign Up",
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ),
    ],
  );
}

Widget _buildForgotPassword(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OtpVerificationScreen()),
      );
    },
    child: Text(
      "Forgot Password?",
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    ),
  );
}
