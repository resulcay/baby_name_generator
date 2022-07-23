import 'package:baby_name_generator/screens/choice_screen.dart';
import 'package:baby_name_generator/screens/result_page.dart';
import 'package:flutter/material.dart';

import '../components/box_decoration.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isGirl = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white12,
        body: Center(
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: buildBoxDecoration2(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Favori İsimlerim",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChoiceScreen(),
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
                            Text(
                              'KIZ',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.pink.shade200),
                            ),
                            TextButton(
                              onPressed: () {
                                isGirl = true;
                                isGirl == true
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResultPage(isGirl: isGirl)))
                                    : Container();
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
                            Text(
                              'ERKEK',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo.shade200),
                            ),
                            TextButton(
                                //   style: ButtonStyle(),
                                onPressed: () {
                                  isGirl = false;
                                  isGirl == false
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ResultPage(isGirl: isGirl)))
                                      : Container();
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
