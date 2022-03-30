import 'dart:math';

import 'package:baby_name_generator/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.isGirl}) : super(key: key);

  final bool isGirl;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    int randomNumberForGirls = Random().nextInt(3);
    int randomNumberForBoys = Random().nextInt(3);
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: widget.isGirl == true
                ? girlMethod().snapshots()
                : boyMethod().snapshots(),
            builder: (BuildContext context, AsyncSnapshot asyncsnaphot) {
              if (asyncsnaphot.hasError) {
                const Center(
                  child: Text("An Error Occured"),
                );
              } else if (asyncsnaphot.hasData) {
                List<DocumentSnapshot> documentSnapsForGirls =
                    asyncsnaphot.data.docs;
                List<DocumentSnapshot> documentSnapsForBoys =
                    asyncsnaphot.data.docs;
                return Center(
                  child: widget.isGirl == true
                      ? Text(
                          "${documentSnapsForGirls[randomNumberForGirls].get('female name')}")
                      : Text(
                          "${documentSnapsForBoys[randomNumberForBoys].get('male name')}"),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}

//               FavoriteButton(
//                 isFavorite: false,
//                 // iconDisabledColor: Colors.white,
//                 valueChanged: (_isFavorite) {},
//               ),
