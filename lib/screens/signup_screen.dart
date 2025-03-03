import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'otp_verification_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  void _continueToOTP() {
    String fullName = _fullNameController.text.trim();
    String birthday = _birthdayController.text.trim();
    String email = _emailController.text.trim();

    if (fullName.isEmpty || birthday.isEmpty || email.isEmpty) {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // OTP Verification Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(email: email),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.74,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Let's Get Started",
            style: GoogleFonts.leagueSpartan(
              fontSize: 37,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "Create An Account Today And Step Into A World Of Endless Movies, Unforgettable Stories, And Cinematic Magic!",
            textAlign: TextAlign.center,
            style: GoogleFonts.leagueSpartan(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 25),
          _buildLabeledInputField("Full Name", _fullNameController),
          const SizedBox(height: 20),
          _buildLabeledInputField(
            "Birthday",
            _birthdayController,
            isDatePicker: true,
            onTap: () => _selectDate(context),
          ),
          const SizedBox(height: 20),
          _buildLabeledInputField("Email", _emailController),
          const SizedBox(height: 40),
          SizedBox(
            width: 215,
            height: 48,
            child: ElevatedButton(
              onPressed: _continueToOTP,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5F56D1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildLabeledInputField(
    String label,
    TextEditingController controller, {
    bool isDatePicker = false,
    VoidCallback? onTap,
  }) {
    return SizedBox(
      width: 380,
      height: 58,
      child: TextFormField(
        controller: controller,
        readOnly: isDatePicker,
        onTap: isDatePicker ? onTap : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.leagueSpartan(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        ),
      ),
    );
  }
}
