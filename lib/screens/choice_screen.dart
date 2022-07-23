import 'dart:ui' as ui;

import 'package:baby_name_generator/components/box_decoration.dart';
import 'package:flutter/material.dart';

import 'favorite_boy_names.dart';
import 'favorite_girl_names.dart';

class ChoiceScreen extends StatelessWidget {
  const ChoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          generateBluredImage2("assets/images/forest.jpg"),
          SafeArea(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: buildBoxDecoration3(),
                        child: Center(
                          child: Text(
                            "Kayıtlı Kız İsimlerim",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 40),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  thickness: 0.2,
                  height: 5,
                  indent: 20,
                  endIndent: 20,
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: buildBoxDecoration4(),
                        child: Center(
                          child: Text(
                            "Kayıtlı Erkek İsimlerim",
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 37),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget generateBluredImage2(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
    child: BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    ),
  );
}
