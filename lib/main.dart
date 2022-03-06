// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
// import 'package:gudang_apk/homeAdmin.dart';
import 'package:gudang_apk/homeUser.dart';
// import 'package:gudang_apk/homeUser.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gudang App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.amber,
      ),
      home: HomeUser()
    );
  }
}
