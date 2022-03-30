import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'name_pool.dart';

class FavoriteName extends StatefulWidget {
  const FavoriteName({Key? key}) : super(key: key);

  @override
  _FavoriteNameState createState() => _FavoriteNameState();
}

class _FavoriteNameState extends State<FavoriteName> {
  GirlNamePool extactgirl_1 = GirlNamePool();
  BoyNamePool extractboy_1 = BoyNamePool();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Favori İsimlerim'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(4),
          itemCount: 5,
          itemBuilder: (context, _) {
            return boyListTile;
          }),
    );
  }
}

ListTile girlListTile = ListTile(
  title: Text("gname"),
  tileColor: Colors.pink,
  leading: Icon(Icons.favorite),
  onTap: () {
    Text('gname exp');
  },
);

ListTile boyListTile = ListTile(
  title: Text('Hakan'),
  subtitle: Text('Hükümdar anlamına gelir'),
  tileColor: Colors.indigo,
  leading: Icon(Icons.favorite),
  onTap: () {
    Text('bname exp');
  },
);
