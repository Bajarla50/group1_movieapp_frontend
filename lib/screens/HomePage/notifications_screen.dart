import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> notifications = [
    "🎬 New for You! Based on your favorites, check out Godland!",
    "🍿 Weekend Watchlist Alert! These trending picks match your taste.",
    "⭐ Your Opinion Matters! People are loving your reviews—keep them coming!",
    "🆕 New Season Alert! Your favorite show Chicago Med just dropped a new episode!",
  ];

  // Track read/unread status
  List<bool> readStatus = [false, false, false, false];

  void markAsRead(int index) {
    setState(() {
      readStatus[index] = true;
    });
  }

  void markAllAsRead() {
    setState(() {
      readStatus = List.filled(notifications.length, true);
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
            colors: [
              Color(0xFF05091D), // Solid color
              Color(0xFF05091D), // Solid color
            ],
            stops: [0.1, 0.9], // 10% to 90% position
          ),
        ),
        child: Stack(
          children: [
            // "Notifications" Title
            Positioned(
              top: 60,
              left: 35,
              child: Text(
                "Notifications",
                style: GoogleFonts.ptSerifCaption(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),

            // "Mark all as read" Button (Transparent)
            Positioned(
              top: 90,
              right: 16,
              child: TextButton(
                onPressed: markAllAsRead,
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  ),
                ),
                child: Text(
                  "Mark all as read",
                  style: GoogleFonts.cabin(fontSize: 16, color: Colors.white),
                ),
              ),
            ),

            // Notification List
            Positioned(
              top: 155,
              left: 20,
              right: 20,
              bottom: 0,
              child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => markAsRead(index), // Mark notification as read
                    child: Stack(
                      clipBehavior: Clip.none, // Allows dot to be outside box
                      children: [
                        // Notification Box
                        Container(
                          margin: EdgeInsets.only(left: 12, bottom: 16),
                          width: 340,
                          height: 54,
                          decoration: BoxDecoration(
                            color: Color(0xFF9D9696).withOpacity(
                                readStatus[index]
                                    ? 0.12
                                    : 0.35), // Fades on click
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                notifications[index],
                                style: GoogleFonts.ptSerifCaption(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),

                        // Read Indicator Dot (Outside the box)
                        Positioned(
                          left: -9, // Moves dot outside the box
                          top: 19, // Centered vertically
                          child: AnimatedOpacity(
                            opacity: readStatus[index] ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Color(0xFF54D2EE), // Blue dot
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
