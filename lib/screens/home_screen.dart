import 'package:flutter/material.dart';
import 'bookmark_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _currentSlide = 2; // For the dots indicator
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF201F1F)],
            stops: [0.525, 1.0],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44),
              // Search Bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Image.network(
                        'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/material.png'),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              // Trending Section
              Padding(
                padding: EdgeInsets.only(left: 13, top: 30),
                child: Text(
                  'Trending',
                  style: TextStyle(
                    fontFamily: 'PT Serif Caption',
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),

              // Trending Carousel
              Container(
                height: 207,
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Stack(
                  children: [
                    Image.network(
                      'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/image.png',
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Frozen 2',
                            style: TextStyle(
                              fontFamily: 'Prata',
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Musical   Animation  Family  Drama  Children\'s Film   Fantasy',
                            style: TextStyle(
                              fontFamily: 'Anek Kannada',
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Dots Indicator
                    Positioned(
                      bottom: 20,
                      right: 20,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Container(
                            margin: EdgeInsets.all(2),
                            width: 7,
                            height: 7,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == _currentSlide
                                  ? Color(0xFF5C67D1)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // For You Section
              _buildSection('For You',
                  'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/trend.png'),

              // Series Section
              _buildSection('Series',
                  'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/series.png'),

              // K-drama Section
              _buildSection('K-drama',
                  'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/kdrama.png'),

              // Cartoon Section
              _buildSection('Cartoon',
                  'https://dashboard.codeparrot.ai/api/image/Z9hQiCppvFKitUSn/frame-9.png'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF5C67D1),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), label: 'Bookmarks'),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'PT Serif Caption',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See More',
                  style: TextStyle(
                    fontFamily: 'League Spartan',
                    fontSize: 20,
                    color: Color(0xFF9F9F9F),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 155,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookmarkScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotificationScreen()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }
}
