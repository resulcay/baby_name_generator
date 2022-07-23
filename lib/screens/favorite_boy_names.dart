import 'package:baby_name_generator/models/boy_model.dart';
import 'package:flutter/material.dart';

import '../view/boy_list/model/boy_database_provider.dart';
import 'choice_screen.dart';

class FavoriteBoyNames extends StatefulWidget {
  const FavoriteBoyNames({Key? key}) : super(key: key);

  @override
  State<FavoriteBoyNames> createState() => _FavoriteBoyNamesState();
}

class _FavoriteBoyNamesState extends State<FavoriteBoyNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          generateBluredImage2("assets/images/forest.jpg"),
          FutureBuilder(
              future: BoyDatabaseProvider().getBoys(),
              builder: (BuildContext buildContext,
                  AsyncSnapshot<List<Boy>> asyncSnapshot) {
                String name = "";
                String description = "";
                int id = 0;

                final List<Boy>? list = asyncSnapshot.data;

                String openBoyName(Boy boy) {
                  name = boy.name;
                  return name;
                }

                String openBoyDesc(Boy boy) {
                  description = boy.description;
                  return description;
                }

                int openBoyId(Boy boy) {
                  id = boy.boyId;
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
                                          Colors.blue.shade100.withOpacity(0.1),
                                      child: Text(
                                        counter.toString(),
                                        style: TextStyle(
                                          color: Colors.blue.shade400,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    openBoyName(list![index]),
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
                                            openBoyName(list[index]),
                                            openBoyDesc(list[index]), () {
                                          BoyDatabaseProvider().deleteBoy(
                                              openBoyId(list[index]));
                                          Navigator.of(context).pop();
                                          setState(() {});
                                        });
                                      },
                                      child: Text(
                                        openBoyDesc(list[index]),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w300,
                                          color: Colors.blue.shade100,
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
                                        BoyDatabaseProvider()
                                            .deleteBoy(openBoyId(list[index]));
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
      style: TextStyle(color: Colors.blue.shade200, fontSize: 18),
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
