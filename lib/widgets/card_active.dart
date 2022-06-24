import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/code.dart';

class CardActive extends StatelessWidget {
  CardActive(
      {Key key,
      @required this.resuList,
      @required this.size,
      @required this.index,
      @required this.onPressed})
      : super(key: key);

  final List<Code> resuList;
  final Size size;
  final int index;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            resuList.isEmpty
                ? Container()
                : Hero(
                    tag: resuList[index].id,
                    child: Container(
                      child: QrImage(
                        data: resuList[index].id,
                        version: QrVersions.auto,
                        size: size.height * 0.1,
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
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    resuList[index].name ,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "ComicNeue",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "branch: ",
                        style: TextStyle(
                          color: Colors.white60,
                          fontFamily: "ComicNeue",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        resuList[index].branchId == ""
                            ? ""
                            : resuList[index].branchId.substring(
                                resuList[index].branchId.indexOf(":") + 1,
                                resuList[index].branchId.length),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: "ComicNeue",
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
