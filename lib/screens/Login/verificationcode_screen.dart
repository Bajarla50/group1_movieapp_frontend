import 'package:flutter/material.dart';
import 'success_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(4, (index) => TextEditingController());
  final String _correctCode = "1234";

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  bool _isErrorVisible = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
  }

  void _submitCode() {
    String code = _controllers.map((controller) => controller.text).join();

    if (code.length == 4 && code == _correctCode) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessScreen()),
      );
    } else {
      _showError();
    }
  }

  void _showError() {
    setState(() => _isErrorVisible = true);
    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      _animationController.reverse().then((_) {
        setState(() => _isErrorVisible = false);
      });
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
            decoration: const BoxDecoration(color: Color(0xFF202956)),
          ),

          // Main Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 300),
                const Text(
                  'Verification Code',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We have sent a verification code to your email address',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // OTP Input
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 50,
                      height: 52,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.orange, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        maxLength: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // Continue Button
                SizedBox(
                  width: 214,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _submitCode,
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
              ],
            ),
          ),

          // Error
          if (_isErrorVisible)
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
                    'Invalid verification code',
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
