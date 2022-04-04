import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../db/database.dart';
import '../models/code.dart';
import '../route/route_generator.dart';
import '../widgets/text_field_container.dart';

class ActiveSearchPage extends StatefulWidget {
  const ActiveSearchPage({Key key}) : super(key: key);

  @override
  State<ActiveSearchPage> createState() => _ActiveSearchPageState();
}

class _ActiveSearchPageState extends State<ActiveSearchPage> {
  TextEditingController search = TextEditingController();
  Size size;
  bool _isLoading = false;
  DataBase db = DataBase();

  _loadingDataDB(codeResult) async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    await db.initializes();
    db.searchCode(codeResult).then((Code code) {
      setState(() {
        _isLoading = false;
      });
      if (code == null) {
        EasyLoading.showInfo("Is Empty");
      } else {
        Navigator.pushNamed(context, RouteGenerator.editCode, arguments: code)
            .then((value) async {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFieldContainer(
                            onSubmitted: (value) {
                              _loadingDataDB(search.text);
                              FocusScope.of(context).unfocus();
                            },
                            controller: search,
                            title: "Search",
                            enable: true,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _loadingDataDB(search.text);
                            FocusScope.of(context).unfocus();
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            margin: const EdgeInsets.only(right: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            height: 50,
                            // width: 80,
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.search),
                          ),
                        )
                      ],
                    ),
                    // SizedBox(
                    //   height: size.height * 0.8,
                    //   child: ListView.builder(
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return ListTile(
                    //         title: Text(
                    //           "1234234",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //         subtitle: Text(
                    //           "passiv",
                    //           style: TextStyle(color: Colors.white54),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: !_isLoading,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                  child: const Center(
                      child: SpinKitSquareCircle(
                    color: Colors.white,
                    size: 100.0,
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
