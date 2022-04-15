import 'dart:math';

import 'package:baby_name_generator/components/box_decoration.dart';
import 'package:baby_name_generator/firebase.dart';
import 'package:baby_name_generator/screens/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import '../models/boy_model.dart';
import '../models/girl_model.dart';
import '../view/boy_list/model/boy_database_provider.dart';
import '../view/girl_list/model/girl_database_provider.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key, required this.isGirl}) : super(key: key);

  final bool isGirl;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    int randomNumberForGirls = Random().nextInt(4);
    int randomNumberForBoys = Random().nextInt(4);
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
                  bool forceSave = false;
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
                                      FavoriteButton(valueChanged: (isForSave) {
                                        forceSave = isForSave;
                                      })
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                      "${documentSnaps[randomNumberForGirls].get('description')}"),
                                  IconButton(
                                    onPressed: () {
                                      String extractedFemaleName =
                                          documentSnaps[randomNumberForGirls]
                                              .get('female name');
                                      String extractedFemaleDescription =
                                          documentSnaps[randomNumberForGirls]
                                              .get('description');

                                      Girl girl = Girl(
                                          name: extractedFemaleName,
                                          description:
                                              extractedFemaleDescription);
                                      forceSave == true
                                          ? GirlDatabaseProvider().addGirl(girl)
                                          : null;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeView()));
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${documentSnaps[randomNumberForBoys].get('male name')}",
                                        style: const TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      FavoriteButton(valueChanged: (isForSave) {
                                        forceSave = isForSave;
                                      })
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                      "${documentSnaps[randomNumberForBoys].get('description')}"),
                                  IconButton(
                                    onPressed: () {
                                      String extractedMaleName =
                                          documentSnaps[randomNumberForBoys]
                                              .get('male name');
                                      String extractedMaleDescription =
                                          documentSnaps[randomNumberForBoys]
                                              .get('description');

                                      Boy boy = Boy(
                                          name: extractedMaleName,
                                          description:
                                              extractedMaleDescription);
                                      forceSave == true
                                          ? BoyDatabaseProvider().addBoy(boy)
                                          : null;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const HomeView()));
                                    },
                                    icon: const Icon(Icons.arrow_back),
                                  ),
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
