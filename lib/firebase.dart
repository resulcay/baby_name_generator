import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BackEnd {
  CollectionReference girlMethod() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var femaleCollection = firestore.collection('female names');
    return femaleCollection;
  }

  CollectionReference boyMethod() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var maleCollection = firestore.collection('male names');
    return maleCollection;
  }

  customSnackBar(String warning, BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(warning)));
  }
}
