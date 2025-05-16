import 'dart:io';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  // User info
  String _username = 'User';
  String _email = 'example@email.com';
  String _password = '********';
  String _birthdate = '01/01/2000';

  // Profile and cover images
  File? _profileImage;
  File? _coverImage;

  // Bookmarked movie asset paths
  List<String> _bookmarkedMovies = [];

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password;
  String get birthdate => _birthdate;

  File? get profileImage => _profileImage;
  File? get coverImage => _coverImage;

  List<String> get bookmarkedMovies => _bookmarkedMovies;

  // Setters & Updaters
  void updateUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateBirthdate(String value) {
    _birthdate = value;
    notifyListeners();
  }

  void updateProfileImage(File file) {
    _profileImage = file;
    notifyListeners();
  }

  void updateCoverImage(File file) {
    _coverImage = file;
    notifyListeners();
  }

  // Bookmark actions
  void addToLibrary(String movieAssetPath) {
    if (!_bookmarkedMovies.contains(movieAssetPath)) {
      _bookmarkedMovies.add(movieAssetPath);
      notifyListeners();
    }
  }

  void removeFromLibrary(String movieAssetPath) {
    _bookmarkedMovies.remove(movieAssetPath);
    notifyListeners();
  }

  void clearLibrary() {
    _bookmarkedMovies.clear();
    notifyListeners();
  }
}
