import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:http/http.dart' as http;

class Blacklist_API extends StatefulWidget {
  const Blacklist_API({super.key});

  @override
  State<Blacklist_API> createState() => _Blacklist_APIState();
}

List _user = [];
List _userblacklist = [];
List selectedUsers = [];

bool _isLoading =
    true; // สร้างตัวแปร _isLoading แบบ boolean และกำหนดค่าเริ่มต้นเป็น true
String _ErrorMessage = ""; // สร้างตัวแปร _ErrorMessage แบบ String

var client = http.Client(); // สร้างตัวแปร client แบบ http.Client

class _Blacklist_APIState extends State<Blacklist_API> {
  @override
  void initState() {
    super.initState();
    _fetchUserWhitelistData(); // เรียกใช้งานฟังก์ชัน _fetchUserWhitelistData
    // _fetchUserBlacklistData();
  }

  Future<void> _fetchUserWhitelistData() async {
    // ส่วนของการเรียกใช้งาน API
    var client = http.Client(); // สร้างตัวแปร client แบบ http.Client

    try {
      final response = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"),
        //  ส่งค่าขอ api
      );
      final responseblacklist = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users/2"),
        //  ส่งค่าขอ api
      );
      if (response.statusCode == 200 || responseblacklist.statusCode == 200) {
        final data = json.decode(response
            .body); // แปลงข้อมูล response.body ให้เป็น json และเก็บไว้ใน data
        final datablacklist = json.decode(responseblacklist
            .body); // แปลงข้อมูล response.body ให้เป็น json และเก็บไว้ใน data
        setState(
          () {
            _user = data.map((userwhitelist) => userwhitelist['name']).toList();

            List selectedUsers = data
                .where((user) => user['id'] == 3 || user['id'] == 5)
                .map((user) => user['name'] as String)
                .toList();

            print(selectedUsers); // ['Clementine Bauch', 'Chelsey Dietrich']

            _isLoading = false; // กำหนดค่า _isLoading เป็น false
          },
        );
      } else {
        setState(
          () {
            _ErrorMessage =
                "Error: ${response.statusCode}"; // ถ้าไม่ใช่ 200 ให้เก็บข้อความ Error: ${response.statusCode} ไว้ใน _ErrorMessage
            _showAlertDialog(context, "ข้อผิดพลาด", _ErrorMessage);
          },
        );
      }
    } catch (e) {
      setState(
        () {
          _showAlertDialog(
              context, "ข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับ API ได้ ($e)");
          print(e);
        },
      );
    }
  }

  // Future<void> _fetchUserBlacklistData() async {
  //   // ส่วนของการเรียกใช้งาน API ของ OpenWeatherMap
  //   var client = http.Client(); // สร้างตัวแปร client แบบ http.Client

  //   try {
  //     final response = await client.get(
  //       Uri.parse("https://jsonplaceholder.typicode.com/users/2"),
  //       //  ส่งค่าขอ api ของ OpenWeatherMap
  //     );
  //     if (response.statusCode == 200) {
  //       final data = json.decode(response
  //           .body); // แปลงข้อมูล response.body ให้เป็น json และเก็บไว้ใน data

  //       setState(
  //         () {
  //           final String _userblacklist = data['name'];
  //           _isLoading = false; // กำหนดค่า _isLoading เป็น false
  //           // print(); // Ervin Howell
  //         },
  //       );
  //     } else {
  //       setState(
  //         () {
  //           _ErrorMessage =
  //               "Error: ${response.statusCode}"; // ถ้าไม่ใช่ 200 ให้เก็บข้อความ Error: ${response.statusCode} ไว้ใน _ErrorMessage
  //           _showAlertDialog(context, "ข้อผิดพลาด", _ErrorMessage);
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     setState(
  //       () {
  //         _showAlertDialog(
  //             context, "ข้อผิดพลาด", "ไม่สามารถเชื่อมต่อกับ API ได้ ($e)");
  //       },
  //     );
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40, // กำหนดความสูงของ AppBar
        leading: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(IconlyLight.arrow_left_square),
        ),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Blacklist API Name Check",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
                TextField(
                  decoration:
                      InputDecoration(labelText: "กรอกรายชื่อที่ต้องการตรวจ"),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "ตรวจสอบ",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    // กำหนดรูปร่างของ Card
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  color: Colors.lightGreenAccent.withOpacity(0.7),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("รายชื่อทั้งหมด $_user และ ${selectedUsers}"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.red,
                fontFamily: "Alike",
                fontWeight: FontWeight.w500),
          ),
          content: Text(message),
          actions: <Widget>[
            Row(
              children: [
                Spacer(),
                ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(
                      "ตกลง",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Alike",
                          color: Colors.green,
                          fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
