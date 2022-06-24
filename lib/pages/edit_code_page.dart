import 'dart:ui';

import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/db/database.dart';
import 'package:math_crud/models/code.dart';
import 'package:math_crud/models/universal.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../service/http_json.dart';
import '../widgets/text_field_container.dart';
import '../widgets/type_ahead_field_autocomplete.dart';

class EditCodePage extends StatefulWidget {
  EditCodePage({Key key, @required this.data}) : super(key: key);
  Code data;

  @override
  State<EditCodePage> createState() => _EditCodePageState();
}

class _EditCodePageState extends State<EditCodePage> {
  Size size;
  bool _isLoading = false;
  List<UniversalModel> listBranch = [];
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _codeController = TextEditingController(text: '');
  TextEditingController _ipController = TextEditingController(text: '');
  TextEditingController _nameController = TextEditingController(text: '');
  TextEditingController _branchController = TextEditingController(text: '');
  UniversalModel selectBranch = UniversalModel(id: "0", name: '');
  bool status = false;
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

      status = widget.data.active;
      if (widget.data.branchId != '') {
        String branch = widget.data.branchId;
        selectBranch = UniversalModel(
            id: branch.substring(0, branch.indexOf(":")),
            name: branch.substring(branch.indexOf(":") + 1, branch.length));
        _branchController.text =
            branch.substring(branch.indexOf(":") + 1, branch.length);
      }
    });
    _loadingBranchs();
  }

  _loadingBranchs() async {
    setState(() {
      _isLoading = true;
    });
    db.initializes();
    db.readBranch().then((List<UniversalModel> value) {
      setState(() {
        listBranch.addAll(value);
      });
      setState(() {
        _isLoading = false;
      });
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
      active: status,
      branchId: "${selectBranch.id}:${selectBranch.name}",
    );
    db.initializes();
    db.update(_code).then((bool value) async {
      setState(() {
        _isLoading = false;
        upDate = true;
      });
      if (value) {
        _showToast(context, 'Success');
        HttpJson httpJson = HttpJson();
        httpJson.sendPushMessage(
            token: widget.data.token,
            body: 'Xabar',
            title:
                _code.active ? "Aktivlashdi!" : "Sizning aktivligingiz o'chdi");
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
    db.initializes();
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
                      controller: _nameController,
                      title: "Name",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Branch",
                            style: TextStyle(
                              color: Colors.white54,
                              fontFamily: "ComicNeue",
                            ),
                          ),
                        ),
                        TypeAheadFieldAutocomplete(
                          controller: _branchController,
                          list: listBranch,
                          onSelected: (value) {
                            selectBranch = value;
                            setState(() {
                              _branchController.text = value.name;
                            });
                          },
                        ),
                      ],
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


