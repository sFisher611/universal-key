import 'package:flutter/material.dart';
import 'package:math_crud/db/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataBase db = DataBase();
  var resuList = [];
  @override
  void initState() {
    super.initState();
    _dataBase();
  }

  _dataBase() async {
    db.initiliase();
    // for (int i = 0; i < 100; i++) {
    //   db.creat('Forma$i', '$i');
    // }

    db.read().then((value) {
      setState(() {
        resuList = value;
      });
      // for (var item in resuList) {
      //     db.delete(item['id']);
      //   }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test_base"),
      ),
      body: ListView.builder(
        itemCount: resuList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(resuList[index]['name']),
            subtitle: Text(resuList[index]['id']),
            // leading: Text(resuList[index]['date'].toString()),
            trailing: Icon(Icons.delete),
            onTap: () async {
              await db.delete(resuList[index]['id']);
            },
          );
        },
      ),
    );
  }
}
