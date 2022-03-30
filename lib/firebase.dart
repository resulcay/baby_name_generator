import 'package:cloud_firestore/cloud_firestore.dart';

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
