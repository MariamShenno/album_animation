import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const AlbumAnimation());
}

class AlbumAnimation extends StatelessWidget {
  const AlbumAnimation({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
 
