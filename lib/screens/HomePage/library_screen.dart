import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LibraryScreen extends StatelessWidget {
  final List<String> savedMovies = [
    'assets/movie1.jpg',
    'assets/movie2.jpg',
    'assets/movie3.jpg',
    'assets/movie4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Library', style: GoogleFonts.poppins(color: Colors.white)),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: savedMovies.isEmpty
          ? Center(
              child: Text(
                'No saved movies yet',
                style: GoogleFonts.poppins(color: Colors.white70, fontSize: 16),
              ),
            )
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: savedMovies.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(savedMovies[index], fit: BoxFit.cover),
                );
              },
            ),
    );
  }
}
