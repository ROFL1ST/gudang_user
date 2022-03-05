// ignore_for_file: prefer_const_constructors, file_names, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({Key? key}) : super(key: key);

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home User"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Cari Barang....",
                  hintStyle: TextStyle(fontSize: 20),
                  icon: Icon(Icons.search),
                  
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 40),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://th.bing.com/th/id/OIP.0Z6SOXkFUa3WfktnzoQq_AHaEo?pid=ImgDet&rs=1"),
                        SizedBox(height: 15),
                        Text(
                          "Nama Barang : Traktor",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stok Barang : 14",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal Masuk : 25 feb 2022",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://www.static-src.com/wcsstore/Indraprastha/images/catalog/full/97/MTA-5249662/sj_aluminium_tangga_lipat_aluminium_sahara_2_meter_-_200_cm_full03_ftbszdln.jpg"),
                        SizedBox(height: 15),
                        Text(
                          "Nama Barang : tangga",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stok Barang : 34",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal Masuk : 05 feb 2022",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://s1.bukalapak.com/img/6433714711/w-1000/meja_kayu_jati_belanda.jpg"),
                        SizedBox(height: 15),
                        Text(
                          "Nama Barang : meja kayu",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stok Barang : 03",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal Masuk : 07 jan 2022",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://dekorasirumahjati.com/wp-content/uploads/2020/09/rak-buku-6.jpg"),
                        SizedBox(height: 15),
                        Text(
                          "Nama Barang : rak buku",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stok Barang : 43",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal Masuk : 15 feb 2022",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(height: 20,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                            "https://th.bing.com/th/id/OIP.yNjvr4FMDQyP122tYnrpOwHaHk?pid=ImgDet&rs=1"),
                        SizedBox(height: 15),
                        Text(
                          "Nama Barang : Treadmill",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Stok Barang : 19",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Tanggal Masuk : 19 jan 2022",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,)
                ],
              ),
            ]),
          ),
        ),floatingActionButton: FloatingActionButton(
          onPressed: () {},
        child: Icon(Icons.more_horiz_rounded)
        ),);
  }
}
