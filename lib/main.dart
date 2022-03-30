import 'package:baby_name_generator/screens/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("An Error Occured!"),
            );
          } else if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
