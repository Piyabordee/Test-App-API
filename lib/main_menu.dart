import 'dart:io';

import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:testapi/components/doc/doc.dart';
import 'package:testapi/components/home/home.dart';
import 'package:testapi/components/map/map.dart';
import 'package:testapi/components/video/video.dart';

class Main_Menu extends StatefulWidget {
  const Main_Menu({super.key});

  @override
  State<Main_Menu> createState() => _Main_MenuState();
}

class _Main_MenuState extends State<Main_Menu> {
  var _scelectedIndex = 0; //หน้าเริ่มต้น

  final List<Widget> _pages = [
    Home(), //index=0
    Doc(), //index=1
    Map(), //index=2
    Video(), //index=3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _scelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final _Exit = await showDialog<bool>(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "ออกจากระบบ",
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
                          Navigator.pop(context, false), // ถ้อยหลัง 1 ค่า
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
            ),
          );
          return _Exit ?? false; //ถ้าไม่มีการกดปุ่มใดๆ ให้คืนค่า false
        },
        child: Scaffold(
          body: _pages[_scelectedIndex], //แสดงผลหน้าแรก
          bottomNavigationBar: CrystalNavigationBar(
            backgroundColor: Colors.lightGreen.withAlpha(153),
            items: <CrystalNavigationBarItem>[
              CrystalNavigationBarItem(
                  icon: IconlyBold.home,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.black38,
                  unselectedIcon: IconlyLight.home),
              // index =0;
              CrystalNavigationBarItem(
                  icon: IconlyBold.document,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.black38,
                  unselectedIcon: IconlyLight.document),
              // index =1;
              CrystalNavigationBarItem(
                  icon: IconlyBold.video,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.black38,
                  unselectedIcon: IconlyLight.video),
              // index =2;
              CrystalNavigationBarItem(
                  icon: IconlyBold.location,
                  selectedColor: Colors.white,
                  unselectedColor: Colors.black38,
                  unselectedIcon: IconlyLight.location),
              // index =3;
            ],
            onTap: _onItemTapped,
            currentIndex: _scelectedIndex,
          ),
        ));
  }
}
