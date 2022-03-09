// ignore_for_file: unused_import, camel_case_types, non_constant_identifier_names, unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Firebase_service {
  late String value;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference products = firestore.collection("products");

    return products.snapshots();
  }

  FilterData(String searchField) async {
    final result = await firestore
        .collection("barang")
        .where("nama_barang",
            isGreaterThanOrEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
