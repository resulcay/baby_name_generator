import 'package:baby_name_generator/firebase.dart';
import 'package:baby_name_generator/screens/home_view.dart';
import 'package:baby_name_generator/view/boy_list/model/boy_database_provider.dart';
import 'package:baby_name_generator/view/girl_list/model/girl_database_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GirlDatabaseProvider().openDBforGirls();
  await BoyDatabaseProvider().openDBforBoys();
  runApp(const RootOfApp());
}

class RootOfApp extends StatefulWidget {
  const RootOfApp({Key? key}) : super(key: key);

  @override
  _RootOfAppState createState() => _RootOfAppState();
}

class _RootOfAppState extends State<RootOfApp> {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initializeApp = Firebase.initializeApp();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: _initializeApp,
        builder: (context, snapshot) {
          try {
            if (snapshot.hasError) {
              return const Center(
                child: Text("An Error Occured!"),
              );
            } else if (snapshot.hasData) {
              return const HomeView();
            }
          } catch (e) {
            BackEnd().customSnackBar(e.toString(), context);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
