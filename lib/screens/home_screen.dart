import 'package:flutter/material.dart';
import '../meme_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: GridView.builder(
          itemCount: memeName.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 / 1,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (ctx, i) => Image.asset(
            "assets/meme/${memeName[i]}.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
