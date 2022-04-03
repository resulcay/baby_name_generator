import 'dart:math';

import 'package:baby_name_generator/components/box_decoration.dart';
import 'package:baby_name_generator/firebase.dart';
import 'package:baby_name_generator/local_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
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
                ? BackEnd().girlMethod().snapshots()
                : BackEnd().boyMethod().snapshots(),
            builder: (BuildContext context, AsyncSnapshot asyncsnaphot) {
              if (asyncsnaphot.hasError) {
                const Center(
                  child: Text("An Error Occured"),
                );
              } else if (asyncsnaphot.hasData) {
                try {
                  List<DocumentSnapshot> documentSnaps = asyncsnaphot.data.docs;
                  return Center(
                    child: widget.isGirl == true
                        ? Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: buildBoxDecoration(),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${documentSnaps[randomNumberForGirls].get('female name')}",
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      FavoriteButton(
                                          valueChanged: (isForSave) async {
                                        var x =
                                            documentSnaps[randomNumberForGirls]
                                                .get('female name');
                                        var y =
                                            documentSnaps[randomNumberForGirls]
                                                .get('description');
                                        await isForSave == true
                                            ? LocalStorage()
                                                .saveGirlNameAndDescToSharedPref(
                                                    x.toString(), y.toString())
                                            : LocalStorage()
                                                .deleteGirlNameAndDescFromSharedPref(
                                                    x.toString());
                                      })
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                      "${documentSnaps[randomNumberForGirls].get('description')}"),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: buildBoxDecoration(),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${documentSnaps[randomNumberForBoys].get('male name')}",
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                      "${documentSnaps[randomNumberForBoys].get('description')}"),
                                ],
                              ),
                            ),
                          ),
                  );
                } catch (e) {
                  BackEnd().customSnackBar(e.toString(), context);
                }
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }
}
