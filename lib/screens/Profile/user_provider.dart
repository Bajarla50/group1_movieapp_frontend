import 'package:flutter/material.dart';
import 'dart:io';

class UserProvider with ChangeNotifier {
  String _username = "User";
  String _email = "Celestiang@Gmail.Com";
  String _password = "********";
  String _birthdate = "01/01/2000";
  File? _profileImage;
  File? _coverImage;
  List<String> _bookmarkedMovies = [];

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get birthdate => _birthdate;
  File? get profileImage => _profileImage;
  File? get coverImage => _coverImage;
  List<String> get bookmarkedMovies => _bookmarkedMovies;

  // Setters
  void updateUsername(String username) {
    _username = username;
    notifyListeners();
  }

  void updateEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    _password = password;
    notifyListeners();
  }

  void updateBirthdate(String birthdate) {
    _birthdate = birthdate;
    notifyListeners();
  }

  void updateProfileImage(File image) {
    _profileImage = image;
    notifyListeners();
  }

  void updateCoverImage(File image) {
    _coverImage = image;
    notifyListeners();
  }

  // Bookmark Functions
  void addToLibrary(String movie) {
    if (!_bookmarkedMovies.contains(movie)) {
      _bookmarkedMovies.add(movie);
      notifyListeners();
    }
  }

  void removeFromLibrary(String movie) {
    _bookmarkedMovies.remove(movie);
    notifyListeners();
  }

  bool isMovieBookmarked(String movie) {
    return _bookmarkedMovies.contains(movie);
  }
}
