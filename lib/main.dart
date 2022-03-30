import 'package:baby_name_generator/favorite_names.dart';
import 'package:baby_name_generator/result_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BebekUygulamasi());
}

class BebekUygulamasi extends StatefulWidget {
  const BebekUygulamasi({Key? key}) : super(key: key);

  @override
  _BebekUygulamasiState createState() => _BebekUygulamasiState();
}

class _BebekUygulamasiState extends State<BebekUygulamasi> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      //  initialRoute: BebekUygulamasi(),
      //  routes: {BebekUygulamasi().routeOrder: (context) => BebekUygulamasi()},
      home: BebekIsim(),
    );
  }
}

class BebekIsim extends StatefulWidget {
  const BebekIsim({Key? key}) : super(key: key);
  @override
  _BebekIsimState createState() => _BebekIsimState();
}

class _BebekIsimState extends State<BebekIsim> {
  String? kontrol;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.elliptical(0.0, 0.0),
                  topLeft: Radius.elliptical(50.0, 50.0),
                  bottomRight: Radius.elliptical(50.0, 50.0),
                  bottomLeft: Radius.elliptical(50.0, 50.0),
                ),
                color: Colors.teal),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Favori İsimlerim',
                        style: TextStyle(fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FavoriteName(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'KIZ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pinkAccent),
                            ),
                            TextButton(
                              onPressed: () {
                                String female = 'KIZ';
                                kontrol = female;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            GeneratedName(kontrol: kontrol)));
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset(
                                  'assets/images/girl.jpg',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'ERKEK',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo),
                            ),
                            TextButton(
                                //   style: ButtonStyle(),
                                onPressed: () {
                                  String male = 'ERKEK';
                                  kontrol = male;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GeneratedName(
                                                kontrol: kontrol,
                                              )));
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(
                                    'assets/images/boy.jpg',
                                  ),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
