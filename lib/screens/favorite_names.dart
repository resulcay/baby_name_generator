import 'package:baby_name_generator/local_storage.dart';
import 'package:flutter/material.dart';

import '../firebase.dart';

class FavoriteNames extends StatefulWidget {
  const FavoriteNames({Key? key}) : super(key: key);
  @override
  State<FavoriteNames> createState() => _FavoriteNamesState();
}

class _FavoriteNamesState extends State<FavoriteNames> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(builder: (context, _) {
        try {
          return Center(
            child: Text(
                LocalStorage().viewGirlNameAndDescFromSharedPref().toString()),
          );
        } catch (e) {
          BackEnd().customSnackBar(e.toString(), context);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

//Scaffold(
//       appBar: AppBar(title: const Text("Favori İsimlerim")),
//       body: SafeArea(
//         child: Flexible(
//           child: ListView.builder(
//             itemCount: 50,
//             itemBuilder: (context, _) {
//               return const Card(
//                 elevation: 1,
//                 child: Text("Some Names"),
//                 color: Colors.blueAccent,
//               );
//             },
//           ),
//         ),
//       ),
//     );
