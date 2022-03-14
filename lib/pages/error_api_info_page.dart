import 'dart:ui';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/db/database.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/code.dart';
import '../models/error_api.dart';
import '../route/route_generator.dart';

class ErrorApiInfoPage extends StatefulWidget {
  ErrorApiInfoPage({Key key, @required this.data}) : super(key: key);
  ErrorApi data;

  @override
  State<ErrorApiInfoPage> createState() => _ErrorApiInfoPageState();
}

class _ErrorApiInfoPageState extends State<ErrorApiInfoPage> {
  Size size;
  bool _isLoading = false;
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _codeController = TextEditingController(text: '');
  TextEditingController _ipController = TextEditingController(text: '');
  TextEditingController _nameController = TextEditingController(text: '');
  String errorText = '';
  String url = '';
  String params = "";
  String response = "";
  DataBase db = DataBase();
  bool upDate;
  @override
  void initState() {
    super.initState();
    setState(() {
      _codeController.text = widget.data.code;
      _dateController.text = widget.data.date;
      _ipController.text = widget.data.ip;
      _nameController.text = widget.data.name;
      errorText = widget.data.error;
      url = widget.data.url;
      response = widget.data.response;
      params = widget.data.params;
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

  _loadingDataInfo() {
    setState(() {
      _isLoading = false;
    });
    db.initiliase();
    db.searchCode(widget.data.code).then((Code code) {
      setState(() {
        _isLoading = false;
      });
      if (code == null) {
        EasyLoading.showInfo("Is Empty");
      } else {
        Navigator.pushNamed(context, RouteGenerator.editCode, arguments: code);
      }
    });
  }

  _loadingDelete() async {
    db.initiliase();
    db.deleteErrorApi(widget.data.id).then((bool value) {
      if (value) {
        _showToast(context, 'Success');
        Navigator.pop(context, true);
      } else {
        _showToast(context, 'Error');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        title: const Text(
          'Error Api info page',
          style: TextStyle(
            fontFamily: "ComicNeue",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _loadingDataInfo();
              },
              icon: Icon(Icons.info_outline)),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: size.width,
              // height: size.height * 0.89,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    Hero(
                      tag: widget.data.id,
                      child: GestureDetector(
                        onLongPress: () {
                          _showDL("do you want to delete".toUpperCase(),
                              widget.data.id);
                        },
                        child: Container(
                          child: QrImage(
                            data: widget.data.id,
                            version: QrVersions.auto,
                            size: size.height * 0.2,
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
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldContainer(
                      controller: _codeController,
                      title: "Code",
                      enable: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldContainer(
                      controller: _dateController,
                      title: "Date",
                      enable: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldContainer(
                      keyboardType: TextInputType.number,
                      controller: _ipController,
                      title: "IP",
                      enable: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldContainer(
                      controller: _nameController,
                      title: "Name",
                      enable: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'URL',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontFamily: "ComicNeue",
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onLongPress: () async {
                        await FlutterClipboard.copy(widget.data.url);
                        EasyLoading.showToast(
                          "COPY",
                          toastPosition: EasyLoadingToastPosition.top,
                        );
                      },
                      child: Text(
                        url,
                        style: TextStyle(
                          color: Colors.red.shade100,
                          fontFamily: "ComicNeue",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: Colors.white12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'PARAMS',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontFamily: "ComicNeue",
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onLongPress: () async {
                        await FlutterClipboard.copy(widget.data.params);
                        EasyLoading.showToast(
                          "COPY",
                          toastPosition: EasyLoadingToastPosition.top,
                        );
                      },
                      child: Text(
                        params,
                        style: TextStyle(
                          color: Colors.red.shade100,
                          fontFamily: "ComicNeue",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: Colors.white12,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'RESPONSE',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontFamily: "ComicNeue",
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onLongPress: () async {
                        await FlutterClipboard.copy(widget.data.response);
                        EasyLoading.showToast(
                          "COPY",
                          toastPosition: EasyLoadingToastPosition.top,
                        );
                      },
                      child: Text(
                        response,
                        style: TextStyle(
                          color: Colors.red.shade100,
                          fontFamily: "ComicNeue",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: Colors.white12,
                    ),
                    Text(
                      'ERROR',
                      style: TextStyle(
                        color: Colors.red.shade300,
                        fontFamily: "ComicNeue",
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    InkWell(
                      onLongPress: () async {
                        await FlutterClipboard.copy(widget.data.error);
                        EasyLoading.showToast(
                          "COPY",
                          toastPosition: EasyLoadingToastPosition.top,
                        );
                      },
                      child: Text(
                        errorText,
                        style: TextStyle(
                          color: Colors.red.shade100,
                          fontFamily: "ComicNeue",
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: Colors.white12,
                    )
                  ]),
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
      ),
    );
  }

  _showDL(text, id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white70,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Container(
              // color: Colors.black38,
              width: size.width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // mainAxisSize: MainAxisSize.max,
                    children: [
                      // const Spacer(),
                      // const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                        color: Colors.black54,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: "ComicNeue",
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _loadingDelete();
                        Navigator.pop(context, true);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blueGrey.shade600,
                      ),
                      child: const Text(
                        "OK",
                        style: TextStyle(
                          fontFamily: "ComicNeue",
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}

class TextFieldContainer extends StatelessWidget {
  TextFieldContainer({
    Key key,
    @required this.controller,
    @required this.title,
    this.enable = true,
    this.keyboardType,
  }) : super(key: key);
  String title;
  TextEditingController controller;
  bool enable;
  TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white54,
              fontFamily: "ComicNeue",
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            enabled: enable,
            keyboardType: keyboardType,
            inputFormatters: [MyFormater()],
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 17,
              fontFamily: "ComicNeue",
            ),
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            ),
          ),
        ),
      ],
    );
  }
}

class MyFormater extends TextInputFormatter {
  static String defaultFormat(String text) {
    // Do whatever you want
    return text + '1';
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Your validations/formats
    // print("old value:" + oldValue.text);
    // print("new value:" + newValue.text);
    return null;
  }
}
