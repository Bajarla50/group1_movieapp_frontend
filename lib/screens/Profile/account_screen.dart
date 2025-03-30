import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:movieapp/screens/Login/login_screen.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';
import 'package:movieapp/screens/Profile/delete_account_screen.dart'; // Import DeleteAccountScreen

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController =
      TextEditingController(text: "Celestiang@Gmail.Com");
  final TextEditingController _passwordController =
      TextEditingController(text: "********");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    _usernameController.text = userProvider.username;
    _emailController.text = userProvider.email;
    _passwordController.text = userProvider.password;
  }

  Future<void> _pickImage(BuildContext context, bool isProfile) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      if (isProfile) {
        Provider.of<UserProvider>(context, listen: false)
            .updateProfileImage(File(pickedFile.path));
      } else {
        Provider.of<UserProvider>(context, listen: false)
            .updateCoverImage(File(pickedFile.path));
      }
    }
  }

// calendar
  Future<void> _selectBirthdate(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2005, 10, 21),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      userProvider.updateBirthdate(DateFormat("MM/dd/yyyy").format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF05091D), Color(0xFF05091D)],
              ),
            ),
          ),
          Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Account",
                textAlign: TextAlign.center,
                style: GoogleFonts.leagueSpartan(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => _pickImage(context, false),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFF4F4C92),
                  image: userProvider.coverImage != null
                      ? DecorationImage(
                          image: FileImage(userProvider.coverImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
          ),
          Positioned(
            top: 160,
            right: 20,
            left: 20,
            child: GestureDetector(
              onTap: () => _pickImage(context, true),
              child: CircleAvatar(
                radius: 70,
                backgroundImage: userProvider.profileImage != null
                    ? FileImage(userProvider.profileImage!)
                    : AssetImage("assets/profile.png") as ImageProvider,
                backgroundColor: Colors.white24,
              ),
            ),
          ),
          Positioned(
            top: 300,
            left: 20,
            right: 20,
            child: _buildTextField("Username", _usernameController,
                (value) => userProvider.updateUsername(value)),
          ),
          Positioned(
            top: 400,
            left: 20,
            right: 20,
            child: _buildTextField("Email", _emailController,
                (value) => userProvider.updateEmail(value)),
          ),
          Positioned(
            top: 500,
            left: 20,
            right: 20,
            child: _buildTextField("Password", _passwordController,
                (value) => userProvider.updatePassword(value),
                obscureText: true),
          ),
          Positioned(
            top: 600,
            left: 20,
            right: 20,
            child: _buildDateField("Birthdate", userProvider.birthdate,
                () => _selectBirthdate(context)),
          ),
          Positioned(
            top: 730,
            left: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DeleteAccountScreen()),
                );
              },
              child: Text(
                "Delete Account",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      Function(String) onChanged,
      {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              border: InputBorder.none,
              suffixIcon: Icon(Icons.edit, color: Colors.white70, size: 20),
            ),
            onChanged: onChanged,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildDateField(String label, String value, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.leagueSpartan(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: TextStyle(color: Colors.white)),
                Icon(Icons.calendar_today, color: Colors.white70, size: 20),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
