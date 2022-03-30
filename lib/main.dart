import 'package:baby_name_generator/screens/home_view.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
