import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../HomePage/home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndLogin() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WelcomeAnimationScreen(username: _emailController.text),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: "Email/Username"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _validateAndLogin,
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeAnimationScreen extends StatefulWidget {
  final String username;
  WelcomeAnimationScreen({required this.username});

  @override
  _WelcomeAnimationScreenState createState() => _WelcomeAnimationScreenState();
}

class _WelcomeAnimationScreenState extends State<WelcomeAnimationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _circleAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _circleAnimation,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 20),
            FadeInText(text: "Welcome", delay: 1),
            FadeInText(text: widget.username, delay: 2),
          ],
        ),
      ),
    );
  }
}

class FadeInText extends StatefulWidget {
  final String text;
  final int delay;
  FadeInText({required this.text, required this.delay});

  @override
  _FadeInTextState createState() => _FadeInTextState();
}

class _FadeInTextState extends State<FadeInText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    Future.delayed(Duration(seconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Text(
        widget.text,
        style: GoogleFonts.prata(fontSize: 32, color: Colors.white),
      ),
    );
  }
}
