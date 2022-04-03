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
      body: FutureBuilder<String?>(
          future: LocalStorage().viewGirlNameAndDescFromSharedPref(),
          builder: (BuildContext buildContext,
              AsyncSnapshot<String?> asyncSnapshot) {
            if (asyncSnapshot.hasData) {
              final theText = asyncSnapshot.data;
              return Center(
                child: ListView.builder(
                    itemCount: 50,
                    itemBuilder: (context, _) {
                      return ListTile(
                        tileColor: Colors.teal,
                        leading: const Text("some names"),
                        title: const Text("some desc"),
                        trailing: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete)),
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
