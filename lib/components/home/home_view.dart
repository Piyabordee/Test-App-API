import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:testapi/components/home/view_h.dart';
import 'package:testapi/components/home/view_v.dart';
import 'package:testapi/components/constants/string_web.dart';
import 'package:testapi/components/web_api/blacklist_api.dart';
import 'package:testapi/components/web_api/cat_api.dart';
import 'package:testapi/components/web_api/geo_location.dart';
import 'package:testapi/components/web_api/weather_api.dart';
import 'package:testapi/components/web_view/web_view.dart';

class Home_View extends StatefulWidget {
  const Home_View({super.key});

  @override
  State<Home_View> createState() => _Home_ViewState();
}

class _Home_ViewState extends State<Home_View> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          //แนวนอน
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Text(
                  "เว็บแนะนำ",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(IconlyBroken.more_square),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => View_H(),
                      ),
                    )
                  },
                )
              ],
            ),
          ),
          //เนื้อหาเลื่อนแนวนอน
          Container(
            height: 200, // ความสูง
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // แนวนอน
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start, // แนวตั้ง
                mainAxisAlignment: MainAxisAlignment.start, // ด้านบน
                children: [
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.web_flutter,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/flutter.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Flutter",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.web_site,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/app.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "WebSite",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.facebook,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/facebook.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Facebook",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.line,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/line.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Line",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.green),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.tiktok,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/tiktok.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Tiktok",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Web_View(
                            web: Strings.youtube,
                          ),
                        ),
                      )
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset(
                            "./android/assets/image/youtube.png",
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Youtube",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.red),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //แนวตั้ง
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Text(
                  "แนวตั้ง",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontFamily: "Alike",
                      fontWeight: FontWeight.w500),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(IconlyBroken.more_square),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => View_V(),
                      ),
                    )
                  },
                )
              ],
            ),
          ),
          //เนื้อหาเลื่อนแนวตั้ง
          Expanded(
            // ใช้ Expanded ครอบ SingleChildScrollView เพื่อให้เลื่อนได้
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical, // แนวตั้ง
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // แนวตั้ง
                mainAxisAlignment: MainAxisAlignment.start, // ด้านบน
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Cat_Api(), //เพื่อเรียกใช้งาน Cat_Api
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity, // กำหนดความกว้างเต็ม
                      height: 200,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn2.thedogapi.com/images/SJIUQl9NX_1280.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Cat & Dog",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black.withAlpha(70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Geo_Location(), //เพื่อเรียกใช้งาน Geo_Location
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity, // กำหนดความกว้างเต็ม
                      height: 200,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn2.thedogapi.com/images/s4h8tS2SU.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Geo_Location",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black.withAlpha(70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Weather
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeatherApi(), //เพื่อเรียกใช้งาน Geo_Location
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity, // กำหนดความกว้างเต็ม
                      height: 200,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn2.thedogapi.com/images/1ky29d0rC.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Weather",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black.withAlpha(70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Blacklist_API(), //เพื่อเรียกใช้งาน Geo_Location
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity, // กำหนดความกว้างเต็ม
                      height: 200,
                      margin: EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withAlpha(150),
                              offset: Offset(0, 4),
                              blurRadius: 8)
                        ],
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://cdn2.thedogapi.com/images/ZRQ0TYzz6.jpg",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Center(
                            child: Text(
                              "API ตรวจสอบรายชื่อ black list",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  backgroundColor: Colors.black.withAlpha(70)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
