import 'package:baby_name_generator/local_storage.dart';
import 'package:flutter/material.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({Key? key}) : super(key: key);

  @override
  State<FavoriteNames> createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<String>?>(
          future: LocalStorage().viewGirlNameAndDescFromSharedPref(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<List<String>?> asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              final List<String>? theText = asyncSnapshot.data;
              return Center(
                child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(theText![index]),
                            //Text(theText[index + 1])
                          ],
                        ),
                      );
                    }),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}

// ListTile(
//                         tileColor: Colors.teal,
//                         leading: Text(theText![0]),
//                         title: Text(theText[1]),
//                         trailing: IconButton(
//                             onPressed: () {}, icon: const Icon(Icons.delete)),
//                       )
