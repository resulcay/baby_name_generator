import 'package:flutter/material.dart';

import '../boy_model.dart';
import '../view/boy_list/model/boyDatabaseProvider.dart';

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
                          Text(openBoyName(list![index])),
                          const SizedBox(
                            width: 40,
                          ),
                          Text(openBoyDesc(list[index])),
                          const SizedBox(
                            width: 40,
                          ),
                          IconButton(
                            onPressed: () {
                              BoyDatabaseProvider()
                                  .deleteBoy(openBoyId(list[index]));
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
