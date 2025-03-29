import 'package:flutter/material.dart';

class RickAndMortyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rick and Morty")),
      body: Center(child: Text("Details about Rick and Morty")),
    );
  }
}
