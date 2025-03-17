import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Error message
  String? _passwordError;

  // Calendar
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }

  // Error
  void _validatePasswords() {
    setState(() {
      if (_passwordController.text != _confirmPasswordController.text) {
        _passwordError = "Passwords do not match";
      } else {
        _passwordError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Signup title
            Text(
              "Let's Get Started",
              style: GoogleFonts.leagueSpartan(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            // Signup subtitle
            Text(
              "Create an account today and step into a world of endless movies, unforgettable stories, and cinematic magic!",
              textAlign: TextAlign.center,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            // Username input
            _buildInputField("Username"),
            SizedBox(height: 12),
            // Email input
            _buildInputField("Email"),
            SizedBox(height: 12),
            // Birthday
            _buildBirthdayField(context),
            SizedBox(height: 12),
            // Password
            _buildPasswordField("Password", _passwordController,
                obscureText: _obscurePassword, toggle: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            }),
            SizedBox(height: 12),
            // Confirm Password
            _buildPasswordField(
              "Confirm Password",
              _confirmPasswordController,
              obscureText: _obscureConfirmPassword,
              toggle: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              errorText: _passwordError,
            ),
            SizedBox(height: 20),
            // Signup button
            _buildSignupButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label) {
    return Container(
      width: 380,
      child: TextFormField(
        style: GoogleFonts.leagueSpartan(fontSize: 18),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.leagueSpartan(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
      ),
    );
  }

  // Password input
  Widget _buildPasswordField(String label, TextEditingController controller,
      {required bool obscureText,
      required VoidCallback toggle,
      String? errorText}) {
    return Container(
      width: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            onChanged: (_) => _validatePasswords(),
            style: GoogleFonts.leagueSpartan(fontSize: 18),
            decoration: InputDecoration(
              labelText: label,
              labelStyle: GoogleFonts.leagueSpartan(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: toggle,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: errorText == null ? Colors.black38 : Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: errorText == null ? Colors.black : Colors.red,
                    width: 1.5),
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  // Birthday input
  Widget _buildBirthdayField(BuildContext context) {
    return Container(
      width: 380,
      child: TextFormField(
        controller: _birthdayController,
        readOnly: true,
        style: GoogleFonts.leagueSpartan(fontSize: 18),
        decoration: InputDecoration(
          labelText: "Birthday",
          labelStyle: GoogleFonts.leagueSpartan(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          suffixIcon: Icon(Icons.calendar_today, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black38),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.black, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        ),
        onTap: () => _selectDate(context),
      ),
    );
  }

  // Signup button
  Widget _buildSignupButton(BuildContext context) {
    return SizedBox(
      width: 214,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          _validatePasswords();
          if (_passwordError == null) {
            Navigator.pop(context); // Close the sign-up form if passwords match
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF5F56D1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          "Continue",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
