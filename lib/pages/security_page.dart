import 'package:flutter/material.dart';

class SecurityPage extends StatefulWidget {
  const SecurityPage({Key? key}) : super(key: key);

  @override
  _SecurityPageState createState() => _SecurityPageState();
}

class _SecurityPageState extends State<SecurityPage> {
  late Size size;
  
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
                      children: const [
                        Text(
                          "Enter Code",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "ComicNeue",
                            fontSize: 30,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Key for existing password: 123463451",
                          style: TextStyle(
                            color: Colors.white38,
                            fontFamily: "ComicNeue",
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(),
                        Container(
                            padding: const EdgeInsets.all(6),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                            )),
                        Container(
                            padding: const EdgeInsets.all(6),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                            )),
                        Container(
                            padding: const EdgeInsets.all(6),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                            )),
                        Container(
                            padding: const EdgeInsets.all(6),
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white),
                            )),
                        const SizedBox(),
                      ],
                    )
                  ],
                )),
            AnimatedPositioned(
              bottom: 0,
              left: 0,
              right: 0,
              duration: const Duration(milliseconds: 600),
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
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "2",
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "3",
                                onPressed: (value) {},
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
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "5",
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "6",
                                onPressed: (value) {},
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
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "8",
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialNumberButton(
                                size: size,
                                text: "9",
                                onPressed: (value) {},
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
                                onPressed: (value) {},
                              ),
                            ),
                            Expanded(
                              child: MaterialIconButton(
                                size: size,
                                onPressed: () {},
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
                          onTap: () {},
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
            )
          ],
        ),
      ),
    );
  }
}

class MaterialNumberButton extends StatelessWidget {
  MaterialNumberButton(
      {Key? key,
      required this.size,
      required this.onPressed,
      required this.text})
      : super(key: key);

  final Size size;
  final String text;
  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: size.height * 0.08,
        height: size.height * 0.08,
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.black,
          borderRadius: BorderRadius.circular(5),
          onTap: text != ""
              ? () {
                  onPressed(text);
                }
              : null,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontSize: 35, fontFamily: "ComicNeue"),
            ),
          ),
        ),
      ),
    );
  }
}

class MaterialIconButton extends StatelessWidget {
  MaterialIconButton({
    Key? key,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  final Size size;

  Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        width: size.height * 0.08,
        height: size.height * 0.08,
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.black,
          borderRadius: BorderRadius.circular(5),
          onTap: () => onPressed,
          child: const Center(
            child: Icon(
              Icons.backspace_outlined,
              color: Colors.white60,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
