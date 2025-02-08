import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:testapi/components/doc/doc_view.dart';

class Doc extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // กดปุ่ม onPressed แล้ว Drewer ไม่ทำงาน

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(context),
      body: Doc_View(),
      drawer: Drawer(
        elevation: 10.0, //เพิ่มเงา
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: const Text("Code Project"),
              accountEmail: const Text("เรียนรู้การเขียนโค้ต"),
              decoration: const BoxDecoration(color: Colors.lightGreen),
              currentAccountPicture: Container(
                child:
                    Image(image: AssetImage("./android/assets/image/app.png")),
              ),
            ),
            ListTile(
              title: const Text("ตั้งค่า"),
              onTap: () {
                Navigator.pop(context); // ปิด Drawer ถอนหลัง 1 ค่า
              },
              leading: Icon(IconlyBold.setting),
              trailing: Icon(IconlyLight.arrow_right_circle),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: const Text("เกี่ยวกับระบบ"),
              onTap: () {
                Navigator.pop(context); // ปิด Drawer ถอนหลัง 1 ค่า
              },
              leading: Icon(IconlyBold.star),
              trailing: Icon(IconlyLight.arrow_right_circle),
            ),
            Divider(
              height: 10,
            ),
            ListTile(
              title: const Text("ออกจากระบบ"),
              onTap: () {
                _exitAlertDialog(context); // ออกจากแอพ
              },
              leading: Icon(IconlyBold.logout),
              trailing: Icon(IconlyLight.arrow_right_circle),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(IconlyBold.category),
        color: Colors.white,
        onPressed: () =>
            _scaffoldKey.currentState?.openDrawer(), //เปิดตัว Drawer
      ),
      centerTitle: true,
      title: Text(
        "Doc",
        style: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.lightGreen.withAlpha(153),
      actions: [
        IconButton(
          icon: Icon(IconlyBold.logout),
          color: Colors.white,
          onPressed: () => _exitAlertDialog(context), //ปิดแอป
        ),
      ],
    );
  }

  void _exitAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "ออกจากระบบ !!!",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                  fontFamily: "Alike",
                  fontWeight: FontWeight.w500),
            ),
            content: Text(
              "คุณต้องการออกจากระบบหรือไม่ ?",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: "Alike",
                  fontWeight: FontWeight.w500),
            ),
            actions: <Widget>[
              Row(
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.red)),
                    child: Text(
                      "ไม่",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Alike",
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () =>
                        Navigator.pop(context, true), // ถ้อยหลัง 1 ค่า
                  ),
                  Spacer(), // เพื่อดันปุ่มไปชิดขวา
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll<Color>(Colors.green)),
                    child: Text(
                      "ใช่",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Alike",
                          fontWeight: FontWeight.w500),
                    ),
                    onPressed: () => exit(0), // ถ้อยหลัง 1 ค่า
                  )
                ],
              )
            ],
          );
        });
  }
}
