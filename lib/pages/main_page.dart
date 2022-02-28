import 'package:flutter/material.dart';
import 'package:math_crud/route/route_generator.dart';
import 'package:math_crud/service/notification.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Size size;
  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.streamCtrl.stream.listen(_changeData);
    firebaseMessaging.titlCtrl.stream.listen(_changeTitle);
    firebaseMessaging.bodyCtrl.stream.listen(_changeBody);

    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);
  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  _changeBody(String msg) => setState(() => notificationBody = msg);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          LinerContainer(
            text: "Controller",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButtonIconText(
                size: size,
                text: "All branch",
                icon: "assets/icons/list.png",
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.home);
                },
              ),
              MaterialButtonIconText(
                size: size,
                text: "Active",
                icon: "assets/icons/not_active.png",
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.active);
                },
              ),
              MaterialButtonIconText(
                size: size,
                text: "Scanner",
                icon: "assets/icons/qr.png",
                onPressed: () async {
                  Navigator.pushNamed(context, RouteGenerator.qrScan);
                  // Box box = await Hive.openBox('db');
                  // String token = await box.get('token');
                  // HttpJson httpJson = HttpJson();
                  // httpJson.sendPushMessage(
                  //     token: token, body: 'Message', title: 'Daaa nuuuuu');
                },
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButtonIconText(
                size: size,
                text: "Error",
                icon: "assets/icons/error.png",
                onPressed: () {
                  print("object");
                },
              ),
              MaterialButtonIconText(
                size: size,
                text: "Ads",
                icon: "assets/icons/ticket.png",
                onPressed: () {},
              ),
              MaterialButtonIconText(
                size: size,
                text: "Map",
                icon: "assets/icons/map.png",
                onPressed: () {},
              )
            ],
          ),
          const LinerContainer(
            text: "service",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButtonIconText(
                size: size,
                text: "Internet",
                icon: "assets/icons/internet.png",
                onPressed: () {
                  print("object");
                },
              ),
              MaterialButtonIconText(
                size: size,
                text: "News",
                icon: "assets/icons/new.png",
                onPressed: () {},
              ),
              MaterialButtonIconText(
                size: size,
                text: "Service",
                icon: "assets/icons/service.png",
                onPressed: () {},
              )
            ],
          ),
          const LinerContainer(
            text: "account",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButtonIconText(
                size: size,
                text: "Account",
                icon: "assets/icons/account.png",
                onPressed: () {
                  print("object");
                },
              ),
              MaterialButtonIconText(
                size: size,
                text: "Info",
                icon: "assets/icons/info.png",
                onPressed: () {},
              ),
              MaterialButtonIconText(
                size: size,
                text: "Settings",
                icon: "assets/icons/settings.png",
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }
}

class LinerContainer extends StatelessWidget {
  const LinerContainer({
    Key key,
    @required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 0.5,
          color: Colors.white10,
          margin: const EdgeInsets.symmetric(horizontal: 10),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(text.toUpperCase(),
            style: const TextStyle(
              color: Colors.white30,
              fontFamily: "ComicNeue",
              fontSize: 15,
            ))
      ],
    );
  }
}

class MaterialButtonIconText extends StatelessWidget {
  MaterialButtonIconText({
    Key key,
    @required this.size,
    @required this.onPressed,
    @required this.icon,
    @required this.text,
  }) : super(key: key);

  final Size size;
  Function onPressed;
  String icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            height: size.width * 0.2,
            width: size.width * 0.2,
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(20)),
            child: ImageIcon(
              AssetImage(icon),
              // size: 80,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "ComicNeue",
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
