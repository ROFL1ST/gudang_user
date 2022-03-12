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
  TextEditingController tanggalMulai = TextEditingController();
  TextEditingController tanggalBerakhir = TextEditingController();
  String name = "";
  String _selectedItem = '';
  String hapus = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WareHouse App For Users", style: TextStyle(fontSize: 23),)  
        ),
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
                icon: Icon(Icons.search, size: 34),
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
            height: 250,
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
        ListTile(
          leading: Icon(Icons.date_range),
          title: Row(
            children: [
              Container(
                width: 100,
                height: 50,
                child: TextField(
                  controller: tanggalMulai,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Mulai",
                    labelText: "Tanggal mulai",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Text("Sampai"),
              SizedBox(
                width: 20,
              ),
              Container(
                width: 100,
                height: 50,
                child: TextField(
                  controller: tanggalBerakhir,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: "Berakhir",
                    labelText: "Tanggal Berakhir",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(.5),
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.5),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 20.0),
                height: 40,
                width: 90,
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  shadowColor: kPrimaryColor.withOpacity(0.5),
                  color: kPrimaryColor,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedItem = "tgl_custom";
                      });
                    },
                    child: Center(
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          onTap: () => _selectItem('tgl_masuk'),
        ),
        Container(
          padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 20.0),
          height: 50,
          width: 200,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            shadowColor: kPrimaryColor.withOpacity(0.5),
            color: kPrimaryColor,
            elevation: 7.0,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  name = "";
                  _selectedItem = "";
                });
              },
              child: Center(
                child: Text(
                  "Hapus Sort",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
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
