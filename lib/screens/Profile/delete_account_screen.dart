import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/screens/Login/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';
import 'dart:io';

class DeleteAccountScreen extends StatelessWidget {
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
            left: 20,
            right: 20,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Delete Your Account",
                style: GoogleFonts.leagueSpartan(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            right: 20,
            child: Text(
              "Deleting your account will remove all your data, make your comments invisible, and unlink your profile from Google and Facebook.",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
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
            top: 375,
            left: 20,
            right: 20,
            child: Text(
              "${userProvider.username}, we're sorry to see you go! Your account and data will be deleted, but if you ever change your mind, we’ll be here to welcome you back. Take care!",
              textAlign: TextAlign.center,
              style: GoogleFonts.cabin(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
          Positioned(
            top: 735,
            left: 20,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
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
}
