import 'package:baby_name_generator/view/girl_list/model/girl_database_provider.dart';
import 'package:flutter/material.dart';

import '../models/girl_model.dart';
import 'choice_screen.dart';

class FavoriteGirlNames extends StatefulWidget {
  const FavoriteGirlNames({Key? key}) : super(key: key);

  @override
  State<FavoriteGirlNames> createState() => _FavoriteGirlNamesState();
}

class _FavoriteGirlNamesState extends State<FavoriteGirlNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          generateBluredImage2("assets/images/forest.jpg"),
          FutureBuilder(
              future: GirlDatabaseProvider().getGirls(),
              builder: (BuildContext buildContext,
                  AsyncSnapshot<List<Girl>> asyncSnapshot) {
                String name = "";
                String description = "";
                int id = 0;

                final List<Girl>? list = asyncSnapshot.data;

                String openGirlName(Girl girl) {
                  name = girl.name;
                  return name;
                }

                String openGirlDesc(Girl girl) {
                  description = girl.description;
                  return description;
                }

                int openGirlId(Girl girl) {
                  id = girl.girlId;
                  return id;
                }

                if (asyncSnapshot.hasError) {
                  return const Center(
                    child: Text("Error Occured"),
                  );
                } else if (asyncSnapshot.hasData) {
                  return SafeArea(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: list == null ? 0 : list.length,
                        itemBuilder: (BuildContext buildContext, index) {
                          int counter = index;
                          counter++;
                          return Center(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: Colors.transparent,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor:
                                          Colors.pink.shade100.withOpacity(0.1),
                                      child: Text(
                                        counter.toString(),
                                        style: TextStyle(
                                          color: Colors.pink.shade400,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    openGirlName(list![index]),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3!
                                        .copyWith(
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w300),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextButton(
                                      onPressed: () {
                                        showAlertDialog(
                                            context,
                                            openGirlName(list[index]),
                                            openGirlDesc(list[index]), () {
                                          GirlDatabaseProvider().deleteGirl(
                                              openGirlId(list[index]));
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        });
                                      },
                                      child: Text(
                                        openGirlDesc(list[index]),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.pink.shade100,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Material(
                                    color: Colors.transparent,
                                    child: IconButton(
                                      splashColor: Colors.white,
                                      splashRadius: 30,
                                      iconSize: 30,
                                      onPressed: () {
                                        GirlDatabaseProvider().deleteGirl(
                                            openGirlId(list[index]));
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red.shade400,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context, String name, String description,
    Function() function) {
  Widget backButton = TextButton(
    child: Text(
      "Listeye Dön",
      style: TextStyle(color: Colors.pink.shade200, fontSize: 18),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget removeButton = TextButton(
    child: Text(
      "Favorilerden Kaldır",
      style: TextStyle(color: Colors.red.shade500, fontSize: 18),
    ),
    onPressed: function,
  );

  AlertDialog alert = AlertDialog(
    scrollable: true,
    backgroundColor: Colors.black.withOpacity(0.7),
    title: Text(
      name,
      style: Theme.of(context).textTheme.headline3!.copyWith(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
    ),
    content: Text(
      description,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    ),
    actions: [
      backButton,
      removeButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
