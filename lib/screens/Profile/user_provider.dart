import 'package:flutter/material.dart';
import 'dart:io';

class UserProvider with ChangeNotifier {
  String _username = "User";
  String _email = "Celestiang@Gmail.Com";
  String _password = "********"; // Ensure this exists
  String _birthdate = "01/01/2000";
  File? _profileImage;
  File? _coverImage;

  // Getters
  String get username => _username;
  String get email => _email;
  String get password => _password; // Add this getter
  String get birthdate => _birthdate;
  File? get profileImage => _profileImage;
  File? get coverImage => _coverImage;

  // Setters (Ensure password setter exists)
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
}
