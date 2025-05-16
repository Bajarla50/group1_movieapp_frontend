import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';

// Your selected movie screen imports
import 'package:movieapp/screens/HomePage/Movies/Arcane.dart';
import 'package:movieapp/screens/HomePage/Movies/Frozen 2.dart';
import 'package:movieapp/screens/HomePage/Movies/Avengers Endgame.dart';
import 'package:movieapp/screens/HomePage/Movies/June.dart';
import 'package:movieapp/screens/HomePage/Movies/Loki.dart';
import 'package:movieapp/screens/HomePage/Movies/Stranger Things.dart';
import 'package:movieapp/screens/HomePage/Movies/Gravity Falls.dart';
import 'package:movieapp/screens/HomePage/Movies/Rick And Morty.dart';
import 'package:movieapp/screens/HomePage/Movies/Star vs the Forces Of Evil.dart';
import 'package:movieapp/screens/HomePage/Movies/Ambut.dart';
import 'package:movieapp/screens/HomePage/Movies/Run On.dart';

class LibraryScreen extends StatelessWidget {
  static const double posterWidth = 100;
  static const double posterHeight = 125;

  final Map<String, String> movieImages = {
    "Arcane": "assets/Arcane.jpg",
    "Frozen 2": "assets/Frozen 2.png",
    "Avengers Endgame": "assets/Avengers Endgame.jpg",
    "June": "assets/June.jpg",
    "Loki": "assets/Loki.png",
    "Stranger Things": "assets/Stranger Things.jpg",
    "Gravity Falls": "assets/Gravity Falls.jpeg",
    "Rick and Morty": "assets/Rick and Morty.jpg",
    "Star vs the Forces of Evil": "assets/Star vs the Forces of Evil.jpg",
    "Ambut": "assets/Ambut.png",
    "Run On": "assets/Run On.png",
  };

  final Map<String, Widget Function()> movieScreens = {
    "Arcane": () => ArcaneScreen(),
    "Frozen 2": () => Frozen2Screen(),
    "Avengers Endgame": () => AvengersEndgameScreen(),
    "June": () => JuneScreen(),
    "Loki": () => LokiScreen(),
    "Stranger Things": () => StrangerThingsScreen(),
    "Gravity Falls": () => GravityFallsScreen(),
    "Rick and Morty": () => RickAndMortyScreen(),
    "Star vs the Forces of Evil": () => StarVsForcesOfEvilScreen(),
    "Ambut": () => AmbutScreen(),
    "Run On": () => RunOnScreen(),
  };

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
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(child: _buildBody(userProvider, context)),
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

  Widget _buildBody(UserProvider userProvider, BuildContext context) {
    final bookmarkedMovies = userProvider.bookmarkedMovies;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: bookmarkedMovies.isEmpty
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
                childAspectRatio: posterWidth / posterHeight,
              ),
              itemCount: bookmarkedMovies.length,
              itemBuilder: (context, index) {
                final movieTitle = bookmarkedMovies[index];
                final imagePath =
                    movieImages[movieTitle] ?? 'assets/placeholder.png';

                return GestureDetector(
                  onTap: () {
                    final screenBuilder = movieScreens[movieTitle];
                    if (screenBuilder != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => screenBuilder()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("No screen found for '$movieTitle'")),
                      );
                    }
                  },
                  child: Container(
                    width: posterWidth,
                    height: posterHeight,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        children: [
                          Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: posterWidth,
                            height: posterHeight,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: posterWidth,
                                height: posterHeight,
                                color: Colors.grey[900],
                                child: Icon(Icons.broken_image,
                                    color: Colors.red, size: 40),
                              );
                            },
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: Icon(Icons.delete, color: Colors.white),
                              onPressed: () {
                                userProvider.removeFromLibrary(movieTitle);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
