import 'package:flutter/material.dart';

import 'favorite_boy_names.dart';
import 'favorite_girl_names.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteGirlNames(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.pink,
                  child: const Center(child: Text("Kayıtlı Kız İsimlerim")),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FavoriteBoyNames(),
                    ),
                  );
                },
                child: Container(
                  color: Colors.blueAccent,
                  child: const Center(child: Text("Kayıtlı Erkek İsimlerim")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
