import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/route/route_generator.dart';

import '../db/database.dart';
import '../models/error_app.dart';

class ErrorAppPage extends StatefulWidget {
  const ErrorAppPage({Key key}) : super(key: key);

  @override
  State<ErrorAppPage> createState() => _ErrorAppPageState();
}

class _ErrorAppPageState extends State<ErrorAppPage> {
  Size size;
  bool _isLoading = false;
  DataBase db = DataBase();
  List<ErrorApp> resultError = [];
  @override
  void initState() {
    super.initState();
    _loadingErrors();
  }

  _loadingErrors() async {
    setState(() {
      _isLoading = true;
      resultError = [];
    });
    await Future.delayed(const Duration(milliseconds: 500));
    db.initializes();
    db.readErrorApp().then((List<ErrorApp> value) {
      setState(() {
        _isLoading = false;
        resultError = value;
      });
    });
  }

  _checkCheckOut() {
    bool checkOn = false;
    for (var item in resultError) {
      if (item.check) {
        checkOn = item.check;
        break;
      }
    }
    return checkOn;
  }

  _loadingDelete(id) async {
    db.initializes();
    db.deleteErrorApp(id).then((bool value) {
      if (value) {
        _showToast(context, 'Success');
      
      
      } else {
        _showToast(context, 'Error');
      }
    });
  }

  void _showToast(BuildContext context, text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        action: SnackBarAction(
            label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: !_checkCheckOut()
          ? null
          : FloatingActionButton(
              onPressed: () {
                for (var item in resultError) {
                  if (item.check) {
                    _loadingDelete(item.id);
                  }
                }
                _loadingErrors();
              },
              child: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              backgroundColor: Colors.white12,
            ),
      appBar: AppBar(
        title: Text(
          "Error App",
          style: StyleText(),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: RefreshIndicator(
              onRefresh: () async {
                await _loadingErrors();
              },
              child: ListView.builder(
                itemCount: resultError.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      height: size.height * 0.10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: !resultError[index].check
                            ? Colors.black54
                            : Colors.white12,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white10.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onLongPress: () {
                          setState(() {
                            resultError[index].check =
                                !resultError[index].check;
                          });
                        },
                        onTap: () {
                          if (_checkCheckOut()) {
                            setState(() {
                              resultError[index].check =
                                  !resultError[index].check;
                            });
                          } else {
                            Navigator.pushNamed(
                                    context, RouteGenerator.errorAppInfo,
                                    arguments: resultError[index])
                                .then((value) {
                              _loadingErrors();
                            });
                          }
                        },
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Error: ",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "ComicNeue",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(
                                child: Text(resultError[index].error,
                                    style: TextStyle(
                                      color: Colors.red.shade100,
                                      fontFamily: "ComicNeue",
                                      fontSize: 17,
                                      fontWeight: FontWeight.w400,
                                    )),
                              )
                            ]),
                      ));
                },
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
