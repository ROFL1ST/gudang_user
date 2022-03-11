// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gudang_apk/api/firebase_service.dart';
import 'package:gudang_apk/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  String name = "";
  String _selectedItem = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WareHouse App For Users")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 15, 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                icon: Icon(Icons.search , size: 34),
                hintText: "Cari Barang....",
                hintStyle: TextStyle(fontSize: 15),
              ),
              onChanged: (val) => initiateSearch(val),
            ),
            Column(
              children: [
                SizedBox(height: 40),
                StreamBuilder<QuerySnapshot<Object?>>(
                  stream: (_selectedItem == "tgl_masuk")
                      ? FirebaseFirestore.instance
                          .collection('products')
                          .orderBy("tgl_masuk")
                          .snapshots()
                      : (_selectedItem == "stock")
                          ? FirebaseFirestore.instance
                              .collection('products')
                              .orderBy("stock")
                              .snapshots()
                          : (name != "" && name != null)
                              ? FirebaseFirestore.instance
                                  .collection('products')
                                  .where("nama_barang", isEqualTo: name)
                                  .snapshots()
                              : Firebase_service().streamData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      var listAllData = snapshot.data!.docs;
                      return Container(
                        height: 680,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listAllData.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data = listAllData[index]
                                .data()! as Map<String, dynamic>;

                            return Container(
                              margin: EdgeInsets.fromLTRB(4, 5, 4, 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                              ),
                              padding: EdgeInsets.only(top: 20, bottom: 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image.network(
                                    data["gambar"],
                                    height: 250,
                                    width: 250,
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          " ${data["nama_barang"]}",
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          " Stock: ${data["stock"]}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        Text(
                                          " ${DateFormat.yMMMEd().format(data["tgl_masuk"].toDate())}",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.italic),
                                        ),
                                        SizedBox(height: 30)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _onButtonPressed(),
          child: Icon(Icons.more_horiz_rounded)),
    );
  }

  void _onButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child: Container(
              child: _buildBottomNavigationMenu(),
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(10),
                  topRight: const Radius.circular(10),
                ),
              ),
            ),
          );
        });
  }

  Column _buildBottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.sort_rounded),
          title: Text('Terendah - tertinggi'),
          onTap: () => _selectItem('stock'),
        ),
        ListTile(
          leading: Icon(Icons.date_range),
          title: Text('Tanggal masuk'),
          onTap: () => _selectItem('tgl_masuk'),
        ),
      ],
    );
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.toLowerCase().trim();
    });
  }
}
