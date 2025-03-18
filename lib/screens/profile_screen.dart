import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/screens/login_screen.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202956),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xFF202956),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF202956),
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: Stack(
        children: [
          // "My Account" Title (Centered & Styled with GoogleFonts)
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "My Account",
                textAlign: TextAlign.center,
                style: GoogleFonts.prata(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // Profile Avatar
          Positioned(
            top: 80,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.png"),
              backgroundColor: Colors.white24,
            ),
          ),

          // Username (Styled with GoogleFonts)
          Positioned(
            top: 160,
            left: MediaQuery.of(context).size.width / 2 - 70,
            child: Text(
              "User Name",
              textAlign: TextAlign.center,
              style: GoogleFonts.prata(
                fontSize: 24,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),

          // Menu Items (Consistent Styling)
          Positioned(
              top: 220,
              left: 20,
              right: 20,
              child: _buildMenuItem(Icons.person, "Account")),
          Positioned(
              top: 270,
              left: 20,
              right: 20,
              child:
                  _buildMenuItem(Icons.security, "Security And Permissions")),
          Positioned(
              top: 320,
              left: 20,
              right: 20,
              child: _buildMenuItem(Icons.settings, "Settings")),

          // Sign Out Button (Styled)
          Positioned(
            bottom: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    "Sign Out",
                    style: GoogleFonts.prata(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.prata(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
