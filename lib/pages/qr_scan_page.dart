import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:math_crud/db/database.dart';
import 'package:math_crud/route/route_generator.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../models/code.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Size size;
  bool _isLoading = false;
  DataBase db = DataBase();
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  _loadingDataDB(codeResult) async {
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(milliseconds: 1000));
    await db.initiliase();
    db.searchCode(codeResult).then((Code code) {
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

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(),
              Container(
                margin: const EdgeInsets.all(8),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey.shade600,
                    ),
                    onPressed: () async {
                      await controller?.flipCamera();
                      setState(() {});
                    },
                    child: FutureBuilder(
                      future: controller?.getCameraInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.data != null) {
                          return Text(
                            'Camera facing ${describeEnum(snapshot.data)}',
                            style: TextStyle(
                              fontFamily: "ComicNeue",
                            ),
                          );
                        } else {
                          return const Text('loading');
                        }
                      },
                    )),
              ),
              Container(
                height: size.height * 0.6,
                width: size.width * 0.9,
                child: _buildQrView(context),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                        'Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}',
                        style: const TextStyle(
                          fontFamily: "ComicNeue",
                          color: Colors.white,
                        ),
                      )
                    else
                      const Text(
                        'Scan a code',
                        style: TextStyle(
                          fontFamily: "ComicNeue",
                          color: Colors.white,
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    result == null
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await controller?.resumeCamera();
                                  setState(() {
                                    result = null;
                                  });
                                },
                                iconSize: 50,
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.white60,
                                ),
                                disabledColor: Colors.red,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              IconButton(
                                onPressed: () async {
                                  _loadingDataDB(result.code.toString());
                                },
                                iconSize: 50,
                                icon: Icon(
                                  Icons.info,
                                  color: Colors.white60,
                                ),
                                disabledColor: Colors.red,
                              ),
                            ],
                          )
                  ],
                ),
              )
            ],
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

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 15,
          borderLength: 40,
          borderWidth: 5,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      await controller?.pauseCamera();
      //
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
