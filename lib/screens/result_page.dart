import 'dart:math';
import 'dart:ui' as ui;

import 'package:baby_name_generator/components/box_decoration.dart';
import 'package:baby_name_generator/firebase.dart';
import 'package:baby_name_generator/models/boy_model.dart';
import 'package:baby_name_generator/screens/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

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
  bool shouldPop = false;
  @override
  Widget build(BuildContext context) {
    int randomNumberForGirls = Random().nextInt(10);
    int randomNumberForBoys = Random().nextInt(10);
    return WillPopScope(
      onWillPop: () async {
        return shouldPop;
      },
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: StreamBuilder(
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
                        ? SafeArea(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                generateBluredImage('assets/images/girl.jpg'),
                                Container(
                                  margin: const EdgeInsets.all(20.0),
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: buildBoxDecoration(
                                      Colors.purple.shade300.withOpacity(0.3)),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${documentSnaps[randomNumberForGirls].get('female name')}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                        color: Colors
                                                            .pink.shade200,
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                FavoriteButton(
                                                    valueChanged: (isForSave) {
                                                  forceSave = isForSave;
                                                })
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.all(15),
                                              child: Text(
                                                "${documentSnaps[randomNumberForGirls].get('description')}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        Colors.pink.shade100),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              splashColor: Colors.white,
                                              splashRadius: 30,
                                              iconSize: 45,
                                              onPressed: () {
                                                String extractedFemaleName =
                                                    documentSnaps[
                                                            randomNumberForGirls]
                                                        .get('female name');
                                                String
                                                    extractedFemaleDescription =
                                                    documentSnaps[
                                                            randomNumberForGirls]
                                                        .get('description');

                                                Girl girl = Girl(
                                                    name: extractedFemaleName,
                                                    description:
                                                        extractedFemaleDescription);
                                                forceSave == true
                                                    ? GirlDatabaseProvider()
                                                        .addGirl(girl)
                                                    : null;

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeView()));
                                              },
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color:
                                                    Colors.pinkAccent.shade400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SafeArea(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                generateBluredImage('assets/images/boy.jpg'),
                                Container(
                                  margin: const EdgeInsets.all(20.0),
                                  padding: const EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: buildBoxDecoration(
                                      Colors.blue.shade300.withOpacity(0.3)),
                                  child: Center(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      physics: const BouncingScrollPhysics(),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${documentSnaps[randomNumberForBoys].get('male name')}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline1!
                                                      .copyWith(
                                                        color: Colors
                                                            .blue.shade200,
                                                        fontSize: 40,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                FavoriteButton(
                                                    valueChanged: (isForSave) {
                                                  forceSave = isForSave;
                                                })
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              margin: const EdgeInsets.all(15),
                                              child: Text(
                                                "${documentSnaps[randomNumberForBoys].get('description')}",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w300,
                                                    color:
                                                        Colors.blue.shade100),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Material(
                                            color: Colors.transparent,
                                            child: IconButton(
                                              splashColor: Colors.white,
                                              splashRadius: 30,
                                              iconSize: 45,
                                              onPressed: () {
                                                String extractedMaleName =
                                                    documentSnaps[
                                                            randomNumberForBoys]
                                                        .get('male name');
                                                String
                                                    extractedMaleDescription =
                                                    documentSnaps[
                                                            randomNumberForBoys]
                                                        .get('description');

                                                Boy boy = Boy(
                                                    name: extractedMaleName,
                                                    description:
                                                        extractedMaleDescription);
                                                forceSave == true
                                                    ? BoyDatabaseProvider()
                                                        .addBoy(boy)
                                                    : null;

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const HomeView()));
                                              },
                                              icon: Icon(
                                                Icons.arrow_back,
                                                color:
                                                    Colors.blueAccent.shade400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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

Widget generateBluredImage(String imagePath) {
  return Container(
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagePath),
        fit: BoxFit.cover,
      ),
    ),
    child: BackdropFilter(
      filter: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
        ),
      ),
    ),
  );
}
