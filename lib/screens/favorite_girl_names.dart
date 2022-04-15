import 'package:baby_name_generator/view/girl_list/model/girlDatabaseProvider.dart';
import 'package:flutter/material.dart';

import '../girl_model.dart';

class FavoriteGirlNames extends StatefulWidget {
  const FavoriteGirlNames({Key? key}) : super(key: key);

  @override
  State<FavoriteGirlNames> createState() => _FavoriteGirlNamesState();
}

class _FavoriteGirlNamesState extends State<FavoriteGirlNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
                child: Text("Errrrrr"),
              );
            } else if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (BuildContext buildContext, index) {
                    int counter = index;
                    counter++;
                    return Center(
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.blue.shade500,
                              child: Text(counter.toString())),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(openGirlName(list![index])),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(openGirlDesc(list[index])),
                          const SizedBox(
                            width: 40,
                          ),
                          IconButton(
                            onPressed: () {
                              GirlDatabaseProvider()
                                  .deleteGirl(openGirlId(list[index]));
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    );
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
