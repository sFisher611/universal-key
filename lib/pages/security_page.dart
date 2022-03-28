import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:math_crud/models/password_position.dart';
import 'package:math_crud/route/route_generator.dart';
import 'package:math_crud/service/fuction_generator.dart';
import 'package:math_crud/widgets/material_icon_button.dart';
import 'package:math_crud/widgets/material_number_button.dart';
import 'package:math_crud/widgets/password_widget.dart';

import '../db/database.dart';
import '../models/admin.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key key}) : super(key: key);

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  Size size;
  bool _isAnim = false;
  PasswordPosition passwordPosition1 = PasswordPosition(text: "", active: true);
  PasswordPosition passwordPosition2 =
      PasswordPosition(text: "", active: false);
  PasswordPosition passwordPosition3 =
      PasswordPosition(text: "", active: false);
  PasswordPosition passwordPosition4 =
      PasswordPosition(text: "", active: false);
  bool _isLoading = false;
  String key = '';
  bool notActive = false;
  @override
  void initState() {
    super.initState();
    _startAnimation();
    _loadingKeyAdmin();

    setState(() {
      key = FunctionGenerator.generatorKey();
    });
  }

  _loadingKeyAdmin() async {
    Box box = await Hive.openBox('base');
    var admin = await box.get('admin');

    if (admin != null) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 2000));

      setState(() {
        _isLoading = false;
      });
      try {
        String token = await box.get("token");
        DataBase db = DataBase();
        db.initializes();
        db.searchAdmin(token).then((Admin adminResult) {
          if (adminResult.active) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                RouteGenerator.main, (Route<dynamic> route) => false);
          } else {
            notActive = true;
            EasyLoading.showInfo("Not active!!!");
          }
        });
      } catch (_) {}
    }
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      _isAnim = true;
    });
  }

  void _checkPassword() async {
    if (!notActive) {
      setState(() {
        _isLoading = true;
      });
      await Future.delayed(const Duration(milliseconds: 2000));
      setState(() {
        _isLoading = false;
      });
      String text = passwordPosition1.text +
          passwordPosition2.text +
          passwordPosition3.text +
          passwordPosition4.text;
      if (FunctionGenerator.generatorCheck(text, key.toString())) {
        notActive = true;
        Box box = await Hive.openBox('base');
        String token = await box.get("token");
        if (token != null) {
          loadingAdminUser(token);
        }
      } else {
        EasyLoading.showError('');
      }
    } else {
      EasyLoading.showInfo("You can't do that!");
    }
  }

  loadingAdminUser(token) async {
    if (token != null) {
      DataBase db = DataBase();
      Admin admin = Admin(name: 'user', token: token);
      await db.initializes();
      db.searchAdmin(token).then((Admin adminResult) async {
        if (adminResult == null) {
          await db.createAdmin(admin);
          EasyLoading.showSuccess("OK");
          Box box = await Hive.openBox('base');
          await box.put("admin", '1');
        }
      });
    }
  }

  void _passwordWrite(text) {
    if (passwordPosition1.active) {
      setState(() {
        passwordPosition1.active = false;
        passwordPosition1.text = text;
        passwordPosition2.active = true;
      });
    } else if (passwordPosition2.active) {
      setState(() {
        passwordPosition2.active = false;
        passwordPosition2.text = text;
        passwordPosition3.active = true;
      });
    } else if (passwordPosition3.active) {
      setState(() {
        passwordPosition3.active = false;
        passwordPosition3.text = text;
        passwordPosition4.active = true;
      });
    } else if (passwordPosition4.active) {
      setState(() {
        passwordPosition4.active = false;
        passwordPosition4.text = text;
      });
    } else {
      //_checkPasword()
    }
  }

  void passwordDelete() {
    if (passwordPosition1.active) {
    } else if (passwordPosition2.active) {
      setState(() {
        passwordPosition2.active = false;
        passwordPosition1.text = '';
        passwordPosition1.active = true;
      });
    } else if (passwordPosition3.active) {
      setState(() {
        passwordPosition3.active = false;
        passwordPosition2.text = '';
        passwordPosition2.active = true;
      });
    } else if (passwordPosition4.active) {
      setState(() {
        passwordPosition4.active = false;
        passwordPosition3.text = '';
        passwordPosition3.active = true;
      });
    } else {
      setState(() {
        passwordPosition4.active = true;
        passwordPosition4.text = '';
      });
    }
  }

  _passwordClear() {
    setState(() {
      passwordPosition1.text = "";
      passwordPosition2.text = "";
      passwordPosition3.text = "";
      passwordPosition4.text = "";
      passwordPosition1.active = true;
      passwordPosition2.active = false;
      passwordPosition3.active = false;
      passwordPosition4.active = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            SizedBox(
                height: size.height * 0.45,
                // color: Colors.red,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedTextKit(
                            animatedTexts: [
                              TypewriterAnimatedText(
                                "Enter Code",
                                speed: const Duration(milliseconds: 200),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontFamily: "ComicNeue",
                                  fontSize: 30,
                                ),
                              ),
                            ],
                            totalRepeatCount: 1,
                            isRepeatingAnimation: true,
                            repeatForever: false,
                            displayFullTextOnTap: true,
                            stopPauseOnTap: true),
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedTextKit(
                          animatedTexts: [
                            TypewriterAnimatedText(
                              "Key for existing password: " + key,
                              textStyle: const TextStyle(
                                color: Colors.white38,
                                fontFamily: "ComicNeue",
                                fontSize: 12,
                              ),
                            ),
                          ],
                          totalRepeatCount: 1,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(),
                        AnimatedOpacity(
                            duration: const Duration(seconds: 2),
                            opacity: _isAnim ? 1.0 : 0.0,
                            child: PasswordWidget(
                              passwordPosition: passwordPosition1,
                            )),
                        AnimatedOpacity(
                            duration: const Duration(seconds: 3),
                            opacity: _isAnim ? 1.0 : 0.0,
                            child: PasswordWidget(
                                passwordPosition: passwordPosition2)),
                        AnimatedOpacity(
                            duration: const Duration(seconds: 4),
                            opacity: _isAnim ? 1.0 : 0.0,
                            child: PasswordWidget(
                                passwordPosition: passwordPosition3)),
                        AnimatedOpacity(
                            duration: const Duration(seconds: 5),
                            opacity: _isAnim ? 1.0 : 0.0,
                            child: PasswordWidget(
                                passwordPosition: passwordPosition4)),
                        const SizedBox(),
                      ],
                    )
                  ],
                )),
            AnimatedPositioned(
              bottom: _isAnim ? 0 : -1000,
              left: 0,
              right: 0,
              curve: Curves.linear,
              duration: const Duration(milliseconds: 1000),
              child: Container(
                height: size.height * 0.53,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "1",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "2",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "3",
                                onPressed: _passwordWrite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "4",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "5",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "6",
                                onPressed: _passwordWrite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "7",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "8",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "9",
                                onPressed: _passwordWrite,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "",
                                onPressed: () {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "0",
                                onPressed: _passwordWrite,
                              ),
                            ),
                            Expanded(
                              child: MaterialIconButton(
                                size: size,
                                onPressed: () {
                                  passwordDelete();
                                },
                                onLongPress: () {
                                  _passwordClear();
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(15)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.black,
                          highlightColor: Colors.black,
                          borderRadius: BorderRadius.circular(15),
                          onTap: () {
                            if (passwordPosition1.text.isNotEmpty &&
                                passwordPosition2.text.isNotEmpty &&
                                passwordPosition3.text.isNotEmpty &&
                                passwordPosition4.text.isNotEmpty) {
                              _checkPassword();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                'RESEND CODE',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "ComicNeue",
                                  color: Colors.white,
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
