import 'dart:math';

import 'package:baby_name_generator/name_pool.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

class GeneratedName extends StatefulWidget {
  final String? kontrol;
  const GeneratedName({Key? key, this.kontrol}) : super(key: key);
  @override
  _GeneratedNameState createState() => _GeneratedNameState(kontrol);
}

class _GeneratedNameState extends State<GeneratedName> {
  String? kontrol;

  _GeneratedNameState(this.kontrol);

  GirlNamePool extactgirl_1 = GirlNamePool();
  BoyNamePool extractboy_1 = BoyNamePool();

  @override
  Widget build(BuildContext context) {
    int randomNumber = Random().nextInt(10);
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Rastgele İsim Bulundu!'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kontrol == 'ERKEK'
                    ? extractboy_1.boyNames[randomNumber].bname.toString()
                    : extactgirl_1.girlNames[randomNumber].gname.toString(),
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                ),
              ),
              FavoriteButton(
                isFavorite: false,
                // iconDisabledColor: Colors.white,
                valueChanged: (_isFavorite) {},
              ),
            ],
          ),
          Text(
            kontrol == 'ERKEK'
                ? extractboy_1.boyNames[randomNumber].bexplanation.toString()
                : extactgirl_1.girlNames[randomNumber].gexplanation.toString(),
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
