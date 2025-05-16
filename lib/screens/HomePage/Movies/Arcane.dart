import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movieapp/screens/HomePage/home_screen.dart';
import 'package:movieapp/screens/Profile/user_provider.dart';

class ArcaneScreen extends StatefulWidget {
  @override
  _ArcaneScreenState createState() => _ArcaneScreenState();
}

class _ArcaneScreenState extends State<ArcaneScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final String movieTitle = "Arcane";
    bool isBookmarked = userProvider.bookmarkedMovies.contains(movieTitle);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/Arcane(2).png",
                    width: double.infinity,
                    height: 494,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 20,
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
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Arcane: League of Legends",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Season 1 & 2",
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        _infoChip("Series"),
                        SizedBox(width: 10),
                        _infoChip("9 Episodes"),
                        SizedBox(width: 10),
                        _infoChip("⭐ 4.5"),
                        Spacer(),
                        IconButton(
                          icon: Icon(
                            isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isBookmarked) {
                                userProvider.removeFromLibrary(movieTitle);
                              } else {
                                userProvider.addToLibrary(movieTitle);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Genre: Animation, Action, Adventure, Fantasy, Drama, Science Fiction, Gaming",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "A series based on the game League of Legends. In the divided cities of Piltover and Zaun, two sisters, Vi and Jinx, are torn apart by war, betrayal, and dangerous power. As revolution rises and secrets unravel, their bond is tested in a battle that could change everything. With stunning animation and gripping storytelling, Arcane delivers an emotional, high-stakes journey you won’t forget.",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text, style: TextStyle(color: Colors.white)),
    );
  }
}
