import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for date formatting

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _birthdayController = TextEditingController();

  // Function to show Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000), // Default date
      firstDate: DateTime(1900), // Earliest selectable date
      lastDate: DateTime.now(), // Cannot pick future dates
    );

    if (pickedDate != null) {
      setState(() {
        _birthdayController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
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
            Text(
              "Let's Get Started",
              style: GoogleFonts.leagueSpartan(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Create an account today and step into a world of endless movies, unforgettable stories, and cinematic magic!",
              textAlign: TextAlign.center,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 20),
            _buildInputField("Username"),
            SizedBox(height: 12),
            _buildInputField("Email"),
            SizedBox(height: 12),
            _buildBirthdayField(context), // Birthday field with Date Picker
            SizedBox(height: 12),
            _buildInputField("Password", obscureText: true),
            SizedBox(height: 12),
            _buildInputField("Confirm Password", obscureText: true),
            SizedBox(height: 20),
            _buildSignupButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, {bool obscureText = false}) {
    return Container(
      width: 380,
      child: TextFormField(
        obscureText: obscureText,
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

  Widget _buildBirthdayField(BuildContext context) {
    return Container(
      width: 380,
      child: TextFormField(
        controller: _birthdayController,
        readOnly: true, // Prevent manual input
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
        onTap: () => _selectDate(context), // Show calendar on tap
      ),
    );
  }

  Widget _buildSignupButton(BuildContext context) {
    return SizedBox(
      width: 214,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context); // Close the sign-up form
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
