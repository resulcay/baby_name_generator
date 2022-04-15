import 'package:baby_name_generator/view/girl_list/model/boyDatabaseProvider.dart';
import 'package:flutter/material.dart';

import '../local_storage.dart';

class FavoriteBoyNames extends StatefulWidget {
  const FavoriteBoyNames({Key? key}) : super(key: key);

  @override
  State<FavoriteBoyNames> createState() => _FavoriteBoyNamesState();
}

class _FavoriteBoyNamesState extends State<FavoriteBoyNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
                child: Text("Errrrrr"),
              );
            } else if (asyncSnapshot.hasData) {
              return ListView.builder(
                  itemCount: list == null ? 0 : list.length,
                  itemBuilder: (BuildContext buildContext, index) {
                    return Center(
                      child: Column(
                        children: [
                          Text(openBoyId(list![index]).toString()),
                          Text(openBoyName(list[index])),
                          Text(openBoyDesc(list[index])),
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
