import 'package:baby_name_generator/view/girl_list/model/girlDatabaseProvider.dart';
import 'package:flutter/material.dart';

import '../local_storage.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({Key? key}) : super(key: key);

  @override
  State<FavoriteNames> createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Girl>>(
          future: GirlDatabaseProvider().getGirls(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<Girl>> asyncSnapshot) {
            String name = "";
            String description = "";
            int id = 0;

            final List<Girl>? ass = asyncSnapshot.data;

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
                  itemCount: ass?.length,
                  itemBuilder: (BuildContext buildContext, index) {
                    return Center(
                      child: Column(
                        children: [
                          Text(openGirlId(ass![index]).toString()),
                          Text(openGirlName(ass[index])),
                          Text(openGirlDesc(ass[index])),
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

//FutureBuilder<List<String>?>(
//           future:  LocalStorage().,
//           builder: (BuildContext buildContext,
//               AsyncSnapshot<List<String>?> asyncSnapshot) {
//             if (asyncSnapshot.hasData) {
//               final List<String>? theText = asyncSnapshot.data;
//               return Center(
//                 child: ListView.builder(
//                     itemCount: 2,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         child: Column(
//                           children: [
//                             Text(theText![index]),
//                             //Text(theText[index + 1])
//                           ],
//                         ),
//                       );
//                     }),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           })

// ListTile(
//                         tileColor: Colors.teal,
//                         leading: Text(theText![0]),
//                         title: Text(theText[1]),
//                         trailing: IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.delete)),
//                       )
