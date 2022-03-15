import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../db/database.dart';
import '../models/code.dart';

class MessageSendingPage extends StatefulWidget {
  const MessageSendingPage({Key key}) : super(key: key);

  @override
  State<MessageSendingPage> createState() => _MessageSendingPageState();
}

class _MessageSendingPageState extends State<MessageSendingPage> {
  Size size;
  bool _isLoading = false;
  DataBase db = DataBase();
  List<Code> resuActiveList = [];
  @override
  void initState() {
    super.initState();
    _loadingActive();
  }

  _loadingActive() async {
    setState(() {
      _isLoading = true;
      resuActiveList = [];
    });
    await Future.delayed(const Duration(milliseconds: 500));
    db.initiliase();
    db.readNotActive(true).then((List<Code> value) {
      setState(() {
        _isLoading = false;
        resuActiveList = value;
      });
    });
  }

  _checkCheckOut() {
    bool checkOn = false;
    for (var item in resuActiveList) {
      if (item.check) {
        checkOn = item.check;
        break;
      }
    }
    return checkOn;
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
              onPressed: () {},
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
                await _loadingActive();
              },
              child: ListView.builder(
                itemCount: resuActiveList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      height: size.height * 0.10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: !resuActiveList[index].check
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
                            resuActiveList[index].check =
                                !resuActiveList[index].check;
                          });
                        },
                        onTap: () {
                          if (_checkCheckOut()) {
                            setState(() {
                              resuActiveList[index].check =
                                  !resuActiveList[index].check;
                            });
                          } else {}
                        },
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: []),
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
