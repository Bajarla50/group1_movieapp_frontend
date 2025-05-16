import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'library_screen.dart';
import 'notifications_screen.dart';
import 'package:movieapp/screens/Profile/profile_screen.dart';

// Movies
import 'package:movieapp/screens/HomePage/Movies/ambut.dart';
import 'package:movieapp/screens/HomePage/Movies/arcane.dart';
import 'package:movieapp/screens/HomePage/Movies/avengers endgame.dart';
import 'package:movieapp/screens/HomePage/Movies/Decendants.dart';
import 'package:movieapp/screens/HomePage/Movies/frozen 2.dart';
import 'package:movieapp/screens/HomePage/Movies/gravity falls.dart';
import 'package:movieapp/screens/HomePage/Movies/june.dart';
import 'package:movieapp/screens/HomePage/Movies/loki.dart';
import 'package:movieapp/screens/HomePage/Movies/rick and morty.dart';
import 'package:movieapp/screens/HomePage/Movies/run on.dart';
import 'package:movieapp/screens/HomePage/Movies/star vs the forces of evil.dart';
import 'package:movieapp/screens/HomePage/Movies/stranger things.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<double> iconSizes = [26, 20, 26, 26];

  final List<Widget> _screens = [
    Container(),
    LibraryScreen(),
    NotificationsScreen(),
    ProfileScreen(),
  ];
//add movies {'image': 'assets/image_path.jpg', 'screen': moviename()}
  final List<Map<String, dynamic>> trendingMovies = [
    {'image': 'assets/Frozen 2(2).png', 'screen': Frozen2Screen()},
    {'image': 'assets/Arcane(2).png', 'screen': ArcaneScreen()},
    {'image': 'assets/June.jpg', 'screen': JuneScreen()},
  ];

  final List<Map<String, dynamic>> forYouMovies = [
    {'image': 'assets/Frozen 2.png', 'screen': Frozen2Screen()},
    {'image': 'assets/June.jpg', 'screen': JuneScreen()},
    {'image': 'assets/Avengers Endgame.jpg', 'screen': AvengersEndgameScreen()},
  ];

  final List<Map<String, dynamic>> seriesMovies = [
    {'image': 'assets/Loki.png', 'screen': LokiScreen()},
    {'image': 'assets/Stranger Things.jpg', 'screen': StrangerThingsScreen()},
    {'image': 'assets/Arcane.jpg', 'screen': ArcaneScreen()},
  ];

  final List<Map<String, dynamic>> kDramaMovies = [
    {'image': 'assets/Decendants.png', 'screen': DescendantsScreen()},
    {'image': 'assets/Ambut.png', 'screen': AmbutScreen()},
    {'image': 'assets/Run On.png', 'screen': RunOnScreen()},
  ];

  final List<Map<String, dynamic>> cartoonMovies = [
    {'image': 'assets/Gravity Falls.jpeg', 'screen': GravityFallsScreen()},
    {'image': 'assets/Rick and Morty.jpg', 'screen': RickAndMortyScreen()},
    {
      'image': 'assets/Star vs the Forces of Evil.jpg',
      'screen': StarVsForcesOfEvilScreen()
    },
  ];

  List<Map<String, dynamic>> get allMovies => [
        ...trendingMovies,
        ...forYouMovies,
        ...seriesMovies,
        ...kDramaMovies,
        ...cartoonMovies,
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
            Expanded(
                child: _selectedIndex == 0
                    ? _buildHomeContent()
                    : _screens[_selectedIndex]),
            _buildBottomNavigationBar(),
          ],
        ),
      ),
    );
  }

// Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: 90,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem('assets/Home Button.png', 0),
            _buildNavItem('assets/Library Button.png', 1),
            _buildNavItem('assets/Notification Button.png', 2),
            _buildNavItem('assets/Account Button.png', 3),
          ],
        ),
      ),
    );
  }

// Bottom Navigation Bar colors
  BottomNavigationBarItem _buildNavItem(String assetPath, int index) {
    return BottomNavigationBarItem(
      icon: _selectedIndex == index
          ? Image.asset(assetPath, width: iconSizes[index], color: Colors.white)
          : ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Color(0xFF544CC6), Color(0xFF988CBC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds);
              },
              child: Image.asset(assetPath,
                  width: iconSizes[index], color: Colors.white),
            ),
      label: '',
    );
  }

// category section
  Widget _buildHomeContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            SizedBox(height: 20),
            _buildTrendingSection(),
            SizedBox(height: 20),
            _buildCategorySection('For You', forYouMovies),
            _buildCategorySection('Series', seriesMovies),
            _buildCategorySection('K-drama', kDramaMovies),
            _buildCategorySection('Cartoon', cartoonMovies),
          ],
        ),
      ),
    );
  }

//search bar
  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: 400,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xFF101010),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white70),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF565656),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text('Enter', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

//trending section
  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Trending', style: _headerStyle()),
        SizedBox(height: 10),
        Container(
          height: 180,
          child: PageView.builder(
            itemCount: trendingMovies.length,
            controller: PageController(viewportFraction: 0.9),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => trendingMovies[index]['screen'])),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(trendingMovies[index]['image'],
                      fit: BoxFit.cover),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(
      String title, List<Map<String, dynamic>> movies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: _headerStyle()),
            Text('See More', style: _seeMoreStyle()),
          ],
        ),
        SizedBox(height: 10),
        Container(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => movies[index]['screen'])),
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(movies[index]['image'],
                        width: 100, height: 125, fit: BoxFit.cover),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  TextStyle _headerStyle() {
    return GoogleFonts.ptSerifCaption(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }

  TextStyle _seeMoreStyle() {
    return GoogleFonts.leagueSpartan(
      fontSize: 16,
      fontWeight: FontWeight.w300,
      color: Color(0xFF9F9F9F),
    );
  }
}

class SearchBarWidget extends StatefulWidget {
  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        height: 45,
        decoration: BoxDecoration(
          color: Color(0xFF101010), // Outer design box
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: Stack(
          children: [
            // Search Box (underneath Enter)
            Positioned(
              left: 5,
              right: 5,
              top: 5,
              child: Container(
                width: 100,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF616161),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.white, size: 18),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white70),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Enter Button (Above Search Box)
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                width: 82,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF565656),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Enter',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
