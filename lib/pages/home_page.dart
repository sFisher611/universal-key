import 'package:flutter/material.dart';
import 'package:math_crud/db/database.dart';

import 'package:qr_flutter/qr_flutter.dart';

import '../models/code.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBase db = DataBase();
  Size size;
  List resuList = [];
  @override
  void initState() {
    super.initState();
    _dataBase();
  }

  _dataBase() async {
    db.initiliase();
    // for (int i = 0; i < 10; i++) {
    //   Code code = Code(
    //       code: '3562$i', name: "Fargon$i", active: true, date: "", ip: '');
    //   db.creat(code);
    // }

    db.read().then((value) {
      setState(() {
        resuList = value;
      });

      // for (var item in value) {
      //   db.delete(item['id']);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Branch",
          style: StyleText(),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Container(
        color: Colors.black,
        child: ListView.builder(
          itemCount: resuList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: size.height * 0.15,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white10.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  QrImage(
                    data: resuList[index].id,
                    version: QrVersions.auto,
                    size: size.height * 0.11,
                    eyeStyle: const QrEyeStyle(
                      eyeShape: QrEyeShape.square,
                      color: Colors.black,
                    ),
                    dataModuleStyle: const QrDataModuleStyle(
                      dataModuleShape: QrDataModuleShape.circle,
                      color: Colors.black,
                    ),
                    gapless: false,
                    padding: const EdgeInsets.all(5),
                    backgroundColor: Colors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "code: ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "ComicNeue",
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            resuList[index].code,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ComicNeue",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Name: ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "ComicNeue",
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            resuList[index].name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ComicNeue",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "IP: ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "ComicNeue",
                              fontSize: 12,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.55,
                            child: Text(
                              resuList[index].ip,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: "ComicNeue",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Date: ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "ComicNeue",
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            resuList[index].date,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ComicNeue",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            "Active: ",
                            style: TextStyle(
                              color: Colors.white60,
                              fontFamily: "ComicNeue",
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            resuList[index].active.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "ComicNeue",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  TextStyle StyleText() {
    return const TextStyle(
      color: Colors.white,
      fontFamily: "ComicNeue",
      // fontSize: 30,
    );
  }
}
