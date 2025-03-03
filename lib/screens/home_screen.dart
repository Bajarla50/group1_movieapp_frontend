import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/profile.jpg'), // Replace with user image
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trending Section
              Text(
                "Trending",
                style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                child: PageView(
                  children: [
                    _buildTrendingItem("Frozen 2", "assets/frozen2.jpg"),
                    _buildTrendingItem("Dune", "assets/dune.jpg"),
                    _buildTrendingItem("Spider-Man", "assets/spiderman.jpg"),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // For You Section
              _buildSectionHeader("For You"),
              const SizedBox(height: 10),
              _buildHorizontalList([
                "assets/movie1.jpg",
                "assets/movie2.jpg",
                "assets/movie3.jpg",
                "assets/movie4.jpg",
              ]),

              const SizedBox(height: 20),

              // Series Section
              _buildSectionHeader("Series"),
              const SizedBox(height: 10),
              _buildHorizontalList([
                "assets/series1.jpg",
                "assets/series2.jpg",
                "assets/series3.jpg",
                "assets/series4.jpg",
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: "Bookmarks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
        ],
      ),
    );
  }

  Widget _buildTrendingItem(String title, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(10),
      child: Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        Text(
          "See More",
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.purple),
        ),
      ],
    );
  }

  Widget _buildHorizontalList(List<String> images) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                  image: AssetImage(images[index]), fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}
