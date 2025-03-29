import 'package:flutter/material.dart';
import 'package:movieapp/screens/Login/verificationcode_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2.5), // Start off-screen
      end: const Offset(0, 0), // Slide up to its position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  void _validateAndProceed() {
    String email = _emailController.text.trim();

    if (email.isEmpty || !_isValidEmail(email)) {
      _showAnimatedError();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VerificationCodeScreen()),
      );
    }
  }

  void _showAnimatedError() {
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      _animationController.reverse();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF202956), // Background color
            ),
          ),

          // OTP Verification Image
          Positioned(
            top: 60,
            left: (MediaQuery.of(context).size.width - 240) / 2,
            child: Image.asset(
              'assets/Verification boy.png', // Image
              width: 240,
            ),
          ),

          // OTP Verification Title
          Positioned(
            top: 370,
            left: 50,
            child: Text(
              'OTP Verification',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // Subtitle
          Positioned(
            top: 410,
            left: 50,
            child: Text(
              'Enter email and phone number for\none-time password',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ),

          // Email Text
          Positioned(
            top: 480,
            left: 53,
            child: Text(
              'Email',
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),

          // Email Input Field
          Positioned(
            top: 510,
            left: 50,
            right: 50,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _emailController,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 14,
                  ),
                  border: InputBorder.none,
                  hintText: 'Enter your email',
                ),
              ),
            ),
          ),

          // Continue Button
          Positioned(
            top: 575,
            left: (MediaQuery.of(context).size.width - 214) / 2,
            child: SizedBox(
              width: 214,
              height: 45,
              child: ElevatedButton(
                onPressed: _validateAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5F56D1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Animated Error Box
          Positioned(
            bottom: 20,
            left: 50,
            right: 50,
            child: SlideTransition(
              position: _slideAnimation,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Enter a valid email address',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
