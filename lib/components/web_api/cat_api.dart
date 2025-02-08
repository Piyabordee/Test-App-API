import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import 'package:testapi/components/constants/string_web.dart';

class Cat_Api extends StatefulWidget {
  const Cat_Api({super.key});

  @override
  State<Cat_Api> createState() => _Cat_ApiState();
}

class _Cat_ApiState extends State<Cat_Api> {
  List<dynamic> _cat = []; // สร้างตัวแปร cat แบบ List ที่เป็น dynamic
  String _ErrorMessage = ""; //

  @override
  void initState() {
    super.initState();
    _fetchCat(); //เรียกใช้งานฟังก์ชัน _fetchCat
  }

  Future<void> _fetchCat() async {
    var client = http.Client(); // สร้างตัวแปร client แบบ http.Client

    try {
      // ใช้ try และ catch เพื่อจัดการข้อผิดพลาด
      final response = await client.get(
        Uri.parse(Strings.cat),
      ); // สร้างตัวแปร response และเรียกใช้งาน client.get โดยใช้ Uri.parse และ Strings.cat

      if (response.statusCode == 200) {
        // ถ้า response.statusCode เท่ากับ 200
        setState(() {
          _cat = json.decode(response
              .body); // แปลงข้อมูล response.body ให้เป็น json และเก็บไว้ใน _cat
        });
      } else {
        // ถ้าไม่ใช่ 200
        _ErrorMessage =
            "Error: ${response.statusCode}"; // ถ้าไม่ใช่ 200 ให้เก็บข้อความ Error: ${response.statusCode} ไว้ใน _ErrorMessage
        _showAlertDialog(context, "ข้อผิดพลาด", _ErrorMessage);
      }
    } catch (e) {
      // ถ้าเกิดข้อผิดพลาด
      _showAlertDialog(context, "ข้อผิดพลาด", _ErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        leading: IconButton(
          onPressed: () => Navigator.pop(context, true),
          icon: Icon(IconlyLight.arrow_left_square),
        ),
      ),
      body: ListView.builder(
        // ใช้ ListView.builder สร้างรายการ
        itemCount: _cat.length, // กำหนดจำนวน item ใน list
        itemBuilder: (context, index) {
          //สร้าง item ของ list
          final cat = _cat[
              index]; // สร้างตัวแปร cat และเก็บข้อมูล _cat[index] ไว้ใน cat
          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.lightGreen.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                // กำหนดรูปร่างของ Card
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              color: Colors.white, // กำหนดสีพื้นหลังของ Card
              child: InkWell(
                onTap: () {
                  _fetchCat(); //เรียกใช้งานฟังก์ชัน _fetchCat
                },
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      // กำหนดรูปร่างของรูป
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        // แสดงรูปจาก url
                        cat['url'], // แสดงรูปจาก url ที่เก็บไว้ใน cat['url']
                        loadingBuilder: (context, child, loaddingProgress) {
                          if (loaddingProgress ==
                              null) // ถ้า loaddingProgress เป็น null
                            return child;
                          else {
                            return Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.lightGreen),
                              ),
                            );
                          }
                        },
                        width: double.infinity,
                        height: 250, // กำหนดความสูงของรูป
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            "Cat & Dog",
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
