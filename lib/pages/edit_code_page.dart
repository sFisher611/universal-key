import 'dart:ui';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/db/database.dart';
import 'package:math_crud/models/code.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EditCodePage extends StatefulWidget {
  EditCodePage({Key key, @required this.data}) : super(key: key);
  Code data;

  @override
  State<EditCodePage> createState() => _EditCodePageState();
}

class _EditCodePageState extends State<EditCodePage> {
  Size size;
  bool _isLoading = false;
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _codeController = TextEditingController(text: '');
  TextEditingController _ipController = TextEditingController(text: '');
  TextEditingController _nameController = TextEditingController(text: '');
  bool status = false;
  DataBase db = DataBase();
  bool upDate = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      _codeController.text = widget.data.code;
      _dateController.text = widget.data.date;
      _ipController.text = widget.data.ip;
      _nameController.text = widget.data.name;
      status = widget.data.active;
    });
  }

  _loadingUpdate() async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    Code _code = Code(
        id: widget.data.id,
        date: widget.data.date,
        name: _nameController.text,
        ip: _ipController.text,
        active: status);
    db.initiliase();
    db.update(_code).then((bool value) {
      setState(() {
        _isLoading = false;
        upDate = true;
      });
      if (value) {
        _showToast(context, 'Success');
        Navigator.pop(context, upDate);
      } else {
        _showToast(context, 'Error');
      }
    });
  }

  _loadingDelete(id) async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    db.initiliase();
    db.delete(id).then((bool value) {
      if (value) {
        _showToast(context, 'Success');
        Navigator.pop(context, true);
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white10,
        title: const Text(
          'Service page',
          style: TextStyle(
            fontFamily: "ComicNeue",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context, upDate);
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10),
              width: size.width,
              height: size.height * 0.89,
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
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldContainer(
                      controller: _nameController,
                      title: "Name",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomSwitch(
                      activeColor: Colors.red.shade200,
                      value: status,
                      onChanged: (value) {
                        setState(() {
                          status = value;
                        });
                      },
                    ),
                  ]),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade500,
                        borderRadius: BorderRadius.circular(10)),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          _loadingUpdate();
                        },
                        child: const SizedBox(
                          height: 60,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Update",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontFamily: "ComicNeue",
                                fontWeight: FontWeight.w500),
                          )),
                        ),
                      ),
                    ),
                  )
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
                        Navigator.pop(context, true);
                        _loadingDelete(id);
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
