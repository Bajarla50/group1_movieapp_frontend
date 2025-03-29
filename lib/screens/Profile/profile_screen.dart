import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/screens/Login/login_screen.dart';
import 'package:movieapp/screens/HomePage/home_screen.dart';
import 'package:movieapp/screens/Profile/account_screen.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF05091D), Color(0xFF05091D)],
            stops: [0.1, 0.9],
          ),
        ),
        child: Stack(
          children: [
            // Back Button
            Positioned(
              top: 50,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
              ),
            ),

            // My Account Title
            Positioned(
              top: 55,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "My Account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Profile Avatar
            Positioned(
              top: 110,
              left: 20,
              right: 20,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: userProvider.profileImage != null
                    ? FileImage(userProvider.profileImage!)
                    : AssetImage("assets/profile.png") as ImageProvider,
                backgroundColor: Colors.white24,
              ),
            ),

            // Username
            Positioned(
              top: 265,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  userProvider.username,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Menu Items
            Positioned(
              top: 320,
              left: 20,
              right: 20,
              child: _buildMenuItem(Icons.person, "Account", context),
            ),
            Positioned(
              top: 380,
              left: 20,
              right: 20,
              child: _buildMenuItem(
                  Icons.security, "Security & Permissions", context),
            ),
            Positioned(
              top: 440,
              left: 20,
              right: 20,
              child: _buildMenuItem(Icons.settings, "Settings", context),
            ),

            // Sign Out Button
            Positioned(
              top: 510,
              left: 20,
              right: 20,
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
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (title == "Account") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountScreen()),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.leagueSpartan(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
