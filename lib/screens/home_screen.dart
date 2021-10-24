import 'package:flutter/material.dart';
import 'package:memegen_hcrl/screens/select_meme_screen.dart';
import '../meme_data.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Meme'),
      ),
      body: GridView.builder(
        itemCount: memeName.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => SelectMeme("assets/meme/${memeName[i]}.jpg"),
              ),
            );
          },
          child: Image.asset(
            "assets/meme/${memeName[i]}.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
