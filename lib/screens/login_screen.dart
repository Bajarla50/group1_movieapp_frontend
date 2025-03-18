import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movieapp/screens/signup_screen.dart';
import 'home_screen.dart';
import 'package:movieapp/screens/forgotpassword_screen.dart';
import 'profile_screen.dart';

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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}");
    return emailRegex.hasMatch(email);
  }

  void _validateAndLogin() {
    setState(() {
      _emailError =
          _emailController.text.isEmpty || !_isValidEmail(_emailController.text)
              ? "Enter a valid email"
              : null;
      _passwordError =
          _passwordController.text.isEmpty ? "Password cannot be empty" : null;
    });

    if (_emailError == null && _passwordError == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  // First row of movie posters
  final List<String> _imagesFirstRow = [
    'assets/June.jpg',
    'assets/Avengers Endgame.jpg',
    'assets/Batman.jpg',
    'assets/Arcane.jpg',
    'assets/Loki.png',
  ];

  // Second row of movie posters
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

    // scrolling animation
    _startScrolling(_scrollController1, 110); // Top row
    _startScrolling(_scrollController2, 140); // Bottom row
  }

  // Function to animate movie posters scrolling
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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double posterSizeMultiplier = 1.25; // Poster scaling factor

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF04040A), // Background gradient
              Color(0xFF04040A),
              Color(0xFF202956),
              Color(0xFF202956),
            ],
            stops: [0.0, 0.18, 0.18, 1.0], // Gradient stops
          ),
        ),
        child: Stack(
          children: [
            // Animation
            Positioned(
              top: -50,
              left: -50,
              right: -50,
              height: 300,
              child: Transform.rotate(
                angle: -9 * (3.141592653589793 / 180),
                child: Column(
                  children: [
                    // First row
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
                              width: 80 * posterSizeMultiplier,
                              height: 100 * posterSizeMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage(_imagesFirstRow[imageIndex]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    // Second row
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
                              width: 80 * posterSizeMultiplier,
                              height: 100 * posterSizeMultiplier,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image:
                                      AssetImage(_imagesSecondRow[imageIndex]),
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
            ),

            // Main Login Section
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),

                      // Login Title
                      Text(
                        "Log in to Your Account",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.prata(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Email/Username Input Field
                      _buildInputField("Email/Username"),
                      const SizedBox(height: 15),

                      // Password Input Field
                      _buildInputField("Password", obscureText: true),
                      const SizedBox(height: 20),

                      // Continue/Login Button
                      _buildLoginButton(context),
                      const SizedBox(height: 20),

                      // Signup Section
                      _buildSignupSection(context),
                      const SizedBox(height: 10),

                      // Forgot Password
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

// widgets
// Input Field
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

// Continue/Login Button
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

// Signup Section
Widget _buildSignupSection(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("Don't have an account? ",
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white)),
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
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ),
    ],
  );
}

// Forgot Password
Widget _buildForgotPassword(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => OtpVerificationScreen()));
    },
    child: Text("Forgot Password?",
        style: GoogleFonts.poppins(
            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green)),
  );
}
